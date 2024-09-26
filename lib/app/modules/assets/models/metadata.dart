import 'item.dart';

enum Pipe {
  none,
  straight,
  bend,
  junction;
}

typedef Record = ({Item item, List<Pipe> pipes});
typedef Metadata = ({int depth, List<Record> records});
