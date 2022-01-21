import 'package:movieapp_bloc/domain/entities/video_entity.dart';

class VideoResultModel extends VideoEntity {
  final Iso6391? iso6391;
  final Iso31661? iso31661;
  final String? name;
  final String? key;
  final Site? site;
  final int? size;
  final String? type;
  final bool? official;
  final DateTime? publishedAt;
  final String? id;

  VideoResultModel({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  }) : super(title: name, key: key, type: type);

  factory VideoResultModel.fromJson(Map<String, dynamic> json) => VideoResultModel(
        iso6391: iso6391Values.map[json["iso_639_1"]],
        iso31661: iso31661Values.map[json["iso_3166_1"]],
        name: json["name"],
        key: json["key"],
        site: siteValues.map[json["site"]],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391Values.reverse[iso6391],
        "iso_3166_1": iso31661Values.reverse[iso31661],
        "name": name,
        "key": key,
        "site": siteValues.reverse[site],
        "size": size,
        "type": typeValues.reverse[type],
        "official": official,
        "published_at": publishedAt?.toIso8601String(),
        "id": id,
      };
}

enum Iso31661 { US }

final iso31661Values = EnumValues({"US": Iso31661.US});

enum Iso6391 { EN }

final iso6391Values = EnumValues({"en": Iso6391.EN});

enum Site { YOU_TUBE }

final siteValues = EnumValues({"YouTube": Site.YOU_TUBE});

enum Type { TEASER, FEATURETTE, CLIP, TRAILER }

final typeValues = EnumValues({"Clip": Type.CLIP, "Featurette": Type.FEATURETTE, "Teaser": Type.TEASER, "Trailer": Type.TRAILER});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
