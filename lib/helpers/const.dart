import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF53214d);

const List<List<String>> weekDays = [
  ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'],
  ['MON', 'TUES', 'WEDNES', 'THURS', 'FRI', 'SATUR', 'SUN'],
];
const List<List<String>> months = [
  ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'],
  ['JANUARY', 'FEBRUARY', 'MARS', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'],
];

const Map<String, Color> dayColors = {
  'day': Colors.black,
  'today': primaryColor,
  'selected': Colors.white,
  'weekend': Colors.red,
  'outside': Colors.grey,
};

DateTime midnight(date) => DateTime.parse("${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} 00:00:00.000Z");
