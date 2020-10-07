

import 'package:flutter/cupertino.dart';
import 'package:search_the_way/widgets/border.dart';

class TableIndex {

  final int column;

  final int row;

  TableIndex(
    this.column,
    this.row
  );

  static TableIndex reverse (int index) {
    index = index >= 0 ? index : -index;
    int row = int.parse('$index'['$index'.length-1]);
    return TableIndex(
        (index - row) ~/ 10,
        row
    );
  }

  bool get isThereNeg => column < 0 || row < 0;

  int get lastInt => int.parse('$index'['$index'.length]);

  static final couldGo = [10, -10, 1, -1];

  int get index => column * 10 + row;

}