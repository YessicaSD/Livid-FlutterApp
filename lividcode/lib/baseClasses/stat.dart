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

statType statFromFullName(String s){
  if (s == null) return statType.ST_MAX;
  switch (s) {
    case 'Strength':
      return statType.ST_STRENGTH;
      break;
    case 'Stamine':
      return statType.ST_STAMINE;
      break;
    case 'Intelligence':
      return statType.ST_INTELLIGENCE;
      break;
    case 'Social':
      return statType.ST_SOCIAL;
      break;
    case 'Hygine':
      return statType.ST_HYGINE;
      break;
    case 'Fun':
      return statType.ST_FUN;
      break;
  }
  return statType.ST_MAX;
}

String statToFullName(statType t) {
  switch (t) {
    case statType.ST_STRENGTH:
      return 'Strength';
      break;
    case statType.ST_INTELLIGENCE:
      return 'Intelligence';
      break;
    case statType.ST_STAMINE:
      return 'Stamine';
      break;
    case statType.ST_FUN:
      return 'Fun';
      break;
    case statType.ST_SOCIAL:
      return 'Social';
      break;
    case statType.ST_HYGINE:
      return 'Hygine';
      break;
    default:
      break;
  }
  return 'invalid';
}

String statToString(statType t) {
  switch (t) {
    case statType.ST_STRENGTH:
      return 'STR';
      break;
    case statType.ST_INTELLIGENCE:
      return 'INT';
      break;
    case statType.ST_STAMINE:
      return 'STM';
      break;
    case statType.ST_FUN:
      return 'FUN';
      break;
    case statType.ST_SOCIAL:
      return 'SOC';
      break;
    case statType.ST_HYGINE:
      return 'HYG';
      break;
    default:
      break;
  }
  return 'invalid';
}

statType statFromString(String s) {
  if (s == null) return statType.ST_MAX;
  switch (s) {
    case 'STR':
      return statType.ST_STRENGTH;
      break;
    case 'STM':
      return statType.ST_STAMINE;
      break;
    case 'INT':
      return statType.ST_INTELLIGENCE;
      break;
    case 'SOC':
      return statType.ST_SOCIAL;
      break;
    case 'HYG':
      return statType.ST_HYGINE;
      break;
    case 'FUN':
      return statType.ST_FUN;
      break;
  }
  return statType.ST_MAX;
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
            percent: value / maxValue,
            backgroundColor: Colors.deepPurple[400],
            progressColor: color,
          ),
        ],
      ),
    );
  }
}

class StatList {
  List<Stat> statList = new List<Stat>();

  StatList(this.statList);

  setStat(String stat, int value){
    statType toChange = statFromString(stat);
    for(var s in statList){
      if(toChange == s.type){
        s.value = value;
      }
    }
  }

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
    await sp.getDocuments().then((doc) {
      for (DocumentSnapshot docs in doc.documents) {
        switch (docs.documentID) {
          case 'STR':
            statList.add(Stat('Strength', docs.data['value'], statType.ST_STRENGTH,
                Colors.red[300], docs.data['maxValue']));
            break;
          case 'STM':
            statList.add(Stat('Stamina', docs.data['value'],
                statType.ST_STAMINE, Colors.lime[300], docs.data['maxValue']));
            break;
          case 'INT':
            statList.add(Stat(
                'Intelligence',
                docs.data['value'],
                statType.ST_INTELLIGENCE,
                Colors.blue[200],
                docs.data['maxValue']));
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
    });
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
