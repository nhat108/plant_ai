import 'package:equatable/equatable.dart';

enum CareOptions { Water, Fertilize, Rotate, Prune, Harvest }

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
  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'bibliography': bibliography,
      'common_name': commonName,
      'family': family,
      'family_common_name': familyCommonName,
      'genus': genus,
      'genus_id': genusId,
      'id': id,
      'image_url': imageUrl,
      'rank': rank,
      'scientific_name': scientificName,
      'slug': slug,
      'status': status,
      'synonyms': synonyms,
      'year': year,
    };
  }
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
  final Map<String, dynamic> family;
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
        genus: json['genus']['name'],
        genusId: json['genus_id'],
        id: json['id'],
        imageUrl: json['image_url'],
        rank: json['rank'],
        scientificName: json['scientific_name'],
        slug: json['slug'],
        status: json['status'],
        // synonyms: (json['main_species']['synonyms'] as Map)
        //     .values
        //     .map((e) => e.toString())
        //     .toList(),
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
  final List<Fruit> fruits;
  final List<Leaf> leafs;
  Images({this.fruits, this.leafs});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
        leafs: json['leaf'] != null
            ? (json['leaf'] as List)?.map((e) => Leaf.fromJson(e))?.toList() ??
                []
            : [],
        fruits: json['fruit'] != null
            ? (json['fruit'] as List).map((e) {
                return Fruit.fromJson(e);
              }).toList()
            : []);
  }
  @override
  List<Object> get props => [this.fruits];
}

class Fruit extends Equatable {
  final int id;
  final String imageUrl;

  Fruit({this.id, this.imageUrl});

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(id: json['id'], imageUrl: json['image_url']);
  }

  @override
  List<Object> get props => [this.id, this.imageUrl];
}

class Leaf extends Equatable {
  final int id;
  final String imageUrl;

  Leaf({this.id, this.imageUrl});

  factory Leaf.fromJson(Map<String, dynamic> json) {
    return Leaf(
      id: json['id'],
      imageUrl: json['image_url'],
    );
  }
  @override
  List<Object> get props => [id, imageUrl];
}
