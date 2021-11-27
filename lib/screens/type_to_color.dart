import 'package:flutter/material.dart';

List<Color?> typeToColor(List<String> types) {
  List<Color?> typeColors = [];
  for (String type in types) {
    switch(type) {
      case "normal":
        typeColors.add(const Color(0xffa8a77a));
        break;
      case "fire":
        typeColors.add(const Color(0xffEE8130));
        break;
      case "fighting":
        typeColors.add(const Color(0xffC22E28));
        break;
      case "water":
        typeColors.add(const Color(0xff6390F0));
        break;
      case "flying":
        typeColors.add(const Color(0xffA98FF3));
        break;
      case "grass":
        typeColors.add(const Color(0xff7AC74C));
        break;
      case "poison":
        typeColors.add(const Color(0xffA33EA1));
        break;
      case "electric":
        typeColors.add(const Color(0xffF7D02C));
        break;
      case "ground":
        typeColors.add(const Color(0xffE2BF65));
        break;
      case "psychic":
        typeColors.add(const Color(0xffF95587));
        break;
      case "rock":
        typeColors.add(const Color(0xffB6A136));
        break;
      case "ice":
        typeColors.add(const Color(0xff96D9D6));
        break;
      case "bug":
        typeColors.add(const Color(0xffA6B91A));
        break;
      case "dragon":
        typeColors.add(const Color(0xff6F35FC));
        break;
      case "ghost":
        typeColors.add(const Color(0xff735797));
        break;
      case "dark":
        typeColors.add(const Color(0xff705746));
        break;
      case "steel":
        typeColors.add(const Color(0xffB7B7CE));
        break;
      case "fairy":
        typeColors.add(const Color(0xffD685AD));
        break;
      default:
        typeColors.add(Colors.black);
    }
  }
  return typeColors;

}