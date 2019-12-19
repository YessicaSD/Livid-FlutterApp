import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lividcode/baseClasses/user.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    return Container(
      child: Row(
        children: <Widget>[
          Center(
              child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blue,
            ),
          )),
          SizedBox(
            width: 20,
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Strength: " + user.getStat(0).value.toString()),
                  Text("Intelligence: " + user.getStat(1).value.toString()),
                  Text("Stamina: " + user.getStat(2).value.toString()),
                ],
              ),
              Column(
                children: <Widget>[
                  Text("Fun: " + user.getStat(3).value.toString()),
                  Text("Social: " + user.getStat(4).value.toString()),
                  Text("Hygine: " + user.getStat(5).value.toString()),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
