import '../main_drawer.dart';
import './favorites_screen.dart';
import './filters_screens.dart';
import './categories_screen.dart';
import 'package:flutter/material.dart';
import '../meal.dart';

class TabBarScreen extends StatefulWidget {
  final List favoriteMeals;
  TabBarScreen(this.favoriteMeals);
  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  // ignore: prefer_final_fields
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        'pages': Categories_screen(),
        'title': 'Categories',
      },
      {
        'pages ': FavoritesScreen(widget.favoriteMeals),
        'title': 'Your Favorites',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        //DefaultTabController(
        //length: 2,
        // initialIndex: 0,
        Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        //   bottom: TabBar(
        //     tabs: [
        //       // ignore: prefer_const_constructors
        //       Tab(
        //         icon: Icon(
        //           Icons.category,
        //         ),
        //         text: 'Categeories',
        //       ),
        //       Tab(
        //         icon: Icon(
        //           Icons.star,
        //         ),
        //         text: 'Favourites',
        //       ),
        //     ],
        //   ),
      ),
      drawer: MainDrawer(),
      body: (_pages[_selectedPageIndex]['pages']),
      // TabBarView(
      // children: [
      //   Categories_screen(),
      //   FavouritesScreen(),
      // ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        //type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.category),
            // title: const Text('Category'),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.star),
            // title: const Text('Favorites'),
          ),
        ],
      ),
    );
  }
}
