import '../../../core/models/item.dart';

enum Pipe {
  none,
  horizontal,
  vertical,
  bend,
  junction;
}

typedef Record = ({Item item, List<Pipe> pipes});
typedef Metadata = ({int depth, List<Record> records});
