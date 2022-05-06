import 'package:deli_meal/models/category_item.dart';
import 'package:flutter/material.dart';
import '../dummy_data.dart';
import 'tab_bar_screen.dart';

class Categories_screen extends StatelessWidget {
  //const name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: AppBar(
        //     title: Text('Delimeals'),
        //   ),
        //   body:
        GridView(
      padding: EdgeInsets.all(10),
      children: Dummy_Categories.map(
        (catData) => CategoryItem(
          catData.id,
          catData.title,
          catData.color,
        ),
      ).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        // ),
      ),
    );
  }
}
