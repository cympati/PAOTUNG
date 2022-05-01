// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/widgets/category/category_box.dart';

class DropdownButtons extends StatelessWidget {
  final String title;
  var item;
  final onChanged;
  final String hinttext;
  var value;
  DropdownButtons({
    Key? key,
    required this.title,
    required this.item,
    required this.onChanged,
    required this.hinttext,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            DropdownButtonFormField(
              items: item,
              onChanged: onChanged,
              hint: Text(
                hinttext,
                style: TextStyle(fontSize: 10),
              ),
              value: value,
            )
          ],
        ),
      ),
    );
  }
}

// class ColorPicker extends StatelessWidget {
 
//   final String title;
//   const ColorPicker({Key? key,  required this.title})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.centerLeft,
//       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//       child: Form(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title),
//             RowField(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RowField extends StatefulWidget {
//   const RowField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<RowField> createState() => _RowFieldState();
// }

// class _RowFieldState extends State<RowField> {
//   void changeColor(Color color) {
//     setState(() {
//       pickerColor = color;
//     });
//   }

//   Color color = AppColors.mainColor;
//   Color pickerColor = AppColors.secondaryColor;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.centerRight,
//       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//       child: Row(
//         children: [
//           Row(
//             children: [
//               ColorDots(color: pickerColor),
//               TextFormField(
//                 decoration: InputDecoration(
//                     focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey))),
//               ),
//               IconButton(
//                 icon: Icon(Icons.arrow_drop_up_outlined),
//                 onPressed: () {
//                   showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text('Pick a color!'),
//                           content: SingleChildScrollView(
//                             child: BlockPicker(
//                               pickerColor: pickerColor,
//                               onColorChanged: changeColor,
//                             ),
//                           ),
//                           actions: <Widget>[
//                             ElevatedButton(
//                               child: const Text('DONE'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             )
//                           ],
//                         );
//                       });
//                 },
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
