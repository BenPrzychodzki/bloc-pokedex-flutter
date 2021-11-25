import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/screens/details/details_bloc.dart';
import 'package:pokedex_app/screens/details/details_event.dart';
import 'package:pokedex_app/screens/details/details_state.dart';
import 'package:pokedex_app/screens/details/views/details_view.dart';
import '../pokemonlist_bloc.dart';
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
      body: BlocListener<DetailsBloc, DetailsState?>(
        listener: (context, state) {
          if (state is DetailsPageInitial) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<DetailsBloc>(context)
                        ..add(LoadDetailsPopupData(pokemonId: state.pokemonId)),
                      child: DetailsView(),
                    )));
          }
        },
        child: BlocBuilder<PokemonListBloc, PokemonListState>(
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
      ),
    );
  }

  GridView _pokemonGridView(PokemonListLoadSuccess state) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: state.pokemonList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => BlocProvider.of<DetailsBloc>(context).add(
                ShowDetailsPopupEvent(pokemonId: state.pokemonList[index].id)),
            child: Hero(
              tag: 'details/${state.pokemonList[index].id}',
              child: Card(
                child: GridTile(
                  child: Column(
                    children: [
                      Image.network(state.pokemonList[index].imageUrl),
                      Text(state.pokemonList[index].name)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
