class AccessRiskAnswerRequest {
  String? question;
  String? answer;

  AccessRiskAnswerRequest({
    this.question,
    this.answer,
  });

  AccessRiskAnswerRequest.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}
