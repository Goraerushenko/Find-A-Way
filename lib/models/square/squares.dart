

import 'package:flutter/cupertino.dart';
import 'package:search_the_way/models/border/tableIndex.dart';
import 'package:search_the_way/models/square/square.dart';
import 'package:search_the_way/models/square/squareType.dart';
import 'package:search_the_way/widgets/border.dart';

class Squares {

  ValueNotifier<List<Square>> value;

  Squares(
    this.value
  );

  List<Square> get list => value.value;

  void clearBarriers () {
    final TableIndex startPoint = findStartPoint();

    value.value = [
      Square(
        tableIndex: startPoint,
        type: SquareType.startPoint
      )
    ];

  }


  Square findSquare (TableIndex index) {
    final foundedSquareIndex = list.map(
            (e) => e.tableIndex.index).toList().indexOf(index.index);
    return foundedSquareIndex != -1 ? list[foundedSquareIndex] : null;
  }


  void removeWay () {
    final List<Square> without = [];

    list.forEach(
        (Square square) {
          if (square.type != SquareType.wayPoint) {
            without.add(square);
          }
        }
    );
    value = ValueNotifier(without);
  }

  void add (Square square) {
    list.add(square);
  }

  SquareType squareType (TableIndex index) {
    final foundedSquareIndex = list.map(
        (e) => e.tableIndex.index).toList().indexOf(index.index);
    return foundedSquareIndex != -1 ? list[foundedSquareIndex].type : null;
  }

  void remove (TableIndex index) {
    final foundedSquareIndex = list.map(
            (e) => e.tableIndex.index).toList().indexOf(index.index);
    list.removeAt(foundedSquareIndex);
  }

  bool isThereSquare (TableIndex index) {
    final foundedSquareIndex = list.map(
            (e) => e.tableIndex.index).toList().indexOf(index.index);
    return foundedSquareIndex != -1;
  }

  TableIndex findStartPoint () {
    final foundedSquareIndex = list.map(
            (e) => e.type).toList().indexOf(SquareType.startPoint);
    return foundedSquareIndex != -1 ? list[foundedSquareIndex].tableIndex : null;
  }

}