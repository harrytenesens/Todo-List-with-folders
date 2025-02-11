import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_again/button_blueprints_methods/add_folder.dart';
import 'package:todolist_again/button_blueprints_methods/first_screen_methods.dart';

import 'package:todolist_again/todo_blueprints/todo_folder_model.dart';
import 'package:todolist_again/todolist/todolist_homescreen.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {

    void goToTaskpage(int index, String foldername) {
  Navigator.push(
    context,
    MaterialPageRoute(
      // builder: (context) =>  TodolistHomescreen(folderName: foldername,),
      builder: (context) => TodolistHomescreen(folder: Provider.of<FirstScreen>(context, listen: false).folderLists[index]),
    ),
  );
}


    return Consumer<FirstScreen>(
      builder: (context, firstScreen, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: firstScreen.folderLists.length,
                    itemBuilder: (buildContext, int index) {
                      final folder = firstScreen.folderLists[index];
                      return TodoFolderModel(

                        onTap: () => goToTaskpage(index ,folder.text),
                        folderdata: folder,
                        onDelete: () => firstScreen.deleteFolder(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              addFolder(context,
                  imageSelectf: firstScreen.pickImageFromGallary);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
