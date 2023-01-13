import 'package:flutter/material.dart';
import 'package:pairit/entity/chat.dart';
import 'package:pairit/entity/user.dart';
import 'package:pairit/services/api_service.dart';
import 'package:pairit/widgets.dart';

class ChatTail extends StatelessWidget {
  final Chat chat;
  final String currentUserId;

  ChatTail({this.currentUserId, this.chat});

  ApiService _service = ApiService();

  @override
  Widget build(BuildContext context) {


    String partnerId;

    if (chat.chatPartners[0] == currentUserId) {
      partnerId = chat.chatPartners[1];
    } else {
      partnerId = chat.chatPartners[0];
    }

    print(partnerId);

    return FutureBuilder<User>(
      future: _service.getUserById(partnerId),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          print(snapshot.data);
          return ListTile(
            onTap: () {

            },
            contentPadding: EdgeInsets.all(12),
            title: Text(
                '${snapshot.data.firstName} ${snapshot.data.lastName}'
            ),
            subtitle: Text(
                'message'
            ),
            leading: Container(
              child: CirclePairAvatar(
                child: Image.network(snapshot.data.profileImage),
                radius: 28,
                width: 4,
                changeable: false,
                onAdd: () {},
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
