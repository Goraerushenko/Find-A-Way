import 'package:flutter/material.dart';
import 'package:search_the_way/components/borderController.dart';

import 'package:search_the_way/models/border/tableIndex.dart';

import 'getClearPoints.dart';
import 'getProfitWay.dart';

PointsResult getProfitPoint ({
  @required BorderController controller,
  @required TableIndex startPoint,
  @required TableIndex endPoint
}) {
  final PointsResult result = PointsResult();

  final clearPoints = getClearPoints(
      borderController: controller,
      index: startPoint
  );

  final mainSacristy = TableIndex(
    nonNegative(
        endPoint.column - startPoint.column
    ),
    nonNegative(
        endPoint.row - startPoint.row
    ),
  );
  clearPoints.forEach(
          (index) {
        final tableIndex = TableIndex.reverse(index);
        final sacristy = TableIndex(
          nonNegative(
              endPoint.column - tableIndex.column
          ),
          nonNegative(
              endPoint.row - tableIndex.row
          ),
        );
        if (sacristy.column < mainSacristy.column || sacristy.row < mainSacristy.row)
          result.profit.add(index);
        else
          result.unProfit.add(index);
      }
  );
  return result;
}



class PointsResult {

  final List<int> profit = [];
  final List<int> unProfit = [];


  List<int> get general => profit + unProfit;
}