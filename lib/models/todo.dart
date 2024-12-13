import 'package:flutter/material.dart';

enum PrioritySet {
  urgent(color: Colors.red, title: 'Urgent'),
  high(color: Colors.orange, title: 'High'),
  medium(color: Colors.yellow, title: 'Medium'),
  low(color: Colors.green, title: 'low');

  const PrioritySet({
    required this.color,
    required this.title,
  });

  final Color color;
  final String title;
}

class TodoModel {
  const TodoModel({
    required this.title,
    required this.description,
    required this.priority,
  });

  final String title;
  final String description;
  final PrioritySet priority;

  //Untuk debugging
  @override
  String toString() {
    return 'TodoModel(title: $title, description: $description, priority: ${priority.title})';
  }
}
