import 'package:flutter/material.dart';

class TodoElement extends StatelessWidget {
  const TodoElement({super.key, required this.todoText, required this.value, required this.onChanged, required this.onDelete});

  final String todoText;
  final bool value;
  final void Function(bool?)? onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onLongPress: onDelete,

          child: Ink(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CheckboxListTile(
              
              title:  Text(todoText, style: TextStyle(color: Colors.white),),
              controlAffinity: ListTileControlAffinity.leading,
              value: value,
              onChanged: onChanged,
            ),
            
          ),
        ),
        SizedBox(height: 15),
      ],
    );
    
  }
}