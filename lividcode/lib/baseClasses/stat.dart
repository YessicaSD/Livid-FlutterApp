import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
  int maxValue;
  statType type;
  Color color;
  Stat(this.name, this.value, this.type, this.color, this.maxValue);

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
          LinearPercentIndicator(
              width: 109,
              lineHeight: 5,
              percent: 0.2,
              backgroundColor: Colors.grey[700],
              progressColor: color,),
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
      auxList.add(new Stat(allStats[i], 10, statType.values[i], colors[i], 20));
    return StatList(auxList);
  }

  Future<void> fromFirebase(CollectionReference sp) async {
    print(sp.getDocuments().then((doc) {
      for (DocumentSnapshot docs in doc.documents) {
        switch (docs.documentID) {
          case 'STR':
            statList.add(Stat('Strength', docs.data['value'], statType.ST_FUN,
                Colors.red[300],docs.data['maxValue']));
            break;
          case 'STM':
            statList.add(Stat('Stamina', docs.data['value'],
                statType.ST_STAMINE, Colors.lime[300], docs.data['maxValue']));
            break;
          case 'INT':
            statList.add(Stat('Intelligence', docs.data['value'],
                statType.ST_INTELLIGENCE, Colors.blue[200], docs.data['maxValue']));
            break;
          case 'SOC':
            statList.add(Stat('Social', docs.data['value'], statType.ST_SOCIAL,
                Colors.purple[100], docs.data['maxValue']));
            break;
          case 'HYG':
            statList.add(Stat('Hygiene', docs.data['value'], statType.ST_HYGINE,
                Colors.orange[300], docs.data['maxValue']));
            break;
          case 'FUN':
            statList.add(Stat('Fun', docs.data['value'], statType.ST_FUN,
                Colors.yellow[300], docs.data['maxValue']));
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
