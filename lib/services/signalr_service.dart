import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/http.dart' as http;

import 'preferences_service.dart';

final serverUrl = "https://businesscardsbackend.azurewebsites.net/";

class SignalRService {

  SignalRService({this.onMessage}) {
    _connectionIsOpen = false;
  }

  PreferencesService _preferences = PreferencesService();

  // ConnectToGroups() - токен

  // SendMessage(string message, string chatId) - токен

  // RemoveFromGroup(string groupId)

  final VoidCallback onMessage;
  HubConnection _connection;

  bool _connectionIsOpen;
  bool get connectionIsOpen => _connectionIsOpen;

  Future<void> openChatConnection() async {

    if (_connection == null) {
      _connection = HubConnectionBuilder()
          .withUrl(serverUrl + "chathub",
          HttpConnectionOptions(
            accessTokenFactory: _preferences.getToken,
            skipNegotiation: true,
            transport: HttpTransportType.webSockets,
            logging: (level, message) => print('PAIRit signalR: ' +  message),
          ))
          .withAutomaticReconnect().build();
      _connection.on("ReceiveMessage", _handleIncomingMessage);
      _connection.onclose((error) => _connectionIsOpen = false);
    }

    if (_connection.state != HubConnectionState.connected) {
      await _connection.start();
      _connectionIsOpen = true;
    }

  }

  Future<void> closeChatConnection() async {
    if (_connection.state == HubConnectionState.connected) {
      await _connection.stop();
      _connectionIsOpen = false;
    }

    if (_connection != null) {
      _connection = null;
    }

  }

  Future<void> sendMessage({String message, String chatId}) async {
    await openChatConnection();
    _connection.invoke("SendMessage", args: <String>[message, chatId]);
  }

  Future<void> connectToGroups() async {
    await openChatConnection();
    _connection.invoke("ConnectToGroups");
  }

  void _handleIncomingMessage (List<dynamic> args) {
    args.forEach((element) {print(element);});

  }
}

/*class MessageManager {
  static let shared = MessageManager()

  private let storage = LocalStorage()
  private var connection: HubConnection!

  func connect(url: URL, delegate: HubConnectionDelegate) {
  connection = SwiftSignalRClient.HubConnectionBuilder(url: url)
      .withHttpConnectionOptions(configureHttpOptions: { (httpConnectionOptions) in
  httpConnectionOptions.accessTokenProvider = { Constants.token }
  })
      .withHubConnectionDelegate(delegate: delegate)
      .withLogging(minLogLevel: .error)
      .withAutoReconnect()
      .build()
  print("")
  }

  func startSession(completion: @escaping(_ message: Message)-> Void) {
  connection.on(method: "ReceiveMessage", callback: { response in

  })
  connection.start()
  }

  func conntectToGroup(completion: @escaping(_ status: Bool)-> Void) {
  connection.invoke(method: "ConnectToGroups") { error in
  if let e = error {
  print("ERROR ConnectToGroups with description: \(e.localizedDescription)")
  completion(false)
  return
  }
  completion(true)
  }
  }

  stopSession() {
  connection.stop()
  }

  sendMessage(withText message: String, chatId: String, type: MessageType, completion: @escaping(_ status: Bool)-> Void) {
  print("we try to send message")
  connection.invoke(method: "SendMessage", message, chatId, type.rawValue) { error in
  if let e = error {
  print("ERROR sending message with description: \(e.localizedDescription)")
  completion(false);
  return
  }
  completion(true);
  }
  }

}*/
