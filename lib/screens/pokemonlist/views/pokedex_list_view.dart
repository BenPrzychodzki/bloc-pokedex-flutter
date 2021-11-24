import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/screens/pokemonlist/pokemonlist_bloc.dart';
import '../pokemonlist_state.dart';

class PokedexListView extends StatelessWidget {
  const PokedexListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pokedex"),
        backgroundColor: Colors.red,
      ),
      body: BlocBuilder<PokemonListBloc, PokemonListState>(
        builder: (context, state) {
          if (state is PokemonListLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PokemonListLoadSuccess) {
            return _pokemonGridView(state);
          } else if (state is PokemonListLoadFail) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  GridView _pokemonGridView(PokemonListLoadSuccess state) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: state.pokemonList.length,
        itemBuilder: (context, index) {
          return Card(
            child: GridTile(
              child: Column(
                children: [
                  Image.network(state.pokemonList[index].imageUrl),
                  Text(state.pokemonList[index].name)
                ],
              ),
            ),
          );
        });
  }
}
