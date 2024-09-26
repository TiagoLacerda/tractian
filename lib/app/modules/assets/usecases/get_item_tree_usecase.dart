import '../../../core/node.dart';
import '../models/asset.dart';
import '../models/component.dart';
import '../models/item.dart';
import 'fetch_assets_usecase.dart';
import 'fetch_locations_usecase.dart';

abstract class IGetItemTreeUsecase {
  Future<Node<Item?>> call({
    required String companyId,
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
  Future<Node<Item?>> call({
    required String companyId,
  }) async {
    final locations = await fetchLocationsUsecase(
      companyId: companyId,
    );

    final (:assets, :components) = await fetchAssetsUsecase(
      companyId: companyId,
    );

    //

    final nodes = <String?, Node<Item?>>{};

    // ignore: prefer_const_constructors
    nodes[null] = Node(value: null, children: []);

    final items = [...locations, ...assets, ...components];

    for (var item in items) {
      nodes[item.id] = Node(value: item, children: []);
    }

    for (var item in items) {
      String? parentId;

      if (item.parentId != null) {
        parentId = item.parentId;
      } else if (item is Asset && item.locationId != null) {
        parentId = item.locationId;
      } else if (item is Component && item.locationId != null) {
        parentId = item.locationId;
      }

      nodes[parentId]!.children.add(nodes[item.id]!);
    }

    return nodes[null]!;
  }
}
