import '../../../core/models/company.dart';
import '../../../core/models/item.dart';
import '../../../core/node.dart';
import '../models/asset.dart';
import '../models/component.dart';
import '../models/location.dart';
import 'fetch_assets_usecase.dart';
import 'fetch_locations_usecase.dart';

abstract class IGetItemTreeUsecase {
  Future<Node<Item>> call({
    required Company company,
  });
}

class GetItemTreeUsecase implements IGetItemTreeUsecase {
  final IFetchAssetsUsecase fetchAssetsUsecase;
  final IFetchLocationsUsecase fetchLocationsUsecase;

  GetItemTreeUsecase(
    this.fetchAssetsUsecase,
    this.fetchLocationsUsecase,
  );

  @override
  Future<Node<Item>> call({
    required Company company,
  }) async {
    final locations = await fetchLocationsUsecase(
      companyId: company.id,
    );

    final (:assets, :components) = await fetchAssetsUsecase(
      companyId: company.id,
    );

    //

    final nodes = <String?, Node<Item>>{};

    final items = [...locations, ...assets, ...components];

    // ignore: prefer_const_constructors
    nodes[null] = Node(value: company, children: []);

    for (var item in items) {
      nodes[item.id] = Node(value: item, children: []);
    }

    for (var item in items) {
      String? parentId;

      if (item is Company) {
        // TODO: Remove this check
      } else if (item is Location) {
        parentId ??= item.parentId;
      } else if (item is Asset) {
        parentId ??= item.parentId;
        parentId ??= item.locationId;
      } else if (item is Component) {
        parentId ??= item.parentId;
        parentId ??= item.locationId;
      }

      nodes[parentId]!.children.add(nodes[item.id]!);
    }

    return nodes[null]!;
  }
}
