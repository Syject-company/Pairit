class Message {
  final String id;
  final String text;
  final DateTime time;
  final String userId;
  final String chatRoomId;

  Message({this.id, this.text, this.userId, this.time, this.chatRoomId});

  factory Message.fromJson(Map<String, dynamic> json) {

    return Message(
      id: json['id'],
      text: json['text'],
      userId: json['userId'],
      time: DateTime.parse(json['time']),
      chatRoomId: json['chatRoomId'],
    );
  }

  @override
  String toString() {
    return '\nMessage:\nid: $id, \ntext: $text, \ntime: $time, \nuserId: $userId';
  }
}