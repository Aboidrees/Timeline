Map<String, List<dynamic>> encodePeriods(Map<DateTime, List<dynamic>> periods) {
  Map<String, List<dynamic>> newPeriod = {};

  periods.forEach((key, value) => newPeriod[key.toString()] = periods[key]);
  return newPeriod;
}

Map<DateTime, List<dynamic>> decodePeriods(Map<String, List<dynamic>> periods) {
  Map<DateTime, List<dynamic>> newPeriod = {};
  periods.forEach((key, value) => newPeriod[DateTime.parse(key)] = periods[key]);
  return newPeriod;
}
