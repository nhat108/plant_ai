class PlantModel {
  final String id;
  final String description;
  final String family;
  final String genus;
  final List<String> images;
  final String name;

  PlantModel(
      {this.id,
      this.description,
      this.family,
      this.genus,
      this.images,
      this.name});
  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      description: json['description'],
      family: json['family'],
      genus: json['genus'],
      id: json['id'],
      images:
          (json['images'] as List)?.map((e) => e.toString())?.toList() ?? [],
      name: json['name'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'genus': genus,
      'name': name,
      'family': family,
      'description': description,
      'images': images,
    };
  }
}
