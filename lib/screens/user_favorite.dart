import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/card.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/services/database.dart';

class UserFavourites extends StatefulWidget {
  const UserFavourites({Key? key}) : super(key: key);

  @override
  State<UserFavourites> createState() => _UserFavouritesState();
}

class _UserFavouritesState extends State<UserFavourites> {
  Future<List<Recipe>> getFavouriteRecipes(String userId) async {
    List<Recipe> favouriteRecipes =
        await DatabaseService.getFavouriteRecipes(userId);
    return favouriteRecipes;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return FutureBuilder(
      future: getFavouriteRecipes(user.userId),
      builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        if (snapshot.hasData) {
          List<Recipe> favouriteRecipes = snapshot.data ?? [];

          return Scaffold(
            appBar: AppBar(
              title: const AppbarTitle(title: 'Favourites'),
            ),
            body: favouriteRecipes.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Add your favourite recipes here for easy access',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: favouriteRecipes.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          FoodCard(favouriteRecipes[index], type: 'fav'),
                          const SizedBox(height: 30.0),
                        ],
                      );
                    },
                  ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const AppbarTitle(title: 'Favourites'),
            ),
            body: const Center(
              child: Text('No data'),
            ),
          );
        }
      },
    );

    // return StreamBuilder(
    //   stream: DatabaseService(userId: user.userId).userData,
    //   builder: (context, AsyncSnapshot<UserData> snapshot) {
    //     if(snapshot.connectionState == ConnectionState.waiting){
    //       return const Loading();
    //     }
    //     if(snapshot.hasError){
    //       return Center(child: Text('Sorry, an error occured, ${snapshot.hasError}'),);
    //     }
    //     if(snapshot.hasData){
    //       UserData userData = snapshot.data!;

    //       return FutureBuilder(
    //         future: getFavouriteRecip(user.userId),
    //         builder: (context, AsyncSnapshot<List<Recipe>> snapshot){
    //           if(snapshot.connectionState == ConnectionState.waiting){
    //             return const Loading();
    //           }

    //           List<Recipe> favouriteRecipes = snapshot.data ?? [];

    //           return Scaffold(
    //             appBar: AppBar(
    //               title: const AppbarTitle(title: 'Favourites'),
    //             ),
    //             body: Column(
    //               children: [
    //                 Expanded(
    //                   child: ListView.builder(
    //                     itemCount: (favouriteRecipes.isEmpty)? 1 : favouriteRecipes.length,
    //                     itemBuilder: (_, index) {
    //                       if(favouriteRecipes.isNotEmpty){
    //                         // return Column(
    //                         //   children: [
    //                         //     Text('recipe id: ${userData.favourites![index]}'),
    //                         //   ],
    //                         // );
    //                         return FoodCard(favouriteRecipes[index], type: 'detail', userId: user.userId);
    //                       }else{
    //                         return Container(
    //                           height: MediaQuery.of(context).size.height,
    //                           child: const Center(
    //                             child: Text('Add your favourite recipes here for easy access',
    //                               style: TextStyle(fontSize: 18.0),
    //                             )
    //                           ),
    //                         );
    //                       }
    //                     }
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         }
    //       );
    //     }else{
    //       return Scaffold(
    //         appBar: AppBar(
    //           title: const AppbarTitle(title: 'Favourites'),
    //         ),
    //         body: const Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Center(child: Text('Empty'),)
    //           ],
    //         ),
    //       );
    //     }
    //   }
    // );
  }
}
