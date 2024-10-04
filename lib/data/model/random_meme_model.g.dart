// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_meme_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RandomMemeAdapter extends TypeAdapter<RandomMeme> {
  @override
  final int typeId = 1;

  @override
  RandomMeme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RandomMeme(
      id: fields[0] as String,
      name: fields[1] as String,
      url: fields[2] as String,
      width: fields[3] as int,
      height: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RandomMeme obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.width)
      ..writeByte(4)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RandomMemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RandomMeme _$RandomMemeFromJson(Map<String, dynamic> json) => RandomMeme(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$RandomMemeToJson(RandomMeme instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
