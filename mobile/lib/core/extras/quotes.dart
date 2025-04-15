import 'dart:convert'; // Add this import for JSON decoding
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile/core/constants/constants.dart';

var logger = Logger();

class Quotes extends StatefulWidget {
  const Quotes({super.key});

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Future<String> GetQuotesFunc() async {
  final dio = Dio();
  String finalQuote = '';
  String QuoteAuth = '';

  try {
    final response = await dio.get(QuotesUrl);

    if (response.statusCode == 200) {
      final List<dynamic> data = (response.data); // Decode JSON response
      logger.d(data);
      finalQuote = data[0]['q'];
      QuoteAuth = data[0]['a'];
      logger.d('$finalQuote - $QuoteAuth');
      // logger.d(QuoteAuth);
      if (response.statusCode == 200) {
        return '$finalQuote - $QuoteAuth';
      } else {
        return 'No Quotes availble';
      }
    } else {
      return 'Error: ${response.statusCode}';
    }
  } catch (e) {
    return 'Cannot Retrive Quotes Try Again Later'; // Handle any exceptions
  }
}
