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
            child: InkWell(
              onTap: () {},
              child: Container(
                child: Image.network(user.imagePath),
                width: 50,
                height: 50,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0;
                  i < Provider.of<User>(context).stats.statList.length;
                  ++i)
                user.getStat(i).printStat(),
            ],
          ),
        ],
      ),
    );
  }
}
