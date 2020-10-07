import 'package:flutter/material.dart';
import 'package:search_the_way/components/borderController.dart';
import 'package:search_the_way/models/border/borderMode.dart';
import 'package:search_the_way/models/border/tableIndex.dart';
import 'package:search_the_way/widgets/border.dart';
import 'package:search_the_way/widgets/bottomBorderActionButtons.dart';
import 'package:search_the_way/widgets/durationRegulator.dart';
import 'package:search_the_way/widgets/editBorderButtons.dart';

import 'components/screenManage.dart';
import 'models/algorithms/randomBarrierPlacement.dart';



class MainGamePage extends StatefulWidget {
  @override
  _MainGamePageState createState() => _MainGamePageState();
}

class _MainGamePageState extends State<MainGamePage>{
  final borderController = BorderController();
  final borderConfig = BorderConfig(
      10,
      10
  );

  @override
  Widget build(BuildContext context) {

    borderController.init(
        list: randomBarrierPlacement(
            borderConfig
        ),
        borderConfig: borderConfig
    );

    return Scaffold(
//      floatingActionButton: editButton(),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomBorderActionButton(
          borderController
      ),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GameBorder(
                borderController: borderController,
                borderConfig: borderConfig,
              ),

              EditBorderButtons(
                borderConfig,
                borderController: borderController,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child:  Padding(
              padding: const EdgeInsets.only(
                bottom: 10
              ),
              child: DurationRegulator(
                  borderController: borderController
              ),
            ),
          )
        ],
      )
    );
  }

//  Widget editButton () {
//    return FloatingActionButton(
//      onPressed: () {
//        borderController.switchBoardMode();
//      },
//      child: ValueListenableBuilder(
//        valueListenable: borderController.mode,
//        builder: (context, value, child) {
//          return Icon(
//              value == BorderMode.game ?
//                Icons.edit : Icons.check
//          );
//        }
//      ),
//    );
//  }
}
