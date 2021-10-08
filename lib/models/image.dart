import 'package:hive/hive.dart';
import 'dart:ui';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
part 'image.g.dart';

@HiveType(typeId: 1)
class Img extends HiveObject {
  @HiveField(0)
  final dynamic img;

  Img({
    required this.img,
  });

  factory Img.fromJson(Map<String, dynamic> json) => Img(
        img: json['img'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img'] = img;
    return data;
  }
}
