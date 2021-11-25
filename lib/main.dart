import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/screens/details/details_bloc.dart';
import 'package:pokedex_app/screens/pokemonlist/pokemonlist_bloc.dart';
import 'package:pokedex_app/screens/pokemonlist/pokemonlist_event.dart';
import 'package:pokedex_app/screens/pokemonlist/views/pokedex_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  PokemonListBloc()..add(PokemonDataRequest(page: 0)),
              // we have to invoke event to not be stuck in initial state
            ),
            BlocProvider(create: (context) => DetailsBloc())
          ], // allows us to call events from PokemonListBloc
          child: PokedexListView()),
    );
  }
}
