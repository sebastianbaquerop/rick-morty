class RickMortyModel {
  Data? data;

  RickMortyModel({this.data});

  RickMortyModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Characters? characters;

  Data({this.characters});

  Data.fromJson(Map<String, dynamic> json) {
    characters = json['characters'] != null
        ? new Characters.fromJson(json['characters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.characters != null) {
      data['characters'] = this.characters!.toJson();
    }
    return data;
  }
}

class Characters {
  Info? info;
  List<Results>? results;

  Characters({this.info, this.results});

  Characters.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  int? count;

  Info({this.count});

  Info.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class Results {
  String? name;
  String? image;
  String? status;
  String? species;

  Results({this.name, this.image, this.status, this.species});

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    status = json['status'];
    species = json['species'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    data['species'] = this.species;
    return data;
  }
}

enum Species { HUMAN, ALIEN }

enum Status { ALIVE, UNKNOWN, DEAD }
