import 'package:flutter/material.dart';
import 'package:pairit/card_utils/card_element_utils.dart';
import 'package:pairit/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'chat_screen_elements/chats_list_tail.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserProvider>(context);
    return ((userState.addedCards?.length ?? 0) != 0) ?
    ListView.separated(
      padding: EdgeInsets.only(
        top: 12,
      ),
      itemCount: userState.chatRooms?.length ?? 0,
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Divider(height: 1, color: Colors.black,),
      ),
      itemBuilder: (context, index) {
        return ChatTail(
          chat: userState.chatRooms[index],
          currentUserId: userState.user.id,
        );
      },
    ) : Center(
      child: Text(
          'You have not connect any card yet'
      ),
    );
  }
}
