import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/card.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/services/database.dart';
// import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class FilteredResult extends StatefulWidget {

  final String type;
  final String filter;
  final String title;
  const FilteredResult({required this.type, required this.filter, required this.title, super.key});

  @override
  State<FilteredResult> createState() => _FilteredResultState();
}

class _FilteredResultState extends State<FilteredResult> {

  bool loading = false;

  // void fetchedFilteredRecipes () async {
  //   // RecipeStore recipeStore = Provider.of<RecipeStore>(context, listen: false);
  //   setState(() => loading = true);
  //   bool isSuccess = await Provider.of<RecipeStore>(context, listen: false).fetchFilteredRecipes(widget.type, widget.filter);
  //   if(isSuccess == true){
  //     setState(() => loading = false);
  //     print('list');
  //   }else{
  //     setState(() => loading = false);
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Sorry we could not find recipes for that category.'),
  //       duration: Duration(seconds: 3),
  //       backgroundColor: Color(0xFF86BF3E),
  //     ));
  //     print('empty');
  //   }
  // }

  @override
  void initState() {
    // fetchedFilteredRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return loading? const Loading() : Scaffold(
    //   appBar: AppBar(
    //     title: const AppbarTitle(title: 'Filtered Results'),
    //   ),
    //   body: Container(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       children: [
    //         Text('${widget.filter}, ${widget.type}'),
    //         Expanded(
    //           child: Consumer<RecipeStore>(
    //             builder: (context, value, child) {
    //               if(value.filteredRecipes.isEmpty){
    //                 return const Loading();
    //               }else{
    //                 return ListView.builder(
    //                   itemCount: value.filteredRecipes.length,
    //                   itemBuilder: (_, index) {
    //                     return Column(
    //                       children: [
    //                         FoodCard(value.filteredRecipes[index], type: 'detail',),
    //                         const SizedBox(height: 30.0,)
    //                       ],
    //                     );
    //                   },
    //                 );
    //               }
    //             },
    //           ),
    //         )
    //       ],
    //     ),
    //   )
    // );

    return StreamBuilder<List<Recipe>> (
      stream: DatabaseService.getFilteredRecipes(widget.type, widget.filter),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Loading();
        }
        if(snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.hasError}'),);
        }
        // final List<Recipe> recipes = snapshot.data!;
        final List<Recipe> recipes = snapshot.data ?? []; //empty list if data is null
        if(recipes.isNotEmpty){
          return Scaffold(
            appBar: AppBar(
              title: AppbarTitle(title: widget.title),
            ),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Text('${widget.filter}, ${widget.type}'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            FoodCard(recipes[index], type: 'detail',),
                            const SizedBox(height: 30.0,)
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }else{
          return Scaffold(
            appBar: AppBar(
              title: const AppbarTitle(title: 'Filtered results'),
            ),
            body: const Center(
              child: Text('Sorry no results were found for that category'),
            ),
          );
        }
      },
    );
  }
}