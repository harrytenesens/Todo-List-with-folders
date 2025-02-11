import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todolist_again/database/folder_db.dart';
import 'package:todolist_again/database/todoitem_db.dart';
import 'package:todolist_again/objectbox.g.dart';

class FirstScreen extends ChangeNotifier {

  late final Store store;
  late final Box<Folderdata> folderStoreBox;
  // the folder lists
  List<Folderdata> folderLists = [];

  Folderdata? folderdata;

  XFile? pickedImage;


  Future<void> initialize() async {
    final docsDir = await getApplicationDocumentsDirectory();
    store = await openStore(directory: path.join(docsDir.path, "folderdata")); // this creates a folder called object box where the data is saved
    folderStoreBox = store.box();
    loadfolderlists();
  }

  void loadfolderlists(){
    folderLists = folderStoreBox.getAll();
    notifyListeners();
  }





// setting image
  void settingImage({required String controllerText}) {
    if (pickedImage == null) return; // Ensure image is selected

    // Create a new Folderdata instance
    final newFolder = Folderdata(
      text: controllerText,
      fPicture: pickedImage!.path,
    );

    folderStoreBox.put(newFolder);

    // folderLists.add(newFolder); // Add to the list
   loadfolderlists();

  }

    // deleting folder
  void deleteFolder(int index) {
  final folder = folderLists[index];
  
  // Get all todos for this folder and delete them first
  final query = store.box<TodoItem>().query(TodoItem_.folder.equals(folder.id)).build();
  final todos = query.find();

  // store.box<TodoItem>().removeMany(todos.map((todo) => todo.id).toList());
  List<int> idtoDelete = [];
  for (var todo in todos){
    idtoDelete.add(todo.id);
  }

  store.box<TodoItem>().removeMany(idtoDelete);
  
  // Then delete the folder
  folderStoreBox.remove(folder.id);
  
  // Clean up
  query.close();
  loadfolderlists();
}
  // void deleteFolder(int index) {
  //   final folder = folderLists[index];
  //   folderStoreBox.remove(folder.id);
  //   loadfolderlists();
  // }



  Future pickImageFromGallary() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    notifyListeners();
  }
}
