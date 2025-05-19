class EmagazineResponse {
  String? year;
  List<Emagzines>? emagzines;

  EmagazineResponse({this.year, this.emagzines});

  EmagazineResponse.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    if (json['emagzines'] != null) {
      emagzines = <Emagzines>[];
      json['emagzines'].forEach((v) {
        emagzines!.add(new Emagzines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    if (this.emagzines != null) {
      data['emagzines'] = this.emagzines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Emagzines {
  int? id;
  String? year;
  String? month;
  String? header;
  String? image;
  String? date;

  Emagzines(
      {this.id, this.year, this.month, this.header, this.image, this.date});

  Emagzines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    month = json['month'];
    header = json['header'];
    image = json['image'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['month'] = this.month;
    data['header'] = this.header;
    data['image'] = this.image;
    data['date'] = this.date;
    return data;
  }
}
