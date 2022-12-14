import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  int id;
  String? title;
  String? description;
  String importance;
  String status;
  bool checked;
  final DateTime? from;
  final DateTime? to;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.importance,
    this.status = "In progress",
    required this.checked,
    this.from,
    this.to,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    String? importance,
    String? status,
    bool? checked,
    DateTime? from,
    DateTime? to,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      importance: importance ?? this.importance,
      status: status ?? this.status,
      checked: checked ?? this.checked,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'importance': importance,
      'status': status,
      'checked': checked,
      'from': from?.millisecondsSinceEpoch,
      'to': to?.millisecondsSinceEpoch,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      importance: map['importance'] as String,
      status: map['status'] as String,
      checked: map['checked'] as bool,
      from: map['from'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['from'] as int)
          : null,
      to: map['to'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['to'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, description: $description, importance: $importance, status: $status, checked: $checked, from: $from, to: $to)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.importance == importance &&
        other.status == status &&
        other.checked == checked &&
        other.from == from &&
        other.to == to;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        importance.hashCode ^
        status.hashCode ^
        checked.hashCode ^
        from.hashCode ^
        to.hashCode;
  }
}
