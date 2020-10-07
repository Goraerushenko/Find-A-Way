import 'dart:math' as math;


import 'package:flutter/cupertino.dart';
import 'package:search_the_way/components/borderController.dart';
import 'package:search_the_way/models/algorithms/getProfitPoint.dart';
import 'package:search_the_way/models/border/tableIndex.dart';
import 'package:search_the_way/models/square/squares.dart';

List<int> getProfitWay ({
  @required BorderController controller,
  @required TableIndex endPoint
}) {
  final startProfitPoints = getProfitPoint(
      controller: controller,
      startPoint: controller.squares.findStartPoint(),
      endPoint: endPoint
  );
  WaysResult waysResult = concatWays(
    waysResult: WaysResult(),
    pointsResult: startProfitPoints,
    curWay: Way(
        current: null,
        passed: []
    )
  );
  Way foundedWay;
  while (!false ? !false : !false) {
    final curWay = waysResult.getWay();
    final foundedProfitPoints = checkIndiv(
      waysResult: waysResult,
      pointsResult: getProfitPoint(
        controller: controller,
        startPoint: TableIndex.reverse(
            curWay.current
        ),
        endPoint: endPoint
      )
    );
    if (foundedProfitPoints.general.contains(endPoint.index) || curWay.current == endPoint.index) {
      foundedWay = Way(
          current: null,
          passed:  curWay.concat + [endPoint.index]
      );
      break;
    }
    if (foundedProfitPoints.general.length != 0) {
      waysResult = concatWays(
          curWay: curWay,
          waysResult: waysResult,
          pointsResult: foundedProfitPoints
      );
    }
  }
  return foundedWay.passed;
}

PointsResult checkIndiv ({
  @required WaysResult waysResult,
  @required PointsResult pointsResult
}) {
  PointsResult checked = PointsResult();
  pointsResult.general.forEach(
    (index) {
      if (!waysResult.used.contains(index)) {
        if (pointsResult.profit.contains(index)) {
          checked.profit.add(index);
        } else {
          checked.unProfit.add(index);
        }
      }
    }
  );
  return checked;
}

WaysResult concatWays ({
  @required WaysResult waysResult,
  @required PointsResult pointsResult,
  @required Way curWay
}) {
  waysResult.profit = waysResult.profit + pointsResult.profit.map(
        (point) => Way(
          current: point,
          passed:  curWay.concat
      )
  ).toList();

  waysResult.unProfit = waysResult.unProfit + pointsResult.unProfit.map(
      (point) => Way(
        current: point,
        passed: curWay.concat
      )
  ).toList();

  waysResult.used = waysResult.used + pointsResult.general;

  return waysResult;
}

class WaysResult {
  List<Way> profit = [];
  List<Way> unProfit = [];
  List<int> used = [];


  Way getWay () {
    Way point;
    if (profit.length != 0) {
      point = profit[0];
      profit.removeAt(0);
    } else {
      point = unProfit[0];
      unProfit.removeAt(0);
    }
    return point;
  }

  List<Way> get general => profit + unProfit;
}




int nonNegative (int value) => value < 0 ? -value : value;

class Way {

  final List<int> passed;
  final int current;
  int get score => passed.length;

  List<int> get concat => passed + (current == null ? [] :  [current]);

  Way({
    @required this.current,
    @required this.passed
  });

}