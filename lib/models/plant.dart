import 'package:equatable/equatable.dart';

class Plant extends Equatable {
  final String author;
  final String bibliography;
  final String commonName;
  final String family;
  final String familyCommonName;
  final String genus;
  final int genusId;
  final int id;
  final String imageUrl;
  final String rank;
  final String scientificName;
  final String slug;
  final String status;
  final List<String> synonyms;
  final int year;

  Plant(
      {this.author,
      this.bibliography,
      this.commonName,
      this.family,
      this.familyCommonName,
      this.genus,
      this.genusId,
      this.id,
      this.imageUrl,
      this.rank,
      this.scientificName,
      this.slug,
      this.status,
      this.synonyms,
      this.year});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
        author: json['author'],
        bibliography: json['bibliography'],
        commonName: json['common_name'],
        family: json['family'],
        familyCommonName: json['family_common_name'],
        genus: json['genus'],
        genusId: json['genus_id'],
        id: json['id'],
        imageUrl: json['image_url'],
        rank: json['rank'],
        scientificName: json['scientific_name'],
        slug: json['slug'],
        status: json['status'],
        synonyms:
            (json['synonyms'] as List)?.map((e) => e.toString())?.toList(),
        year: json['year']);
  }
  @override
  List<Object> get props => [
        this.author,
        this.bibliography,
        this.commonName,
        this.family,
        this.familyCommonName,
        this.genus,
        this.genusId,
        this.id,
        this.imageUrl,
        this.rank,
        this.scientificName,
        this.slug,
        this.status,
        this.synonyms,
        this.year
      ];
}

class Links extends Equatable {
  final String genus;
  final String plant;
  final String self;

  Links({this.genus, this.plant, this.self});
  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      genus: json['genus'],
      plant: json['plant'],
      self: json['self'],
    );
  }
  @override
  List<Object> get props => [this.genus, this.plant, this.self];
}

class PlantDetails extends Equatable {
  final String author;
  final String bibliography;
  final String commonName;
  final String family;
  final String familyCommonName;
  final String genus;
  final int genusId;
  final int id;
  final String imageUrl;
  final String rank;
  final String scientificName;
  final String slug;
  final String status;
  final List<String> synonyms;
  final int year;
  final Images images;

  PlantDetails(
      {this.author,
      this.bibliography,
      this.commonName,
      this.family,
      this.familyCommonName,
      this.genus,
      this.genusId,
      this.id,
      this.imageUrl,
      this.rank,
      this.scientificName,
      this.slug,
      this.status,
      this.synonyms,
      this.year,
      this.images});
  factory PlantDetails.fromJson(Map<String, dynamic> json) {
    return PlantDetails(
        author: json['author'],
        bibliography: json['bibliography'],
        commonName: json['common_name'],
        family: json['family'],
        familyCommonName: json['family_common_name'],
        genus: json['genus'],
        genusId: json['genus_id'],
        id: json['id'],
        imageUrl: json['image_url'],
        rank: json['rank'],
        scientificName: json['scientific_name'],
        slug: json['slug'],
        status: json['status'],
        synonyms:
            (json['synonyms'] as List)?.map((e) => e.toString())?.toList(),
        year: json['year'],
        images: Images.fromJson(json['main_species']['images']));
  }
  @override
  List<Object> get props => [
        this.author,
        this.bibliography,
        this.commonName,
        this.family,
        this.familyCommonName,
        this.genus,
        this.genusId,
        this.id,
        this.imageUrl,
        this.rank,
        this.scientificName,
        this.slug,
        this.status,
        this.synonyms,
        this.year,
        this.images
      ];
}

class Images extends Equatable {
  final Fruit fruit;

  Images({this.fruit});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(fruit: Fruit.fromJson(json['fruit']));
  }
  @override
  List<Object> get props => [this.fruit];
}

class Fruit extends Equatable {
  final String id;
  final String imageUrl;

  Fruit({this.id, this.imageUrl});

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(id: json['id'], imageUrl: json['image_url']);
  }

  @override
  List<Object> get props => [this.id, this.imageUrl];
}
