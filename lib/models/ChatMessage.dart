import 'package:flutter/material.dart';

class Message {
  String name;
  String group;
  String text;
  bool issender;
  ChatMessageType messageType;
  MessageStatus messageStatus;
  Message(
      {this.name,
      this.group,
      @required this.text,
      @required this.issender,
      this.messageStatus,
      this.messageType});
}
var count = myMsg.length;
List<Message> myMsg = [
  new Message(
    name: 'anees',
    group: '01-jan',
    text: 'Hi Sajol',
    issender: true,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'ali',
    group: '01-jan',
    text: 'Hello, How are you?',
    issender: false,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'jhon',
    group: '12-jan',
    text: 'Error happend',
    issender: true,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'Will',
    group: '18-jan',
    text: 'This looks great man!!',
    issender: false,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'Miranda',
    group: '30-jan',
    text: 'Glad you like it',
    issender: true,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'Danny',
    group: '30-jan',
    text: 'This looks great man!!',
    issender: false,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
 new Message(
    name: 'anees',
    group: '01-jan',
    text: 'Hi Sajol',
    issender: true,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'ali',
    group: '01-jan',
    text: 'Hello, How are you?',
    issender: false,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'jhon',
    group: '12-jan',
    text: 'Error happend',
    issender: true,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'Will',
    group: '18-jan',
    text: 'This looks great man!!',
    issender: false,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'Miranda',
    group: '30-jan',
    text: 'Glad you like it',
    issender: true,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'Danny',
    group: '30-jan',
    text: 'This looks great man!!',
    issender: false,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'anees',
    group: '01-jan',
    text: 'Hi Sajol',
    issender: true,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'ali',
    group: '01-jan',
    text: 'Hello, How are you?',
    issender: false,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'jhon',
    group: '12-jan',
    text: 'Error happend',
    issender: true,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'Will',
    group: '18-jan',
    text: 'This looks great man!!',
    issender: false,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'Miranda',
    group: '30-jan',
    text: 'Glad you like it',
    issender: true,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ),
  new Message(
    name: 'Danny',
    group: '30-jan',
    text: 'This looks great man!!',
    issender: false,
    // messageType: ChatMessageType.text,
    // messageStatus: MessageStatus.viewed,
  ), 
  // new Message(
  //   text: "",
  //   // messageType: ChatMessageType.audio,
  //   // messageStatus: MessageStatus.viewed,
  //   issender: false,
  //   group: '1-aug-2021',
  // ),
  // new Message(
  //   text: "",
  //   messageType: ChatMessageType.video,
  //   messageStatus: MessageStatus.viewed,
  //   issender: true,
  //   group: '11-aug-2021',
  // ),
  // new Message(
  //   text: "Error happend",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.not_sent,
  //   issender: true,
  //   group: '19-aug-2021',
  // )
];

// List _elements = [
//   {'name': 'John', 'group': 'Team A', 'text': 'Hi Sajol'},
//   {'name': 'Will', 'group': 'Team B', 'text': '"Hello, How are you?'},
//   {'name': 'Beth', 'group': 'Team A', 'text': 'Error happend'},
//   {'name': 'Miranda', 'group': 'Team B', 'text': 'This looks great man!!'},
//   {'name': 'Mike', 'group': 'Team C', 'text': 'Glad you like it'},
//   {'name': 'Danny', 'group': 'Team C', 'text': 'This looks great man!!'},
// ];

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }
String checkdate = '0';
String currentdate = '1-sep-2021';

class ChatMessage {
  String text;
  ChatMessageType messageType;
  MessageStatus messageStatus;
  bool isSender;
  String date;

  ChatMessage({
    this.text,
    this.messageType,
    this.messageStatus,
    this.isSender,
    this.date,
  });
}

List<ChatMessage> demeChatMessages = [
  ChatMessage(
    text: "Hi Sajol,",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    date: '15-jul-2021',
  ),
  ChatMessage(
    text: "Hello, How are you?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
    date: '23-jul-2021',
  ),
  ChatMessage(
    text: "",
    messageType: ChatMessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    date: '1-aug-2021',
  ),
  ChatMessage(
    text: "",
    messageType: ChatMessageType.video,
    messageStatus: MessageStatus.viewed,
    isSender: true,
    date: '11-aug-2021',
  ),
  ChatMessage(
    text: "Error happend",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_sent,
    isSender: true,
    date: '19-aug-2021',
  ),
  ChatMessage(
    text: "This looks great man!!",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    date: '29-aug-2021',
  ),
  ChatMessage(
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    date: '1-sep-2021',
  ),
];
