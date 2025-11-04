import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:luc/models/chat_message.dart';
import 'package:string_similarity/string_similarity.dart';

class ChatbotService extends ChangeNotifier {
  // --- CONFIGURATION ---
  // --- PASTE YOUR KEY CAREFULLY HERE ---
  final String _apiKey = "AIzaSyBEeeOiIcYQ-CUu4xqy0yyJA7yoLrPF-iA";
  // -------------------------------------
  final double _confidenceThreshold = 0.6;
  // ---------------------

  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  List<Map<String, dynamic>> _faqData = [];
  GenerativeModel? _generativeModel;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  ChatbotService() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadFaqData();

    // This is our definitive test. It will print whatever is in the _apiKey variable.
    debugPrint("Inspecting API Key variable. Value is: '$_apiKey'");

    if (_apiKey.isNotEmpty && _apiKey != "here you put the api") {
      _generativeModel = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: _apiKey,
      );
      // This will only print if the 'if' statement is true.
      debugPrint("✅ Gemini AI Model has been successfully initialized.");
    }
    _addInitialBotMessage();
  }

  Future<void> _loadFaqData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/faq.json');
      final data = await json.decode(response);
      _faqData = List<Map<String, dynamic>>.from(data);
    } catch (e) {
      debugPrint("Error loading FAQ data: $e");
    }
  }

  void _addInitialBotMessage() {
    _messages.add(
      ChatMessage(
        text: "Hello! I'm your AI Assistant. How can I help you today?",
        sender: MessageSender.bot,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    _messages.add(
      ChatMessage(
        text: userMessage,
        sender: MessageSender.user,
        timestamp: DateTime.now(),
      ),
    );
    _isLoading = true;
    notifyListeners();

    String response;
    final localMatch = _findBestMatchLocal(userMessage);

    if (localMatch != null) {
      response = localMatch['answer'] as String;
    } else {
      response = await _getGeminiResponse(userMessage);
    }

    _messages.add(
      ChatMessage(
        text: response,
        sender: MessageSender.bot,
        timestamp: DateTime.now(),
      ),
    );
    _isLoading = false;
    notifyListeners();
  }

  Map<String, dynamic>? _findBestMatchLocal(String query) {
    if (_faqData.isEmpty) return null;

    final questions = _faqData.map((e) => e['question'] as String).toList();
    final bestMatch =
        StringSimilarity.findBestMatch(query.toLowerCase(), questions);

    if (bestMatch.bestMatch.rating != null &&
        bestMatch.bestMatch.rating! >= _confidenceThreshold) {
      return _faqData[bestMatch.bestMatchIndex];
    }
    return null;
  }

  Future<String> _getGeminiResponse(String query) async {
    if (_generativeModel == null) {
      return "I'm sorry, my online AI capabilities are not configured. Please contact support.";
    }

    try {
      final prompt =
          "You are a helpful assistant for Lincoln University College. Answer the following student question concisely and politely. Question: '$query'";
      final content = [Content.text(prompt)];
      final response = await _generativeModel!.generateContent(content);

      return response.text ??
          "I'm sorry, I couldn't process that. Could you rephrase?";
    } catch (e) {
      debugPrint("Gemini API Error: $e");
      return "I'm having trouble connecting to my advanced knowledge base. Please check your internet connection and try again.";
    }
  }
}
