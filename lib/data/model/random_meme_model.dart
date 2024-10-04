import 'package:get_random_memes/constants/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'random_meme_model.g.dart';
@JsonSerializable()
@HiveType(typeId: HiveTypeIds.memeTypeId)
class RandomMeme {
  @JsonKey(name: "id")
  @HiveField(0)
  String id;
    @JsonKey(name: "name")
  @HiveField(1)
  String name;
    @JsonKey(name: "url")
  @HiveField(2)
  String url;
    @JsonKey(name: "width")
  @HiveField(3)
  int width;
    @JsonKey(name: "height")
  @HiveField(4)
  int height;

  RandomMeme({required this.id,required this.name,required this.url,required this.width,required this.height});

  factory RandomMeme.fromJson(Map<String, dynamic> json) => _$RandomMemeFromJson(json);

  Map<String, dynamic> toJson() => _$RandomMemeToJson(this);
}
