import 'package:objectbox/objectbox.dart';
import 'package:todolist_again/database/todoitem_db.dart';



@Entity()
class Folderdata {
  @Id()
  int id = 0; // ObjectBox will automatically handle IDs

  String text;
  String fPicture;

  @Backlink()
  final todos = ToMany<TodoItem>();
 

  Folderdata({
    required this.text,
    required this.fPicture,
  });
}
