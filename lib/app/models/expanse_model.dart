import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { income, expense, food, travel, work }

const categoryIcons = {
  Category.income: Icons.money,
  Category.expense: Icons.money_off,
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

final dateFormatter =  DateFormat.yMd();

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category,
      this.description = ''  })
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  final String description;

  String get formattedDate {
    return dateFormatter.format(date);
  }
}
