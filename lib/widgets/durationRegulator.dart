import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_the_way/components/borderController.dart';
import 'package:search_the_way/components/screenManage.dart';

class DurationRegulator extends StatefulWidget {

  DurationRegulator({
    this.borderController
  });
  final BorderController borderController;

  @override
  _DurationRegulatorState createState() => _DurationRegulatorState();
}

class _DurationRegulatorState extends State<DurationRegulator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: screenManage.weight * .8,
          child: CupertinoSlider(
            max: 1000,

            onChanged: (double value) {
              setState(() {
                this.widget.borderController.duration = value;
              });
            },
            value: this.widget.borderController.duration,
          ),
        ),
        Text(
            this.widget.borderController.duration.toInt().toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}
