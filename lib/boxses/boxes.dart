import 'package:hive_flutter/hive_flutter.dart';

import '../method/data.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
}
