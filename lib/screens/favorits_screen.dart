import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritsScreen extends StatelessWidget {

  final List<Meal> favoriteMeal;
  

  FavoritsScreen( this.favoriteMeal);

  @override
  Widget build(BuildContext context) {

    if (favoriteMeal.isEmpty) {
      return Center(
      child: Text("You have no Favorites yet - start  adding some !"),
    );
    }
    else{
      return ListView.builder(
        itemBuilder:(ctx , index){
          return MealItem(
            id: favoriteMeal[index].id,
            imageUrl: favoriteMeal[index].imageUrl,
            title: favoriteMeal[index].title,
            duration: favoriteMeal[index].duration,
            complexity: favoriteMeal[index].complexity,
            affordability: favoriteMeal[index].affordability,
          );
        } ,
        itemCount: favoriteMeal.length,
      );
    }
    
  }
}