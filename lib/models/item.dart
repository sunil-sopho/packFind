import 'package:hive/hive.dart';
part 'item.g.dart';

@HiveType(typeId: 2)
class Item extends HiveObject {
  @HiveField(0)
  final dynamic itemId;
  @HiveField(1)
  final dynamic uid;
  @HiveField(2)
  final dynamic packageId;
  @HiveField(3)
  final dynamic name;
  @HiveField(4)
  final dynamic description;
  @HiveField(5)
  final dynamic quantity;
  @HiveField(6)
  final List<String> image;

  Item({
    required this.itemId,
    this.uid,
    this.packageId,
    this.name,
    this.description,
    this.quantity,
    required this.image,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json['itemId'],
        uid: json['uid'],
        packageId: json['packageId'],
        name: json['name'],
        description: json['description'],
        quantity: json['quantity'],
        image: List<String>.from(json['image']).map((item) => item).toList(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId;
    if (packageId != null) {
      data['packageId'] = packageId;
    }
    if (uid != null) {
      data['uid'] = uid;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (description != null) {
      data['description'] = description;
    }
    data['quantity'] = quantity;
    return data;
  }
}
