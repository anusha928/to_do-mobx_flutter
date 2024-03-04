import 'package:json_annotation/json_annotation.dart';
part 'task_model.g.dart';

@JsonSerializable()
class TaskModel{
 TaskModel( {this.id,
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

 factory TaskModel.fromJson(Map<String, dynamic> json) =>
     _$TaskModelFromJson(json);

 Map<String, dynamic> toJson() => _$TaskModelToJson(this);


}