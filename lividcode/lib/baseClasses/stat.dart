import 'package:cloud_firestore/cloud_firestore.dart';
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
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[Text(name + ": "), Text(value.toString())],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 125,
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
    colors[statType.ST_FUN.index] = Colors.yellow[300];
    colors[statType.ST_HYGINE.index] = Colors.blue;
    colors[statType.ST_INTELLIGENCE.index] = Colors.orange[400];
    colors[statType.ST_SOCIAL.index] = Colors.purple;
    colors[statType.ST_STAMINE.index] = Colors.limeAccent[400];
    colors[statType.ST_STRENGTH.index] = Colors.red;

    for (int i = 0; i < allStats.length; i++)
      auxList.add(new Stat(allStats[i], 10, statType.values[i], colors[i]));
    return StatList(auxList);
  }

  StatList.fromFirebase(CollectionReference sp) {
    print(sp.getDocuments().then((doc) {
      for (DocumentSnapshot docs in doc.documents) {
        switch (docs.documentID) {
          case 'STR':
            statList.add(Stat(
                'Strength', docs.data['value'], statType.ST_FUN, Colors.red[300]));
            break;
          case 'STM':
            statList.add(Stat('Stamina', docs.data['value'],
                statType.ST_STAMINE, Colors.lime[300]));
            break;
          case 'INT':
            statList.add(Stat('Intelligence', docs.data['value'],
                statType.ST_INTELLIGENCE, Colors.blue[200]));
            break;
          case 'SOC':
            statList.add(Stat('Social', docs.data['value'], statType.ST_SOCIAL,
                Colors.purple[100]));
            break;
          case 'HYG':
            statList.add(Stat('Hygiene', docs.data['value'], statType.ST_HYGINE,
                Colors.orange[300]));
            break;
          case 'FUN':
            statList.add(Stat(
                'Fun', docs.data['value'], statType.ST_FUN, Colors.yellow[300]));
            break;
        }
      }
    }));
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
