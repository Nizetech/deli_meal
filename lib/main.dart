import 'package:deli_meal/models/Meal.dart';

import '/models/dummy_data.dart';
// import './models/Meal.dart';
import './models/screens/filters_screens.dart';
import './models/screens/caregoty_mealScreen.dart';
import './models/screens/categories_screen.dart';
import './models/screens/meal_details_screen.dart';
import './models/screens/tab_bar_screen.dart';
import 'package:flutter/material.dart';
import './models/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = Dummy_Meals;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = Dummy_Meals.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegeterian'] && !meal.isVegetarian) {
          return false;
        }
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          Dummy_Meals.firstWhere((meal) => meal.id == meal),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false,
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Delimeals',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline1: TextStyle(
                  fontSize: 18,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
                headline2: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Quicksand',
                ),
              ),
        ),
        // home: Categories_screen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabBarScreen(_favoriteMeals),
          CategoryMealsScreen.routeName: (ctx) =>
              CategoryMealsScreen(_availableMeals),
          MealDetailScreen.routeName: (ctx) =>
              MealDetailScreen(_toggleFavorite, _isMealFavorite),
          FiltersScreen.routeName: (ctx) => FiltersScreen(
                _filters,
                _setFilters,
              ),
        },
        onGenerateRoute: (settings) {
          print(settings.arguments);
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
              builder: (ctx) => CategoryMealsScreen(_availableMeals));
        });
  }
}
