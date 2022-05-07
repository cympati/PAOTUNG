import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class NotificationTitle extends StatelessWidget {
  final String name;
  const NotificationTitle({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 0, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.lightgrey))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 0),
            child: Row(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                  onPressed: () => print("delete this notification"),
                ),
              ],
            ),
          ),
        ));
  }
}
