import 'dart:convert';

import 'package:flutter/cupertino.dart';

class taskModel {
  String title;
  String data;
  String time;
  String status;
  String category;

  taskModel(
      {@required this.title,
      @required this.data,
      @required this.time,
      @required this.status,
      @required this.category});

  taskModel copyWith({
    String title,
    String data,
    String time,
    String status,
    String category,
  }) {
    return taskModel(
      title: title ?? this.title,
      data: data ?? this.data,
      time: time ?? this.time,
      status: status ?? this.status,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'data': data,
      'time': time,
      'status': status,
      'category': category,
    };
  }

  factory taskModel.fromMap(Map<String, dynamic> map) {
    return taskModel(
      title: map['title'],
      data: map['data'],
      time: map['time'],
      status: map['status'],
      category: map['category'],
    );
  }

  String toJson() => json.encode(toMap());

  factory taskModel.fromJson(String source) =>
      taskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'taskModel(title: $title, data: $data, time: $time, status: $status,category:$category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is taskModel &&
        other.title == title &&
        other.data == data &&
        other.time == time &&
        other.status == status &&
        other.category == category;
  }

  @override
  int get hashCode {
    return title.hashCode ^ data.hashCode ^ time.hashCode ^ status.hashCode;
  }
}
