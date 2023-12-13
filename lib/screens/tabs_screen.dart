import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import '../models/meal.dart';
import 'categories_screen.dart';
import 'favorits_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeal;

  TabsScreen(this.favoriteMeal);
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selctPageIndex = 0;
  @override
  void initState() {
    _pages =  [
    {
      "Page" : CategoriesScreen(),
      "title" : "Categories",
    },
    {
      "Page" : FavoritsScreen(widget.favoriteMeal),
      "title" : " Your Favorites",
    }
  ];
    super.initState();
  }
  void _selctPage(int value) {
    setState(() {
      _selctPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selctPageIndex]["title"]),
      ),
      body: _pages[_selctPageIndex]["Page"],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selctPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selctPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            label: "categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: "Favorits",
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
