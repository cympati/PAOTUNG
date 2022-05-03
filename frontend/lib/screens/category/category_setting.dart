import 'package:flutter/material.dart';
import 'package:paotung_frontend/widgets/common/close_app_bar.dart';

class CategorySettings extends StatelessWidget {
  const CategorySettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(
        title: 'New Category',
      ),
    );
  }
}
