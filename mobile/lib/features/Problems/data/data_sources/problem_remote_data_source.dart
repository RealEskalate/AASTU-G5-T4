import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/core/error/exception.dart'; // Define exceptions (see below)

import 'package:mobile/features/Problems/data/models/problem_model.dart';
import 'package:mobile/features/Problems/domain/entities/problem_entity.dart';
import 'package:mobile/features/Problems/presentation/widgets/data_table.dart';

abstract class ProblemRemoteDataSource {
  Future<(List<ProblemModel>, int)> getProblemsFromApi({
    required int page,
    required int limit,
    List<String>? platforms,
    List<ProblemDifficultyLevel>? difficulties,
    List<String>? tags,
    bool? isSolved,
    String? sortColumn,
    SortDirection? sortDirection,
  });
}

class ProblemRemoteDataSourceImpl implements ProblemRemoteDataSource {
  final http.Client client;
  final String baseUrl = "https://your-backend-api.com"; // <<< CHANGE THIS

  ProblemRemoteDataSourceImpl({required this.client});

  @override
  Future<(List<ProblemModel>, int)> getProblemsFromApi({
    required int page,
    required int limit,
    List<String>? platforms,
    List<ProblemDifficultyLevel>? difficulties,
    List<String>? tags,
    bool? isSolved,
    String? sortColumn,
    SortDirection? sortDirection,
  }) async {
    // 1. Construct Query Parameters
    final Map<String, String> queryParams = {
      'page': page.toString(),
      'limit': limit.toString(),
      if (platforms != null && platforms.isNotEmpty)
        'platforms':
            platforms.join(','), // Example: platforms=leetcode,codeforces
      if (difficulties != null && difficulties.isNotEmpty)
        'difficulties':
            difficulties.map((d) => d.name).join(','), // Send enum names
      if (tags != null && tags.isNotEmpty) 'tags': tags.join(','),
      if (isSolved != null) 'solved': isSolved.toString(),
      if (sortColumn != null) 'sort': sortColumn,
      if (sortDirection != null)
        'order': sortDirection == SortDirection.ascending ? 'asc' : 'desc',
    };

    // 2. Build URL
    final uri =
        Uri.parse('$baseUrl/problems').replace(queryParameters: queryParams);
    print(
        "Fetching problems from: $uri"); // Logging URL is helpful for debugging

    // 3. Make HTTP Request
    try {
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json'
        }, // Add other headers if needed (e.g., Auth)
      ).timeout(const Duration(seconds: 15)); // Add timeout

      // 4. Handle Response
      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);

        // *** IMPORTANT: Adapt this parsing based on your ACTUAL API response structure ***
        if (decodedJson is Map<String, dynamic> &&
            decodedJson['data'] is List &&
            decodedJson['totalCount'] is int) {
          final List<dynamic> problemsJson = decodedJson['data'];
          final int totalCount = decodedJson['totalCount'];

          final List<ProblemModel> problems = problemsJson
              .map((jsonItem) =>
                  ProblemModel.fromJson(jsonItem as Map<String, dynamic>))
              .toList();

          return (problems, totalCount); // Return tuple
        } else {
          // Throw if the response structure is not as expected
          throw ParsingException(details: 'Unexpected API response format');
        }
      } else {
        // Throw ServerException for non-200 status codes
        throw ServerException(
            statusCode: response.statusCode, details: response.body);
      }
    } on FormatException catch (e) {
      debugPrint("JSON Parsing Error: $e");
      throw ParsingException(details: 'Failed to parse server response.');
    } on http.ClientException catch (e) {
      // Catches network-related errors from http client
      debugPrint("Network Error: $e");
      throw NetworkException();
    } catch (e) {
      // Catch other potential errors
      debugPrint("Unknown Error during API call: $e");
      throw ServerException(
          details:
              'An unexpected error occurred: $e'); // Treat as server error?
    }
  }
}
