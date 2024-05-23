import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fav_bloc.dart';
import 'fav_event.dart';
import 'fav_state.dart';
import 'favourite_item_model.dart';
import 'favourite_reposiotry.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => FavouriteBloc(FavouriteRepository()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: fav(),
        ),
    );
  }
}

class fav extends StatefulWidget {
  const fav({super.key});

  @override
  State<fav> createState() => _favState();
}

class _favState extends State<fav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavouriteBloc, FavouriteItemState>(
        builder: (context, state) {
          switch (state.listStatus) {
            case ListStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ListStatus.failure:
              return const Center(child: Text('error'));
            case ListStatus.success:
              return ListView.builder(
                // itemCount: state.favouriteList.length,
                  itemBuilder: (context, index) {
                    return ListView.builder(
                        itemCount: state.favouriteItemList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: Checkbox(value: state.tempFavouriteList.contains(state.favouriteItemList[index]) ? true : false,
                                onChanged: (bool? value) {
                                  FavouriteItemModel item = state.favouriteItemList[index];
                                  if (value!) {
                                    context.read<FavouriteBloc>().add(SelectItem(item: item));
                                  } else {
                                    context.read<FavouriteBloc>().add(UnSelectItem(item: item));
                                  }
                                },),
                              title: Text(state.favouriteItemList[index].value , style: TextStyle(
                                  decoration: state.tempFavouriteList.contains(state.favouriteItemList[index])? TextDecoration.lineThrough : TextDecoration.none  ,
                                  color: state.tempFavouriteList.contains(state.favouriteItemList[index])? Colors.red : Colors.white
                              ),),
                              trailing: IconButton(
                                onPressed: () {
                                  FavouriteItemModel item = state.favouriteItemList[index];

                                  context.read<FavouriteBloc>().add(FavouriteItem(
                                      item: FavouriteItemModel(
                                          id: item.id, isFavourite: item.isFavourite ? false : true,
                                          value: item.value
                                      )));
                                },
                                icon: Icon(state.favouriteItemList[index].isFavourite ? Icons.favorite : Icons.favorite_outline),
                              ),
                            ),
                          );
                        }
                    );
                        });
          }
        }
      ),
    );
  }
}

