import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/screens/capitalize.dart';
import 'package:pokedex_app/screens/details/details_bloc.dart';
import 'package:pokedex_app/screens/details/details_event.dart';
import 'package:pokedex_app/screens/details/details_state.dart';
import 'package:pokedex_app/screens/details/views/details_improved_view.dart';
import 'package:pokedex_app/screens/details/views/details_view.dart';
import '../../type_to_color.dart';
import '../pokemonlist_bloc.dart';
import '../pokemonlist_state.dart';

class PokedexListView extends StatelessWidget {
  const PokedexListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pokedex"),
        backgroundColor: Colors.red,
      ),
      // Listen for DetailsBloc state changes (happen when user clicks tile on a grid view)
      body: BlocListener<DetailsBloc, DetailsState?>(
        listener: (context, state) {
          if (state is DetailsPageInitial) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<DetailsBloc>(context)
                        ..add(LoadDetailsPopupData(pokemonId: state.pokemonId)),
                      child: DetailsView(typeColors: typeToColor(state.types)),
                    )));
          }
        },
        // Build UI depending on current PokemonListState
        child: BlocBuilder<PokemonListBloc, PokemonListState>(
          builder: (context, state) {
            if (state is PokemonListLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PokemonListLoadSuccess) {
              return _pokemonGridView(state);
            } else if (state is PokemonListLoadFail) {
              return Center(
                child: Text("error: ${state.error}"),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  /// Return grid view with Pokemon populated with data from a state.
  GridView _pokemonGridView(PokemonListLoadSuccess state) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: state.pokemonList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => BlocProvider.of<DetailsBloc>(context).add(
                ShowDetailsPopupEvent(
                    pokemonId: state.pokemonList[index].id,
                    types: state.pokemonList[index].types)),
            child: Card(
              color: typeToColor(state.pokemonList[index].types).first,
              child: GridTile(
                child: Column(
                  children: [
                    Hero(
                        tag: 'details/${state.pokemonList[index].id}',
                        child: CachedNetworkImage(
                            imageUrl: state.pokemonList[index].imageUrl)),
                    Stack(children: [
                      Text(capitalize(state.pokemonList[index].name),
                          style: TextStyle(
                            fontSize: 20,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Colors.black,
                          )),
                      Text(capitalize(state.pokemonList[index].name),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                    ])
                  ],
                ),
              ),
            ),
          );
        });
  }
}
