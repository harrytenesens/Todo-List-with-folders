import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_again/button_blueprints_methods/first_screen_methods.dart';

//  { required VoidCallback imageSelectf}
final folderController = TextEditingController();
const imTextWarinig = SnackBar(
  content: Text('Please select name and a image'),
);


void addFolder(
  BuildContext context, {
  required VoidCallback imageSelectf,
}) {


                             

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                            controller: folderController,
                            decoration: InputDecoration(
                              labelText: 'Add Folder Name',
                            )),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        // image button
                        child: ElevatedButton(
                          style:  ElevatedButton.styleFrom(backgroundColor: Provider.of<FirstScreen>(context, listen: true)
                                .pickedImage == null ?null: Colors.purple),
                          onPressed: imageSelectf,
                          child: Provider.of<FirstScreen>(context, listen: true)
                                .pickedImage == null ? Text('Image') : Text('Selected', style: TextStyle(color: Colors.white),),
                              
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  // cancel and save button
                  Row(
                    children: [
                      // cancel button
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            folderController.clear();
                            Provider.of<FirstScreen>(context, listen: false)
                                .pickedImage = null;
                          },
                          child: Text('Cancel')),
                      SizedBox(width: 10),
                      // save button
                      ElevatedButton(
                          onPressed: () {
                            if (Provider.of<FirstScreen>(context, listen: false)
                                .pickedImage == null || folderController.text.isEmpty) {ScaffoldMessenger.of(context).showSnackBar(imTextWarinig); } else {
                            Provider.of<FirstScreen>(context, listen: false)
                                .settingImage(
                                    controllerText: folderController.text);

                            folderController.clear();

                            Provider.of<FirstScreen>(context, listen: false)
                                .pickedImage = null;

                            Navigator.pop(context);
                                }
                          },
                          child: Text('save')),
                    ],
                  ),
                ],
              ),
            ),
          ));
}
