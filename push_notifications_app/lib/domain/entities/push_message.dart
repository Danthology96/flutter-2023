class PushMessage {
  final String messageID;
  final String title;
  final String body;
  final DateTime sentDate;
  final Map<String, dynamic>? data;
  final String? imageURL;

  PushMessage({
    required this.messageID,
    required this.title,
    required this.body,
    required this.sentDate,
    this.data,
    this.imageURL,
  });

  @override
  String toString() {
    return '''
PushMessage ID: $messageID,
title:          $title,
body:           $body,
sentDate:       $sentDate,
data:           $data,
imageURL:       $imageURL,
''';
  }
}
