
import 'package:flutter/material.dart';
import 'package:search_the_way/components/borderController.dart';
import 'package:search_the_way/models/algorithms/randomBarrierPlacement.dart';
import 'package:search_the_way/models/border/borderMode.dart';
import 'package:search_the_way/models/square/squareType.dart';
import 'package:search_the_way/models/square/squares.dart';
import 'package:search_the_way/widgets/border.dart';

class EditBorderButtons extends StatefulWidget {

  EditBorderButtons(
    this.borderConfig,
    {
      this.borderController
    }
  );
  final BorderController borderController;

  final BorderConfig borderConfig;

  @override
  _EditBorderButtonsState createState() => _EditBorderButtonsState();
}

class _EditBorderButtonsState extends State<EditBorderButtons> {
  BorderController _borderController;

  BorderConfig _borderConfig;

  List<EditButtonData> data = [];

  @override
  void initState() {
    _borderController = widget.borderController;
    _borderConfig = widget.borderConfig;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    data = [
      EditButtonData(
        child: Container(
          color: Colors.black,
        ),
        type: SquareType.barrier
      ),
      EditButtonData(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle
              ),
            ),
          ),
          type: SquareType.startPoint
      ),
      EditButtonData(
          child: Container(
          ),
          type: SquareType.empty
      ),
    ];

    return ValueListenableBuilder(
      valueListenable: _borderController.mode,
      builder: (context, mode, child) {
        return AnimatedOpacity(
          opacity: mode == BorderMode.edit ? 1.0 : .0,
          duration: Duration(
            milliseconds: 300
          ),
          child: ValueListenableBuilder(
              valueListenable: _borderController.choseEditItem,
              builder: (context, value, child) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: data.map(
                            (el) => InkWell(
                          splashColor: Colors.grey,
                          onTap:  mode == BorderMode.edit ?
                              () => _borderController.choseEditItem.value = el.type : null,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:  value == el.type ?
                                    Colors.red : Colors.grey,
                                    width: 1
                                )
                            ),
                            child: el.child,
                          ),
                        )).toList()
                );
              }
          ),
        );
      }
    );
  }
}

class EditButtonData {

  final Widget child;

  final SquareType type;

  EditButtonData({
    this.type,
    this.child
  });

}
