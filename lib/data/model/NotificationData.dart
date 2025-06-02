class NotificationData {
  final String? title;
  final String? body;
  final String? imageUrl;
  final int? id;
  final bool isRead; // 👈 Add this

  NotificationData({
    this.id,
    this.title,
    this.body,
    this.imageUrl,
    this.isRead = false, // default false
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'body': body,
    'imageUrl': imageUrl,
    'isRead': isRead ? 1 : 0,
  };

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      imageUrl: map['imageUrl'],
      isRead: map['isRead'] == 1,
    );
  }
}
