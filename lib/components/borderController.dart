

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:search_the_way/models/algorithms/getPassDecision.dart';
import 'package:search_the_way/models/algorithms/getProfitWay.dart';
import 'package:search_the_way/models/border/borderMode.dart';
import 'package:search_the_way/models/border/tableIndex.dart';
import 'package:search_the_way/models/square/square.dart';
import 'package:search_the_way/models/square/squareType.dart';
import 'package:search_the_way/models/square/squares.dart';
import 'package:search_the_way/widgets/border.dart';

class BorderController {

  Squares squares;

  BorderConfig config;

  int foundedWaysCount = 0;

  double duration = 100;

  ValueNotifier<BorderMode> mode = ValueNotifier(BorderMode.game);

  ValueNotifier<SquareType> choseEditItem = ValueNotifier(SquareType.startPoint);


  void onTapSquare (TableIndex tableIndex) {
    squares.removeWay();
    if (mode.value == BorderMode.edit) {
      onEditMode(tableIndex);
    } else if (
        getPassDecision(
            borderController: this,
            endPoint: tableIndex
        )
    ) {
      foundedWaysCount++;
      animate(
        list: getProfitWay (
          controller: this,
          endPoint: tableIndex,
        ),
        count: foundedWaysCount
      );


    }
    squares.squareType(tableIndex);
  }

  void animate ({List<int> list, int count}) {
    final duration = this.duration.toInt();
    for (int i = 0; i < list.length; i++) {
      Future.delayed(
          Duration(
            milliseconds: duration  * i,
          ),
          () {
            if (foundedWaysCount == count ) {
              squares.value.value = squares.list + [
                Square(
                    tableIndex: TableIndex.reverse(
                        list[i]
                    ),
                    type: SquareType.wayPoint
                )
              ];
            }
          }
      );

    }
  }

  void init ({
     @required List<Square> list,
     @required BorderConfig borderConfig
  }) {
    this.config = borderConfig;
    squares = Squares(
      ValueNotifier(list)
    );
  }

  void onEditMode (TableIndex tableIndex) {
    if (squares.squareType(tableIndex) != SquareType.startPoint) {
      if (squares.isThereSquare(tableIndex) ) {
        squares.remove(tableIndex);
      }
      if (choseEditItem.value == SquareType.startPoint) {
        squares.remove(squares.findStartPoint());
        squares.add(
            Square(
                tableIndex: tableIndex,
                type: SquareType.startPoint
            )
        );
      } else {

        choseEditItem.value == SquareType.barrier ? squares.add(
            Square(
                tableIndex: tableIndex,
                type: SquareType.barrier
            )
        ) : null;
      }
    }

  }

  void switchBoardMode () =>
      mode.value =
        mode.value == BorderMode.edit ? BorderMode.game : BorderMode.edit;

}








