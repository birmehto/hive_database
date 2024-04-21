import 'package:hive_flutter/hive_flutter.dart';

part 'data.g.dart';
@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String discription;

  NotesModel({required this.title, required this.discription});
}
