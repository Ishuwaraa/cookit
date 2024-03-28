import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/card.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilteredResult extends StatefulWidget {

  final String type;
  final String filter;
  const FilteredResult({required this.type, required this.filter, super.key});

  @override
  State<FilteredResult> createState() => _FilteredResultState();
}

class _FilteredResultState extends State<FilteredResult> {

  bool loading = false;

  void fetchedFilteredRecipes () async {
    RecipeStore recipeStore = Provider.of<RecipeStore>(context, listen: false);
    setState(() => loading = true);
    bool isSuccess = await recipeStore.fetchFilteredRecipes(widget.type, widget.filter);
    if(isSuccess == true){
      setState(() => loading = false);
      print('list');
    }else{
      setState(() => loading = false);
      print('empty');
    }
  }

  @override
  void initState() {
    // Provider.of<RecipeStore>(context, listen: false).fetchFilteredByDishList(widget.type, widget.filter);
    fetchedFilteredRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading? const Loading() : Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'Filtered Results'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('${widget.filter}, ${widget.type}'),
            Expanded(
              child: Consumer<RecipeStore>(
                builder: (context, value, child) {
                  if(value.filteredRecipes.isEmpty){
                    return const Loading();
                  }else{
                    return ListView.builder(
                      itemCount: value.filteredRecipes.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            FoodCard(value.filteredRecipes[index]),
                            const SizedBox(height: 30.0,)
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      )
    );
  }
}