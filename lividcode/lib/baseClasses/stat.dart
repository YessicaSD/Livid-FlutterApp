import 'package:flutter/material.dart';

enum statType {
  ST_STRENGTH,
  ST_INTELLIGENCE,
  ST_STAMINE,
  ST_FUN,
  ST_SOCIAL,
  ST_HYGINE,
  ST_MAX,
}

class Stat {
  String name;
  int value;
  statType type;
  Color color;
  Stat(this.name, this.value, this.type, this.color);

  Widget printStat() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[Text(name + ":"), Text(value.toString())],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 300,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color,
            ),
          )
        ],
      ),
    );
  }
}

class StatList {
  List<Stat> statList = new List<Stat>();

  StatList(this.statList);

  factory StatList.statListStart() {
    List<Stat> auxList = new List<Stat>();
    List<Color> colors = new List<Color>();
    colors.length = statType.ST_MAX.index;
    colors[statType.ST_FUN.index] = Colors.yellow;
    colors[statType.ST_HYGINE.index] = Colors.blue;
    colors[statType.ST_INTELLIGENCE.index] = Colors.lightBlue;
    colors[statType.ST_SOCIAL.index] = Colors.purple;
    colors[statType.ST_STAMINE.index] = Colors.limeAccent[400];
    colors[statType.ST_STRENGTH.index] = Colors.red;

    for (int i = 0; i < allStats.length; i++)
      auxList.add(new Stat(allStats[i], 10, statType.values[i], colors[i]));
    return StatList(auxList);
  }

  Stat getStat(int type) {
    return statList[type];
  }
}

List<String> allStats = [
  'Strength',
  'Intelligence',
  'Stamine',
  'Fun',
  'Social',
  'Hygine'
];
