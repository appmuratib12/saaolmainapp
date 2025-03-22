class PaymentRecordData {
  String? message;
  Payment? payment;

  PaymentRecordData({this.message, this.payment});

  PaymentRecordData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payment =
        json['payment'] != null ? Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    return data;
  }
}

class Payment {
  String? totalAmount;
  String? appointmentMode;
  String? pendingAmount;
  String? paidAmount;
  String? email;
  String? date;
  String? txnId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Payment(
      {this.totalAmount,
      this.appointmentMode,
      this.pendingAmount,
      this.paidAmount,
      this.email,
      this.date,
      this.txnId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Payment.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    appointmentMode = json['appointment_mode'];
    pendingAmount = json['pending_amount'];
    paidAmount = json['paid_amount'];
    email = json['email'];
    date = json['date'];
    txnId = json['txn_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_amount'] = totalAmount;
    data['appointment_mode'] = appointmentMode;
    data['pending_amount'] = pendingAmount;
    data['paid_amount'] = paidAmount;
    data['email'] = email;
    data['txn_id'] = txnId;
    data['date'] = date;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
