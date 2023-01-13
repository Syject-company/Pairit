import 'package:pairit/entity/message.dart';

class Chat {
  String id;
  String name;
  List<String> chatPartners;
  List<Message> messages;

  Chat({this.id, this.name, this.messages, this.chatPartners});

  factory Chat.fromJson(Map<String, dynamic> json) {

    var userJson = json['appUsers'] as List;
    List<String> users = userJson.map<String>((chatJson) => chatJson['applicationUserId']).toList();
    
    var messageJson = json['messages'] as List;
    List<Message> messages = messageJson.map((chatJson) => Message.fromJson(chatJson)).toList();

    return Chat(
      id: json['id'],
      name: json['name'],
      chatPartners: users,
      messages: messages,
    );
  }

  @override
  String toString() {
    return '\nChat:\n id: $id, \n name: $name, \n chatPartner: $chatPartners, \n messages: $messages';
  }
}