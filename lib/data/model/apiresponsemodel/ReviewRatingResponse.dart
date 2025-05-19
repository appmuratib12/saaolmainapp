class ReviewRatingResponse {
  bool? success;
  String? message;
  List<Data>? data;

  ReviewRatingResponse({this.success, this.message, this.data});

  ReviewRatingResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? authorName;
  String? profilePhotoUrl;
  String? text;
  int? rating;

  Data({this.authorName, this.profilePhotoUrl, this.text, this.rating});

  Data.fromJson(Map<String, dynamic> json) {
    authorName = json['author_name'];
    profilePhotoUrl = json['profile_photo_url'];
    text = json['text'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author_name'] = authorName;
    data['profile_photo_url'] = profilePhotoUrl;
    data['text'] = text;
    data['rating'] = rating;
    return data;
  }
}
