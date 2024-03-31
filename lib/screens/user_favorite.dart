import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserFavourites extends StatelessWidget {
  const UserFavourites({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

    return StreamBuilder(
      stream: DatabaseService(userId: user.userId).userData, 
      builder: (context, AsyncSnapshot<UserData> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Loading();
        }
        if(snapshot.hasError){
          return Center(child: Text('Sorry, an error occured, ${snapshot.hasError}'),);
        }
        if(snapshot.hasData){
          UserData userData = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const AppbarTitle(title: 'Favourites'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: (userData.favourites!.isEmpty)? 1 : userData.favourites!.length,
                    itemBuilder: (_, index) {
                      if(userData.favourites!.isNotEmpty){
                        return Column(
                          children: [
                            Text('recipe id: ${userData.favourites![index]}'),
                          ],
                        );
                      }else{
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                            child: Text('Add your favourite recipes here for easy access', 
                              style: TextStyle(fontSize: 18.0),
                            )
                          ),
                        );
                      }
                    }
                  ),
                ),
              ],
            ),
          );
        }else{
          return Scaffold(
            appBar: AppBar(
              title: const AppbarTitle(title: 'Favourites'),
            ),
            body: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text('Empty'),)
              ],
            ),
          );
        }
      }
    );
  }
}
