import 'dart:convert';
import 'package:flutter/services.dart';

class ApiClient {
  bool simulateNetworkFailure = false;

  // Simulates loading data from mock JSON files
  Future<String> getLessonsRaw() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate latency
    if (simulateNetworkFailure) {
      throw Exception('Simulated network failure');
    }
    return await rootBundle.loadString('assets/mock_data/lessons.json');
  }

  Future<String> getQuizzesRaw() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (simulateNetworkFailure) {
      throw Exception('Simulated network failure');
    }
    return await rootBundle.loadString('assets/mock_data/quizzes.json');
  }
}