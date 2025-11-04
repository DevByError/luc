import 'package:flutter/material.dart';

enum MessageSender { user, bot }

@immutable
class ChatMessage {
  final String text;
  final MessageSender sender;
  final DateTime timestamp;

  const ChatMessage({
    required this.text,
    required this.sender,
    required this.timestamp,
  });
}
