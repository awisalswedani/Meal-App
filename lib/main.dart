import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meal_screen.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactos": false,
    "vegan": false,
    "vegetarian": false,
  };
  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> _filterData){
    setState(() {
      _filters = _filterData;
      _availableMeal  = DUMMY_MEALS.where((meal) {
        if (_filters["gluten"] == true && meal.isGlutenFree == false){
          return false;
        };
        if (_filters["lactos"] == true && meal.isLactoseFree == false){
          return false;
        }
        if (_filters["vegan"] == true && meal.isVegan == false){
          return false;
        }
        if (_filters["vegetarian"] == true && meal.isVegetarian == false){
          return false;
        }
        return true;
      }).toList();
    });
  }

void _toggleFavorite (String mealId){
  final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

  if(existingIndex >= 0){
    setState(() {
      _favoriteMeals.removeAt(existingIndex);
    });
  }

  else{
    setState(() {
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    });
  }
}
  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: MyHomePage(),

      routes: {
        "/": (context) => TabsScreen(_favoriteMeals),
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(_availableMeal),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite , _isMealFavorite),
        FiltersScreen.routeName: (context) => FiltersScreen(_filters , _setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal App"),
      ),
      body: null,
    );
  }
}
