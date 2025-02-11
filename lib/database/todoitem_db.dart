import 'package:objectbox/objectbox.dart';
import 'package:todolist_again/database/folder_db.dart';
import 'package:todolist_again/objectbox.g.dart';

@Entity()
class TodoItem{
  @Id()
  int id = 0;
  String text;
  bool isComplete;

 
  final folder = ToOne<Folderdata>();

  TodoItem({
    required this.text,
     this.isComplete = false,
  });

}