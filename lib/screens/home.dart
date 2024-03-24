import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/card.dart';
import 'package:cookit/components/category_list.dart';
import 'package:cookit/components/popular_recipe_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'COOKIT'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 35.0),
            //   child: Row(
            //     children: [
            //       SafeArea(
            //         child: Image.asset(
            //           'assets/cookit-logo.png',
            //           width: 90,
            //           height: 90,
            //         ),
            //       ),
            //       Expanded(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(top: 40.0),
            //               child: IconButton(
            //                 icon: const Icon(
            //                   Icons.notifications_outlined,
            //                   size: 30,
            //                 ),
            //                 onPressed: () {
            //                   // Add your onPressed logic here
            //                 },
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            const Padding(
              padding: EdgeInsets.only(left: 35.0),
              child: Text(
                "Popular Recipes",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 270.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  PopularRecipeCard(),
                  PopularRecipeCard(),
                  PopularRecipeCard(),
                  PopularRecipeCard(),
                  PopularRecipeCard(),
                  PopularRecipeCard(),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(left: 35.0),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 10,),
            const SizedBoxListView(),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(left: 35.0),
              child: Text("Recipes", style: TextStyle(fontSize: 20),),
            ),
            const SizedBox(height: 20,),
            // FoodCard(),
            // const SizedBox(height: 30,),
            // FoodCard(),
            // const SizedBox(height: 30,),
            // FoodCard(),
            // const SizedBox(height: 30,),
            // FoodCard(),
          ],
        ),
      ),
    );
  }
}
