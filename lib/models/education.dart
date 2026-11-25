import 'package:json_annotation/json_annotation.dart';

part 'education.g.dart';

/// Portfolio education entry synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Education {
  const Education({
    this.id,
    required this.institution,
    required this.degree,
    required this.year,
    this.graduationYear,
    this.starCount = 0,
    this.isStarred = false,
  });

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);

  @JsonKey(includeToJson: false)
  final int? id;

  final String institution;
  final String degree;
  final String year;
  final int? graduationYear;

  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}
