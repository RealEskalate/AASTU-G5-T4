import '../../domain/entities/problem_entity.dart';

// This Model represents the data structure as stored/retrieved.
// It might have different field names or types than the Entity initially.
class ProblemModel extends ProblemEntity {
  const ProblemModel({
    required super.id,
    super.contestId,
    super.trackId,
    required super.name,
    super.difficulty, // Raw string from data source
    required super.difficultyLevel, // Parsed enum
    required super.tags, // List from data source (after parsing)
    required super.platform,
    required super.link,
    required super.createdAt,
    super.updatedAt,
    // User-specific fields (assuming they are stored with the problem in this simplified case)
    super.isSolved,
    super.lastSolvedAt,
    super.isFavorite,
    super.notes,
    super.solutionLink,
  });

  // Factory constructor to create a ProblemModel from a database map
  factory ProblemModel.fromMap(Map<String, dynamic> map) {
    final rawDifficulty = map['difficulty'] as String?;
    final rawTags =
        map['tag'] as String?; // Assuming 'tag' column stores comma-separated

    return ProblemModel(
      id: map['id'] as int,
      contestId: map['contest_id'] as int?,
      trackId: map['track_id'] as int?,
      name: map['name'] as String? ?? '',
      difficulty: rawDifficulty,
      difficultyLevel: parseDifficulty(rawDifficulty), // Use helper
      tags: parseTags(rawTags), // Use helper
      platform: map['platform'] as String? ?? 'Unknown',
      link: map['link'] as String? ?? '',
      // Handle timestamp conversion (depends on DB driver: int, String, etc.)
      createdAt: _parseTimestamp(map['created_at']) ??
          DateTime.now(), // Provide default
      updatedAt: _parseTimestamp(map['updated_at']),
      // Assuming user fields are directly in the map for this simplified model
      isSolved: (map['is_solved'] as int? ?? 0) ==
          1, // Assuming DB stores bool as 0/1
      lastSolvedAt: _parseTimestamp(map['last_solved_at']),
      isFavorite: (map['is_favorite'] as int? ?? 0) == 1,
      notes: map['notes'] as String?,
      solutionLink: map['solution_link'] as String?,
    );
  }

  // Factory constructor to create a ProblemModel from JSON (e.g., API response)
  // Adjust field names ('contest_id' vs 'contestId') based on API spec
  factory ProblemModel.fromJson(Map<String, dynamic> json) {
    final rawDifficulty = json['difficulty'] as String?;
    // Assuming tags might come as a list OR a string from different APIs
    List<String> tagsFromJson;
    if (json['tags'] is List) {
      tagsFromJson = List<String>.from(json['tags'].map((x) => x.toString()));
    } else if (json['tag'] is String) {
      // Check for single 'tag' field
      tagsFromJson = parseTags(json['tag'] as String?);
    } else {
      tagsFromJson = [];
    }

    return ProblemModel(
      id: json['id'] as int? ?? 0, // Handle potential null ID from API?
      contestId: json['contest_id'] as int? ??
          json['contestId'] as int?, // Allow different casings
      trackId: json['track_id'] as int? ?? json['trackId'] as int?,
      name: json['name'] as String? ?? '',
      difficulty: rawDifficulty,
      difficultyLevel: parseDifficulty(rawDifficulty),
      tags: tagsFromJson,
      platform: json['platform'] as String? ?? 'Unknown',
      link: json['link'] as String? ?? '',
      createdAt: _parseTimestamp(json['created_at'] ?? json['createdAt']) ??
          DateTime.now(),
      updatedAt: _parseTimestamp(json['updated_at'] ?? json['updatedAt']),
      // Assuming API might return these fields directly
      isSolved:
          json['is_solved'] as bool? ?? json['isSolved'] as bool? ?? false,
      lastSolvedAt:
          _parseTimestamp(json['last_solved_at'] ?? json['lastSolvedAt']),
      isFavorite:
          json['is_favorite'] as bool? ?? json['isFavorite'] as bool? ?? false,
      notes: json['notes'] as String?,
      solutionLink: json['solution_link'] ?? json['solutionLink'] as String?,
    );
  }

  // Method to convert ProblemModel instance to a map for database insertion/update
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Usually omitted for inserts if auto-incrementing
      'contest_id': contestId,
      'track_id': trackId,
      'name': name,
      'difficulty': difficulty,
      // Store tags back as comma-separated string for DB (if schema requires it)
      'tag': tags.join(','),
      'platform': platform,
      'link': link,
      // Convert DateTime to format suitable for DB (int timestamp, ISO string)
      'created_at':
          createdAt.toIso8601String(), // Or createdAt.millisecondsSinceEpoch
      'updated_at':
          updatedAt?.toIso8601String(), // Or updatedAt?.millisecondsSinceEpoch
      // Convert user-specific fields back
      'is_solved': isSolved ? 1 : 0,
      'last_solved_at': lastSolvedAt?.toIso8601String(),
      'is_favorite': isFavorite ? 1 : 0,
      'notes': notes,
      'solution_link': solutionLink,
    };
  }

  // Method to convert ProblemModel instance to JSON for sending to an API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contestId': contestId, // Use camelCase or snake_case as API expects
      'trackId': trackId,
      'name': name,
      'difficulty': difficulty,
      'tags': tags, // Send as list if API expects list
      'platform': platform,
      'link': link,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isSolved': isSolved,
      'lastSolvedAt': lastSolvedAt?.toIso8601String(),
      'isFavorite': isFavorite,
      'notes': notes,
      'solutionLink': solutionLink,
    };
  }

  // Helper function to parse timestamps which might be int (epoch) or String (ISO)
  static DateTime? _parseTimestamp(dynamic timestamp) {
    if (timestamp == null) return null;
    if (timestamp is int) {
      // Assuming milliseconds since epoch
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    if (timestamp is String) {
      return DateTime.tryParse(timestamp);
    }
    return null; // Or throw an error if format is unexpected
  }

  // Although ProblemModel extends ProblemEntity, having an explicit conversion
  // can be useful if there were mapping logic needed beyond direct field copying.
  // In this case, it's identical because of inheritance.
  ProblemEntity toEntity() {
    return this; // Direct conversion due to inheritance
  }

  // Static factory to create a Model from an Entity (useful for saving)
  factory ProblemModel.fromEntity(ProblemEntity entity) {
    return ProblemModel(
      id: entity.id,
      contestId: entity.contestId,
      trackId: entity.trackId,
      name: entity.name,
      difficulty: entity.difficulty,
      difficultyLevel: entity.difficultyLevel,
      tags: entity.tags,
      platform: entity.platform,
      link: entity.link,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isSolved: entity.isSolved,
      lastSolvedAt: entity.lastSolvedAt,
      isFavorite: entity.isFavorite,
      notes: entity.notes,
      solutionLink: entity.solutionLink,
    );
  }
}
