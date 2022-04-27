import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class listItem extends StatelessWidget {

  final String title;
  final Widget routes;

  const listItem({ Key? key, required this.title, required this.routes }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => routes));
            },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.lightgrey)
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal, color: Colors.black, decoration: TextDecoration.none)),
                const Icon(Icons.navigate_next_rounded),
              ],
            ),
          ),
        ),
    );
  }
}