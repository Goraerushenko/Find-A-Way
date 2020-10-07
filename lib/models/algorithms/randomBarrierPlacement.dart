

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:search_the_way/models/border/tableIndex.dart';
import 'package:search_the_way/models/square/square.dart';
import 'package:search_the_way/models/square/squareType.dart';
import 'package:search_the_way/models/square/squares.dart';
import 'package:search_the_way/widgets/border.dart';

List<Square> randomBarrierPlacement (BorderConfig config) {
  List<Square> result = [];
  final random = Random();
  bool isStartPosAdded = false;
  List.generate(
    config.columnCount * 10 - 1,
    (int index) {
      TableIndex tableIndex = TableIndex.reverse(index);
      if (tableIndex.row < config.rowCount && random.nextInt(3) == 1) {
        result.add(
          Square(
              tableIndex: tableIndex,
              type: SquareType.barrier
          )
        );
      }
    }
  );
  Squares squares = Squares(ValueNotifier(result));
  while (!isStartPosAdded) {
    TableIndex tableIndex = TableIndex.reverse(
        random.nextInt(config.columnCount * 10 - 1)
    );
    if (tableIndex.row < config.rowCount) {
      isStartPosAdded = true;
      if (squares.isThereSquare(tableIndex))
        squares.remove(tableIndex);

      squares.add(
          Square(
              tableIndex: tableIndex,
              type: SquareType.startPoint
          )
      );
    }
  }
  return squares.list;
}