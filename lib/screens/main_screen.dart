
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pairit/provider/user_provider.dart';
import 'package:pairit/screens/chat_page.dart';
import 'package:pairit/screens/home_page.dart';
import 'package:pairit/services/signalr_service.dart';
import 'package:provider/provider.dart';

import '../states.dart';
import '../ui_elements.dart';
import '../widgets.dart';
import 'card_page.dart';
import 'edit_profile_screen.dart';
import 'select_card_template.dart';

class MainActivityScreen extends StatefulWidget {

  @override
  _MainActivityScreenState createState() => _MainActivityScreenState();
}

class _MainActivityScreenState extends State<MainActivityScreen> {
  // Services
  SignalRService _signalR;

  // Screen states
  PageController pageController;
  int activePage = 1;
  double _position;
  bool isHideQR = true;


  @override
  void initState() {
    _signalR = SignalRService(
      onMessage: () {},
    );
    _signalR.openChatConnection();

    super.initState();
  }

  @override
  void dispose() {
    _signalR.closeChatConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserProvider>(context);

    _position = isHideQR ? -310 : 0;
    pageController = PageController(initialPage: activePage);

    print(userState.personalCard?.qrUrl);


    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onVerticalDragUpdate: (details) {
              print(details.delta);
              if(details.delta.dy.sign == -1) {
                setState(() {
                  isHideQR = true;
                });
              } else {
                setState(() {
                  isHideQR = false;
                });
              }
            },
            child: Container(
              height: 100,
              width: 300,
              color: accentColor,
            ),
          ),
          backgroundColor: accentColor,
          elevation: isHideQR ? 6 : 0,
          actions: [
            isHideQR ? GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfileScreen()));
              },
              child: Container(
                padding: EdgeInsets.only(right: 12),
                alignment: Alignment.center,
                child: CirclePairAvatar(
                  radius: 20,
                  width: 3,
                  changeable: false,
                  child: (userState.user.profileImage != null && userState.user.profileImage.isNotEmpty)
                      ? Image.network(userState.user.profileImage)
                      : Image.asset('assets/images/def_avatar.png'),
                ),
              )
            ) : SizedBox(),
          ],
          leading: isHideQR ? Container(
            padding: EdgeInsets.only(left: 12),
            child: SvgPicture.asset('assets/images/Logo.svg', fit: BoxFit.fitWidth,),
          ) : SizedBox(),
        ),
        body: Stack(
          children: [
            PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                CardPage(),
                HomePage(),
                ChatPage(),
              ],
            ),
            AnimatedContainer(
              transform:Matrix4.translationValues(0, _position, 0),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  print(details.delta);
                  if(details.delta.dy.sign == -1) {
                    setState(() {
                      isHideQR = true;
                    });
                  } else {
                    setState(() {
                      isHideQR = false;
                    });
                  }
                },
                child: TopMainShape(
                  height: 300,
                  body: Container(
                    padding: EdgeInsets.only(
                      top: 60,
                      bottom: 60,
                    ),
                    child: userState.personalCard?.qrUrl != null
                        ? Image.network(userState.personalCard.qrUrl, scale: 0.3,) :
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SelectCardTemplate()));
                        },
                        child: Text(
                          '+',
                          style: TextStyle(
                            color: Colors.white30,
                            fontWeight: FontWeight.bold,
                            fontSize: 160,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomCustomTabBar(
          activeTab: activePage,
          onFirstButtonTab: () {
            pageController.animateToPage(0, duration: Duration(milliseconds: 250), curve: Curves.ease);
          },
          onSecondButtonTab: () {
            pageController.animateToPage(1, duration: Duration(milliseconds: 250), curve: Curves.ease);
          },
          onThirdButtonTab: () {
            pageController.animateToPage(2, duration: Duration(milliseconds: 250), curve: Curves.ease);
          },
        )
      ),
    );
  }
}
