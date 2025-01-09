part of 'models.dart';

class ListsModel {
  final String? description;
  final int? favoriteCount;
  final int? id;
  final int? itemCount;
  final String? iso6391;
  final String? listType;
  final String? name;
  final String? posterPath;

  ListsModel({
    required this.description,
    required this.favoriteCount,
    required this.id,
    required this.itemCount,
    required this.iso6391,
    required this.listType,
    required this.name,
    required this.posterPath,
  });

  factory ListsModel.fromMap(Map<String, dynamic> map) {
    return ListsModel(
      description:
          map['description'] != null ? map['description'] as String : null,
      favoriteCount:
          map['favorite_count'] != null ? map['favorite_count'] as int : null,
      id: map['id'] != null ? map['id'] as int : null,
      itemCount: map['item_count'] != null ? map['item_count'] as int : null,
      iso6391: map['iso_639_1'] != null ? map['iso_639_1'] as String : null,
      listType: map['list_type'] != null ? map['list_type'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      posterPath:
          map['poster_path'] != null ? map['poster_path'] as String : null,
    );
  }

  @override
  String toString() {
    return 'ListsModel(description: $description, favoriteCount: $favoriteCount, id: $id, itemCount: $itemCount, iso6391: $iso6391, listType: $listType, name: $name, posterPath: $posterPath)';
  }
}
