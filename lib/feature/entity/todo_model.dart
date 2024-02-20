import 'package:json_annotation/json_annotation.dart';
part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel{
 TodoModel( {this.id,
  this.title,
  this.description,
  this.status,
  this.priority});

 @JsonKey(name: 'id')
 String? id;
 @JsonKey(name: 'title')
 String? title;
 @JsonKey(name: 'description')
 String? description;
 @JsonKey(name: 'status')
 String? status;
 @JsonKey(name: 'priority')
 String? priority;

 factory TodoModel.fromJson(Map<String, dynamic> json) =>
     _$TodoModelFromJson(json);

 Map<String, dynamic> toJson() => _$TodoModelToJson(this);


}