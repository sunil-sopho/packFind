import 'package:hive/hive.dart';
part 'package.g.dart';

@HiveType(typeId: 0)
class Package extends HiveObject {
  @HiveField(0)
  final dynamic packageId;
  @HiveField(1)
  final dynamic uid;
  @HiveField(2)
  final dynamic itemList;
  @HiveField(3)
  final dynamic location;
  @HiveField(4)
  final List<String> image;
  @HiveField(5)
  final dynamic name;
  // @HiveField(6)
  // String publishedAt;
  // @HiveField(7)
  // String content;
  // @HiveField(8)
  // String id;

  Package({
    this.packageId,
    this.uid,
    this.name,
    this.itemList,
    this.location,
    required this.image,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageId: json['packageId'],
        itemList: json['itemList'],
        uid: json['uid'],
        location: json['location'],
        name: json['name'],
        image: List<String>.from(json['image']).map((item) => item).toList(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (packageId != null) {
      data['packageId'] = packageId;
    }

    data['uid'] = uid;
    data['itemList'] = itemList;
    data['location'] = location;

    return data;
  }
}
