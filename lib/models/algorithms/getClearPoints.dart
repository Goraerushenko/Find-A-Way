

import 'package:flutter/cupertino.dart';
import 'package:search_the_way/components/borderController.dart';
import 'package:search_the_way/models/border/tableIndex.dart';
import 'package:search_the_way/models/square/squares.dart';
import 'package:search_the_way/widgets/border.dart';


class CanGoPoint {
  // ignore: non_constant_identifier_names
  static List<TableIndex> DIAGONALS = [
    TableIndex(0, 1),
    TableIndex(0, -1),
    TableIndex(1, 0),
    TableIndex(-1, 0),
    TableIndex(1, 1),
    TableIndex(1, -1),
    TableIndex(-1, 1),
    TableIndex(-1, -1)
  ];
  // ignore: non_constant_identifier_names
  static List<TableIndex> STANDARD = [
    TableIndex(0, 1),
    TableIndex(0, -1),
    TableIndex(1, 0),
    TableIndex(-1, 0),
  ];
}

List<int> getClearPoints ({
  @required BorderController borderController,
  @required TableIndex index
}) {
 final List<int> result = [];

 final List<TableIndex> canGoPoint = CanGoPoint.STANDARD;

 final BorderConfig config = borderController.config;
 canGoPoint.forEach(
     (TableIndex point) {
       final TableIndex curIndex = TableIndex(
         point.column + index.column,
         point.row + index.row,
       );
       if (curIndex.column < config.columnCount &&
           curIndex.row < config.rowCount &&
           !curIndex.isThereNeg) {
         if (!borderController.squares.isThereSquare(curIndex)) {
           result.add(curIndex.index);
         }
       }
     }
 );

 return result;
}