class PaymentRecordRequest {
  String? total_amount;
  String? appointment_mode;
  String? pending_amount;
  String? paid_amount;
  String? email;
  String? date;
  String? txn_id;

  PaymentRecordRequest({
    this.total_amount,
    this.appointment_mode,
    this.pending_amount,
    this.paid_amount,
    this.email,
    this.date,
    this.txn_id,
  });

  PaymentRecordRequest.fromJson(Map<String, dynamic> json) {
    total_amount = json['total_amount'];
    appointment_mode = json['appointment_mode'];
    pending_amount = json['pending_amount'];
    paid_amount = json['paid_amount'];
    email = json['email'];
    date = json['date'];
    txn_id = json['txn_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_amount'] = total_amount;
    data['appointment_mode'] = appointment_mode;
    data['pending_amount'] = pending_amount;
    data['paid_amount'] = paid_amount;
    data['email'] = email;
    data['date'] = data;
    data['txn_id'] = txn_id;
    return data;
  }
}
