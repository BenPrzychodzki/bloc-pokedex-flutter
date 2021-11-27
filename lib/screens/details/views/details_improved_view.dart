import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../details_bloc.dart';
import '../details_event.dart';
import '../details_state.dart';

/// View shown after clicking on a grid view item.
class DetailsView extends StatelessWidget {
  final List<Color?> typeColors;
  const DetailsView({Key? key, required this.typeColors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () {
          BlocProvider.of<DetailsBloc>(context).add(CloseDetailsPopup());
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: typeColors.first,

          body: _buildDetailsViewBody(width, height),
        ));
  }

  BlocBuilder<DetailsBloc, DetailsState?> _buildDetailsViewBody(double appWidth, double appHeight) {
    return BlocBuilder<DetailsBloc, DetailsState?>(
      builder: (context, state) {
        return Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  width: appWidth,
                  height: appHeight * 0.6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                ),
              ),
              if (state is DetailsLoadingSuccess) ...[
                Positioned(
                    top: appHeight * 0.32,
                    left: (appWidth / 2) - 50,
                    child: Hero(tag: "details/${state.pokemon.id}",
                    child: Image.network(state.pokemon.imageUrl))
                ),
                Positioned(
                    top: appHeight * 0.50,
                    left: (appWidth / 2) - 50,
                    child: Text(state.pokemon.name)),
                Positioned(
                    top: appHeight * 0.55,
                    child: Text(state.pokemon.name)),
                Positioned(
                    top: appHeight * 0.6,
                    left: (appWidth / 2) - 50,
                    child: Text(state.pokemon.name)),
                Positioned(
                    top: appHeight * 0.65,
                    left: (appWidth / 2) - 50,
                    child: Text(state.pokemon.name)),
              ]

            ]
        );
      }
      );



      //   BlocBuilder<DetailsBloc, DetailsState?>(builder: (context, state) {
      //   if (state is LoadingDetailsState) {
      //     return const Center(
      //         child: SpinKitFadingCube(
      //           color: Colors.red,
      //         ));
      //   } else if (state is DetailsLoadingSuccess) {
      //     return Hero(
      //       tag: "details/${state.pokemon.id}",
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           SizedBox(
      //               width: 150,
      //               height: 150,
      //               child: Image.network(state.pokemon.imageUrl)),
      //           const SizedBox(height: 15),
      //           Text(capitalize(state.pokemon.name),
      //               style: const TextStyle(fontWeight: FontWeight.bold)),
      //           const SizedBox(height: 5),
      //           Text("ID: ${state.pokemon.id}",
      //               style: const TextStyle(color: Colors.grey)),
      //           const SizedBox(height: 15),
      //           Text(_getTypesString(state.pokemon.types)),
      //           const SizedBox(height: 10),
      //           Text(
      //             state.pokemon.description,
      //             textAlign: TextAlign.center,
      //             style: const TextStyle(fontStyle: FontStyle.italic),
      //           ),
      //           const SizedBox(height: 10),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               Text("Weight: ${state.pokemon.weight / 10} kg"),
      //               Text("Height: ${state.pokemon.height * 10} cm")
      //             ],
      //           ),
      //         ],
      //       ),
      //     );
      //   } else if (state is DetailsLoadingFailure) {
      //     return Text(state.error);
      //   } else {
      //     return Container();
      //   }
      // }),

  }

  /// Combine types list to string.
  String _getTypesString(List<String> types) {
    String typesString = "";
    for (String element in types) {
      typesString += "   ${capitalize(element)}";
    }
    return typesString;
  }

  /// Used for capitalize strings (e.g. pokemon names)
  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }
    return string[0].toUpperCase() + string.substring(1);
  }
}
