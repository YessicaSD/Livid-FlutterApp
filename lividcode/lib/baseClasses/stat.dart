enum statType {
  ST_INTELLIGENCE,
  ST_STAMINE,
  ST_FUN,
  ST_STRENGTH,
  ST_SOCIAL,
  ST_HYGINE,
  ST_MAX,
}

class Stat {
  String name;
  int value;
  statType type;
}
