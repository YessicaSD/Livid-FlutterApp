import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/user.dart';

class ProfileWidget extends StatefulWidget {
  User user;
  ProfileWidget(this.user);
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final User user = widget.user;
    return Container(
      child: Row(
        children: <Widget>[
          Center(
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(user.imagePath),
                    )),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0, count = 0; i < 3; i++)
                Row(children: <Widget>[
                  for (int j = 0; j < 2; j++, count++)
                    user.getStat(count).printStat(),
                ]),
            ],
          ),
        ],
      ),
    );
  }
}
