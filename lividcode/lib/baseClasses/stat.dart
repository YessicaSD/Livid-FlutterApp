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

  Stat(this.name, this.value, this.type);
}

class StatList {
  List<Stat> statList = new List<Stat>();

  StatList(this.statList);

  factory StatList.statListStart() {
    List<Stat> auxList = new List<Stat>();
    for (int i = 0; i < allStats.length; i++)
      auxList.add(new Stat(allStats[i], 0, statType.values[i]));
    return StatList(auxList);
  }

  Stat getStat(int type)
  {
    return statList[type];
  }
}

List<String> allStats = [
  'Strength', 'Intelligence', 'Stamine', 'Fun', 'Social', 'Hygine'
];

