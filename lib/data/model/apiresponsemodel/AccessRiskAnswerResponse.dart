class AccessRiskAnswerResponse {
  String? message;
  Data? data;

  AccessRiskAnswerResponse({this.message, this.data});

  AccessRiskAnswerResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? questionId;
  String? answer;

  Data({this.questionId, this.answer});

  Data.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = this.questionId;
    data['answer'] = this.answer;
    return data;
  }
}
