class EmagazineZeroOilResponse {
  bool? status;
  List<Data>? data;

  EmagazineZeroOilResponse({this.status, this.data});

  EmagazineZeroOilResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? image;
  String? tag;
  String? contentCard;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? chooseTreatmentDetail;
  String? month;
  String? year;
  String? iframe;
  String? date;
  String? time;
  String? youtubeLink;
  String? type;
  String? uu;
  String? header;

  Data(
      {this.id,
        this.image,
        this.tag,
        this.contentCard,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.chooseTreatmentDetail,
        this.month,
        this.year,
        this.iframe,
        this.date,
        this.time,
        this.youtubeLink,
        this.type,
        this.uu,
        this.header});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    tag = json['tag'];
    contentCard = json['content_card'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    chooseTreatmentDetail = json['choose_treatment_detail'];
    month = json['month'];
    year = json['year'];
    iframe = json['iframe'];
    date = json['date'];
    time = json['time'];
    youtubeLink = json['youtube_link'];
    type = json['type'];
    uu = json['uu'];
    header = json['header'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['tag'] = this.tag;
    data['content_card'] = this.contentCard;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['choose_treatment_detail'] = this.chooseTreatmentDetail;
    data['month'] = this.month;
    data['year'] = this.year;
    data['iframe'] = this.iframe;
    data['date'] = this.date;
    data['time'] = this.time;
    data['youtube_link'] = this.youtubeLink;
    data['type'] = this.type;
    data['uu'] = this.uu;
    data['header'] = this.header;
    return data;
  }
}
