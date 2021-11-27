import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../capitalize.dart';
import '../details_bloc.dart';
import '../details_state.dart';

/// View shown after clicking on a grid view item.
class DetailsView extends StatelessWidget {
  final List<Color?> typeColors;
  const DetailsView({Key? key, required this.typeColors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Dismissible(
      resizeDuration: const Duration(milliseconds: 15),
      movementDuration: const Duration(milliseconds: 1500),
      background: Container(
        decoration: _getBackgroundDecoration(),
      ),
      secondaryBackground: Container(
        color: Colors.white,
      ),
      direction: DismissDirection.vertical,
      key: const Key('key'),
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
        //backgroundColor: typeColors.first,
        body: Container(
          decoration: _getBackgroundDecoration(),
          child: _buildDetailsViewBody(width, height),
        ),
      ),
    );
  }

  BlocBuilder<DetailsBloc, DetailsState?> _buildDetailsViewBody(
      double appWidth, double appHeight) {
    return BlocBuilder<DetailsBloc, DetailsState?>(builder: (context, state) {
      return Stack(children: [
        Positioned(
          bottom: 0,
          child: Container(
            width: appWidth,
            height: appHeight * 0.6,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: appHeight * 0.05,
                ),
                if (state is DetailsLoadingSuccess) ...[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: appWidth * 0.3,
                              child: const Text(
                                "Name: ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                          SizedBox(
                              width: appWidth * 0.3,
                              child: Text(capitalize(state.pokemon.name))),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: appWidth * 0.3,
                              child: Text(
                                state.pokemon.types.length > 1
                                    ? "Types: "
                                    : "Type: ",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
                              )),
                          SizedBox(
                              width: appWidth * 0.3,
                              child: Text(
                                state.pokemon.types.length > 1
                                    ? "${capitalize(state.pokemon.types.first)}, ${capitalize(state.pokemon.types.last)}"
                                    : capitalize(state.pokemon.types.first),
                              )),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: appWidth * 0.30,
                              child: const Text(
                                "Width: ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                          SizedBox(
                              width: appWidth * 0.30,
                              child: Text("${state.pokemon.height * 10} cm")),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: appWidth * 0.30,
                              child: const Text(
                                "Weight: ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                          SizedBox(
                              width: appWidth * 0.30,
                              child: Text("${state.pokemon.weight / 10} kg")),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: appWidth * 0.30,
                              height: appHeight * 0.03,
                              child: const Text(
                                "Description: ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                          SizedBox(
                              width: appWidth * 0.85,
                              child: Text(
                                state.pokemon.description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic),
                              )),
                        ],
                      )),
                ]
              ],
            ),
          ),
        ),
        if (state is DetailsLoadingSuccess) ...[
          Positioned(
              top: appHeight * 0.325,
              left: (appWidth / 2) - 50,
              child: Hero(
                  tag: "details/${state.pokemon.id}",
                  child: CachedNetworkImage(
                    imageUrl: state.pokemon.imageUrl,
                  ))),
        ],
      ]);
    });
  }

  BoxDecoration _getBackgroundDecoration() {
    return BoxDecoration(
        gradient:
            LinearGradient(colors: [typeColors.first!, typeColors.last!]));
  }
}
