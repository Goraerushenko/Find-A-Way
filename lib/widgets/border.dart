import 'package:flutter/material.dart';
import 'package:search_the_way/components/borderController.dart';
import 'package:search_the_way/components/screenManage.dart';
import 'package:search_the_way/models/algorithms/getClearPoints.dart';
import 'package:search_the_way/models/algorithms/getProfitPoint.dart';
import 'package:search_the_way/models/algorithms/getProfitWay.dart';
import 'package:search_the_way/models/border/tableIndex.dart';
import 'package:search_the_way/models/square/square.dart';
import 'package:search_the_way/models/square/squareType.dart';



class GameBorder extends StatefulWidget {

  final BorderConfig borderConfig;
  final BorderController borderController;



  GameBorder({
    @required this.borderConfig,
    @required this.borderController
  });

  @override
  _GameBorderState createState() => _GameBorderState();
}

class _GameBorderState extends State<GameBorder> {
  

  BorderConfig _borderConfig;

  double _borderSize;

  BorderController _borderController;

  @override
  void initState() {
    _borderSize = screenManage.weight * .9;
    _borderController = widget.borderController;
    _borderConfig = this.widget.borderConfig;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        3
      ),
      child: Container(
        height: _borderSize,
        width: _borderSize,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
            color: Colors.grey,
            width: 1
          )
        ),
        child: ValueListenableBuilder(
          valueListenable: _borderController.squares.value,
          builder: (context, value, child) {
            return Table(
              children: List.generate(
                  this.widget.borderConfig.columnCount,
                  (column) => TableRow(
                      children: List.generate(
                          this.widget.borderConfig.rowCount,
                          (row) => tableSquare (
                            TableIndex(
                              column,
                              row
                            )
                          )
                      )
                  )
              )
            );
          }
        ),
      ),
    );
  }

  Widget tableSquare (
    TableIndex tableIndex
  ) {
    final square = _borderController.squares.findSquare(tableIndex);
    Widget child;

    switch (square?.type) {
      case SquareType.barrier:
        child =  barrier();
        break;
      case SquareType.startPoint:
        child =  startPoint();
        break;
      case SquareType.wayPoint:
        child =  wayPoint();
        break;
      case SquareType.empty:
        break;
    }
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        setState(() {
          _borderController.onTapSquare(tableIndex);
        });
      },
      child: Container(
        height: _borderConfig.squareSize.height,
        width:  _borderConfig.squareSize.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1
          ),
        ),
        child: AnimatedOpacity(
          opacity: square?.type == null ? 0.0 : 1.0 ,
          duration: Duration(
            milliseconds: _borderController.duration.toInt()
          ),
          child: square?.type == null ?
          Container() : child,
        ),
      ),
    );
  }

  Widget barrier () => Container(
    decoration: BoxDecoration(
        color: Colors.black,
    ),
  );

  Widget startPoint () => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: (_borderConfig.squareSize.width) * .25,
      vertical: (_borderConfig.squareSize.height) * .25,
    ),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.greenAccent,
          shape: BoxShape.circle
      ),
    ),
  );

  Widget wayPoint () => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: (_borderConfig.squareSize.width) * .25,
      vertical: (_borderConfig.squareSize.height) * .25,
    ),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle
      ),
    ),
  );

}




class BorderConfig {

  static double borderSize =  screenManage.weight * .9;

  Size get squareSize => Size(
      borderSize / rowCount,
      borderSize / columnCount
  );

  final int columnCount;

  final int rowCount;

  BorderConfig(
     this.columnCount,
      this.rowCount
  );

}

