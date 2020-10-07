

import 'package:flutter/cupertino.dart';
import 'package:search_the_way/models/border/tableIndex.dart';
import 'package:search_the_way/models/square/squareType.dart';
import 'package:search_the_way/widgets/border.dart';

class Square {

  TableIndex tableIndex;

  SquareType type;

  Square({
    @required this.tableIndex,
    @required this.type
  });

}