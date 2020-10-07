import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:search_the_way/components/borderController.dart';
import 'package:search_the_way/components/screenManage.dart';
import 'package:search_the_way/models/algorithms/randomBarrierPlacement.dart';
import 'package:search_the_way/models/border/borderMode.dart';


class BottomBorderActionButton extends StatefulWidget {

  BottomBorderActionButton(
      this.controller
  );

  final BorderController controller;

  @override
  _BottomBorderActionButtonState createState() => _BottomBorderActionButtonState();
}

class _BottomBorderActionButtonState extends State<BottomBorderActionButton> {



  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          randomButton(),
          clearButton(),
          switchButton()
        ],
      ),
    );
  }


  Widget switchButton () {
    return IconButton(
      onPressed: this.widget.controller.switchBoardMode,
      icon: ValueListenableBuilder(
          valueListenable: this.widget.controller.mode,
          builder: (context, mode, child) {
            return Icon(
              mode == BorderMode.edit ? Icons.check :  Icons.edit,
              color: Colors.blue,
              size: mode != BorderMode.edit ? 22 : 25,
            );
          }
      ),
    );
  }

  Widget clearButton () {
    return IconButton(
      onPressed: this.widget.controller.squares.clearBarriers,
      icon: Icon(
        Icons.clear,
        color: Colors.red,
        size: 25,
      ),
    );
  }

  Widget randomButton () {
    return IconButton(
      onPressed: () {
        this.widget.controller.squares.value.value = randomBarrierPlacement(
          this.widget.controller.config
        );
      },
      icon: Icon(
        RpgAwesome.perspective_dice_random,
        color: Colors.blue,
        size: 25,
      ),
    );
  }

}
