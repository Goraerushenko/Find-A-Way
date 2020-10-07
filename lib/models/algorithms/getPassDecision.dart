

import 'package:flutter/cupertino.dart';
import 'package:search_the_way/components/borderController.dart';
import 'package:search_the_way/models/algorithms/getClearPoints.dart';
import 'package:search_the_way/models/border/tableIndex.dart';
import 'package:search_the_way/models/square/squares.dart';
import 'package:search_the_way/widgets/border.dart';

bool getPassDecision ({
  @required BorderController borderController,
  @required TableIndex endPoint
}){
  List stack = getClearPoints(
    index: borderController.squares.findStartPoint(),
    borderController: borderController
  );
  List passedSquares = [];
  bool isWayFind = false;
  while(stack.length != 0 && !isWayFind) {
    isWayFind = stack[0] == endPoint.index;
    getClearPoints(
        index: TableIndex.reverse(stack[0]),
        borderController: borderController
    ).forEach(  
        (el) {
          if (!passedSquares.contains(el) && !stack.contains(el) ){
            stack.add(el);
          }
        }
    );
    if (!passedSquares.contains(stack[0])){
      passedSquares.add(stack[0]);
    }
    stack.removeAt(0);
  }

  return isWayFind;
}