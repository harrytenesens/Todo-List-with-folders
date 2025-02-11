

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todolist_again/database/folder_db.dart';

class TodoFolderModel extends StatelessWidget {
  const TodoFolderModel(
      {super.key,
      required this.onTap,
      required this.folderdata,
      required this.onDelete});

  final void Function()? onTap;
  final Folderdata folderdata;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Material(
          child: InkWell(
            
            splashColor: const Color.fromARGB(64, 33, 149, 243),
            onTap: onTap,
            child: Ink(
              
              child: Stack(
                
                children: <Widget>[
                  // image
                  Ink.image(
                    width: 400,
                    height: 150,
                    // child: Image.file(File(folderdata.fPicture),
                    image: FileImage(File(folderdata.fPicture)) , fit: BoxFit.cover,
                  ),
                      
                  // transparent gradient
                  Container(
                    width: 400,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                  //title
                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          folderdata.text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  // delete button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: onDelete,
                      child: const Icon(Icons.delete),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
