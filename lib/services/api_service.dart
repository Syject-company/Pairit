import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:pairit/entity/card.dart';
import 'package:pairit/entity/card_element_key.dart';
import 'package:pairit/entity/card_templates.dart';
import 'package:pairit/entity/chat.dart';
import 'package:pairit/entity/user.dart';
import 'package:pairit/entity/user_data.dart';
import 'package:pairit/provider/element_provider.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String _apiUrl = 'https://businesscardsbackend.azurewebsites.net/api/';
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Registration
  Future<String> registerUser(String email, String password, String checkingPassword) async {
    String message;
    var res = await http.post(_apiUrl + 'Account/register',
      body: jsonEncode({
        "email" : email,
        "password" : password,
        "passwordconfirm" : checkingPassword,
      }),
      headers: {"Content-type" : "application/json"},
    );

    print('status code ' + res.statusCode.toString());

    if (res.statusCode != 200) {
      message = res.body.substring(2, res.body.length-2).replaceAll("\",\"", " ");
      print(message);
    }

    if(res.statusCode == 200) {
      Map<String, dynamic> parsed = json.decode(res.body);
      String token = parsed['token'];

      print(token);
      final SharedPreferences prefs = await _prefs;
      prefs.setString("token", token);
    }
    return message;
  }

  // Login
  Future<bool> loginUser(String email, String password) async {
    bool result;
    var res = await http.post(_apiUrl + 'Account/login',
      body: jsonEncode({
        "email" : email,
        "password" : password,
      }),
      headers: {"Content-type" : "application/json"},
    );

    result = res.statusCode == 200;

    if(result) {
      Map<String, dynamic> parsed = json.decode(res.body);
      String token = parsed['token'];

      print(token);
      final SharedPreferences prefs = await _prefs;
      prefs.setString("token", token);
    }

    return result;
  }

  // Forgot Password
  Future<bool> forgotPassword(String email) async {
    var res = await http.post(_apiUrl + 'Account/ForgotPassword',
      body: jsonEncode({
        "email" : email
      }),
      headers: {"Content-type" : "application/json"},
    );

    print('Forgot Password ' + res.statusCode.toString());

    return res.statusCode == 200;
  }

  // Update
  Future<bool> updateUser(User user) async {
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var res = await http.post(_apiUrl + 'Account/updateuser',
    body: jsonEncode({
      "firstName": user.firstName,
      "lastName" : user.lastName,
      "address" : user.address,
      "phoneNumber" : user.phoneNumber1,
      "secondPhoneNumber" : user.phoneNumber2,
      "companyName" : user.company,
      "position" : user.position,
      "facebookLink" : user.socialLink1,
      "instagramLink" : user.socialLink2,
    }),
    headers: {"Content-type" : "application/json", 'Authorization':'Bearer ' + token},
    );

    print('update user ' + res.statusCode.toString());

    return res.statusCode == 200;
  }

  // Get user with token
  Future<User> getCurrentUser() async {
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var res = await http.get(_apiUrl + 'Account/getuserbytoken',
      headers: {"Content-type" : "application/json", 'Authorization':'Bearer ' + token},
    );

    print('get current user ' + res.statusCode.toString());
    Map<String, dynamic> parse = json.decode(res.body);

    User user = User.fromJson(parse);

    return user;
  }

  // Get user by user Id
  Future<User> getUserById(String userId) async {
    print('user by id ' + userId);

    var res = await http.get(_apiUrl + 'Account/' + userId,
      headers: {"Content-type" : "application/json"},
    );

    print('get user ' + res.statusCode.toString());
    Map<String, dynamic> parse = json.decode(res.body);

    User user = User.fromJson(parse);

    return user;
  }

  // Get all user info with token
  Future<UserData> getAllUserInfo() async {
    UserData userData;
    BusinessCard personalCard;
    List<BusinessCard> cards;

    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var res = await http.get(_apiUrl + 'Account/getuserbytoken',
      headers: {"Content-type" : "application/json", 'Authorization':'Bearer ' + token},
    );

    print('get user ' + res.statusCode.toString());
    Map<String, dynamic> parse = json.decode(res.body);

    User user = User.fromJson(parse);

    if(parse['personalCard'] != null) {
      personalCard = BusinessCard.fromJson(parse['personalCard']);
      print(personalCard);
    }

    var cardsJson = parse['cards'] as List;
    cards = cardsJson.map((cardJson) => BusinessCard.fromJson(cardJson)).toList();

    userData = UserData(user: user, addedCards: cards, personalCard: personalCard);
    return userData;
  }

  // Upload Profile Image
  Future<void> uploadProfileImage(File imageFile) async {
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(_apiUrl + "Account/uploadimage/1");

    var request = new http.MultipartRequest("POST", uri)..headers['Authorization'] = 'Bearer ' + token;
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);

    var response = await request.send();
    print(request.headers);
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  // Upload Company Logo
  Future<void> uploadCompanyLogo(File imageFile) async {
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(_apiUrl + "Account/uploadimage/0");

    var request = new http.MultipartRequest("POST", uri)..headers['Authorization'] = 'Bearer ' + token;

    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  // Upload background
  Future<bool> uploadBackgroundImage(Uint8List imageFile) async {

    print('upload background image');
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var uri = Uri.parse(_apiUrl + "Account/uploadimage/2");

    var request = new http.MultipartRequest("POST", uri)..headers['Authorization'] = 'Bearer ' + token;

    var multipartFile = new http.MultipartFile.fromBytes('image', imageFile, filename: 'BACK.jpg');


    request.files.add(multipartFile);

    var response = await request.send();

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

    print('upload background ' + response.statusCode.toString());
    return (response.statusCode == 200);
  }

  // Upload photo on card
  Future<void> uploadCardPhoto(File imageFile) async {
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(_apiUrl + "Account/uploadimage/3");

    var request = new http.MultipartRequest("POST", uri)..headers['Authorization'] = 'Bearer ' + token;

    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  // Get all templates of business cards from API
  Future<List<CardTemplates>> getTemplates() async {
    var res = await http.get(_apiUrl + 'CardTemplates',
      headers: {"Content-type" : "application/json"},
    );

    print('get templates');

    final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
    List<CardTemplates> templates = parsed.map<CardTemplates>((json) => CardTemplates.fromJson(json)).toList();

    return templates;
  }

  // Create new personal card
  Future<BusinessCard> createCard(BusinessCard card) async {
    print('Card creating');

    BusinessCard personalCard;

    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var res = await http.post(_apiUrl + 'Cards',
      headers: {"Content-type" : "application/json", 'Authorization':'Bearer ' + token},
      body: card.saveCardJson(),
    );

    Map<String, dynamic> parse = json.decode(res.body);

    if(res.statusCode == 201) {
      personalCard = BusinessCard.fromJson(parse);
    }

    return personalCard;
  }

  // Update current card
  Future<bool> updateCard(BusinessCard card) async {

    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var res = await http.put(_apiUrl + 'Cards/' + card.id.toString(),
      headers: {"Content-type" : "application/json", 'Authorization':'Bearer ' + token},
      body: card.toJson(),
    );

    print(card.components.firstWhere((element) => element.elementKey == ElementKey.phoneNumber1));

    print("Card updating" + res.statusCode.toString());

    return res.statusCode == 204;
  }

  // Get card by id
  Future<BusinessCard> getCardById(int id) async {

    BusinessCard card;
    var res = await http.get(_apiUrl + 'Cards/' + id.toString(),
      headers: {"Content-type" : "application/json"},
    );

    Map<String, dynamic> parse = json.decode(res.body);

    if(res.statusCode == 200) {
      card = BusinessCard.fromJson(parse);
    }

    return card;
  }

  // Add card by id
  Future<List<BusinessCard>> addCard(int id) async {
    List<BusinessCard> cards;
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var res = await http.post(_apiUrl + 'Account/addcard/' + id.toString(),
      headers: {"Content-type" : "application/json", 'Authorization':'Bearer ' + token},
    );

    print('connecting card status ' + res.statusCode.toString());

    if(res.statusCode == 201) {
      getAllUserInfo().then((value) {
        print('user info, added cards count = ' + value.addedCards.length.toString());
        cards = value.addedCards;
      });
    }

    return cards;
  }

  // Remove card by id
  Future<List<BusinessCard>>removeCard(int id) async {
    List<BusinessCard> cards;
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var res = await http.post(_apiUrl + 'Account/removecard/' + id.toString(),
      headers: {"Content-type" : "application/json", 'Authorization':'Bearer ' + token},
    );

    print('remove card status ' + res.statusCode.toString());

    if(res.statusCode == 201) {
      getAllUserInfo().then((value) {
        print('user info, added cards count = ' + value.addedCards.length.toString());
        cards = value.addedCards;
      });
    }

    return cards;
  }

  // Get all users chats
  Future<List<Chat>> getChatRooms() async {
    List<Chat> chats;

    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");

    var res = await http.get(_apiUrl + 'ChatRooms',
      headers: {"Content-type" : "application/json", 'Authorization':'Bearer ' + token},
    );

    print('get chat rooms ' + res.statusCode.toString());

    final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
    chats = parsed.map<Chat>((json) => Chat.fromJson(json)).toList();

    print(chats);

    return chats;
  }

  Future<BusinessCard> saveImages(Uint8List backgroundFile, int cardId) async {
    print('file is not null ' + (backgroundFile != null).toString());
    BusinessCard cardData;

    if(backgroundFile != null) {
      uploadBackgroundImage(backgroundFile).then((saved) {
        print('image uploaded');
        if(saved) {
          getCardById(cardId).then((value) => cardData = value);
          return cardData;
        } else {
          print('not saved');
          return null;
        }
      });
    } else {
      print('not saved at all');
      return null;
    }
  }

}