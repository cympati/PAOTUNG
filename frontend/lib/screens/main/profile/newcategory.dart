import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/screens/main/profile/categorysetting.dart';
import 'package:paotung_frontend/widgets/category/categorycolormodel.dart';
import 'package:paotung_frontend/widgets/common/button.dart';
import 'package:paotung_frontend/widgets/common/customappbar.dart';
import 'package:paotung_frontend/widgets/common/dropdownbuttonformfield.dart';
import 'package:paotung_frontend/widgets/common/text_field.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({Key? key}) : super(key: key);

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  Color mycolor = Colors.lightBlue;
  var _categoryval;
  List _types = ['Expense', 'Income'];
  var _colorval;
  List _categorycolor = [
    'Red',
    'Pink',
    'Purple',
    'Indigo',
    'Light-blue',
    'Teal',
    'Green',
    'Light-green',
    'Lime',
    'Yellow',
    'Amber',
    'Orange'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(title: "New Category"),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          textInputField(title: "Category", obscure: false),
          DropdownButtons(
            title: "Transaction type",
            hinttext: "please select one",
            value: _categoryval,
            onChanged: (value) {
              setState(() {
                _categoryval = value;
              });
            },
            item: _types.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(context: context, 
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: BlockPicker(
                      pickerColor: mycolor,
                      onColorChanged: (Color color) {
                        setState(() {
                          mycolor = color;
                        });
                      },
                    ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                         child: const Text('DONE'),
                         onPressed: () {
                           Navigator.of(context).pop();
                         },
                         )
                    ],
                  );
                
              });
            }, child: null,
          ),
          // DropdownButtons(
          //   title: "Color",
          //   hinttext: "please select one",
          //   value: _colorval,
          //   onChanged: (value) {
          //     setState(() {
          //       _colorval = value;
          //     });
          //   },
          //   item: _categorycolor.map((value) {
          //     return DropdownMenuItem(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          // ),
          Spacer(),
          RoundedButton(
              text: "Add",
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => CategorySetting()));
              },
              color: AppColors.mainColor,
              textColor: Colors.white)
        ],
      ),
    );
  }
}
