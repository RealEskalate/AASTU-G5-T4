import 'package:equatable/equatable.dart';

enum ProblemDifficultyLevel {
  unknown,
  easy,
  medium,
  hard,
}

class ProblemEntity extends Equatable {
  final int id; // Primary Key
  final int? contestId; // Foreign key, nullable
  final int? trackId; // Foreign key, nullable
  final String name;
  final String?
      difficulty; // Raw difficulty string from source (e.g., "Medium", "1500")
  final ProblemDifficultyLevel difficultyLevel; // Parsed difficulty enum
  final List<String>
      tags; // Using List<String> is more flexible than a single string
  final String platform; // e.g., "LeetCode", "Codeforces", "HackerRank"
  final String link; // URL to the problem statement
  final DateTime createdAt;
  final DateTime? updatedAt;

  // --- Potential Additions (User-specific or derived - consider if they truly belong here) ---
  // These often fit better in a separate 'UserProgress' entity or are joined/calculated later.
  // Including them here for simplicity based on the previous example's needs.
  final bool isSolved; // User-specific solved status
  final DateTime? lastSolvedAt; // User-specific timestamp
  final bool isFavorite; // User-specific favorite status
  final String? notes; // User-specific notes
  final String? solutionLink; // User-specific link to their solution

  const ProblemEntity({
    required this.id,
    this.contestId,
    this.trackId,
    required this.name,
    this.difficulty,
    required this.difficultyLevel,
    required this.tags,
    required this.platform,
    required this.link,
    required this.createdAt,
    this.updatedAt,
    // Defaults for added fields
    this.isSolved = false,
    this.lastSolvedAt,
    this.isFavorite = false,
    this.notes,
    this.solutionLink,
  });

  // Equatable implementation for easy value comparison
  @override
  List<Object?> get props => [
        id,
        contestId,
        trackId,
        name,
        difficulty,
        difficultyLevel,
        tags,
        platform,
        link,
        createdAt,
        updatedAt,
        isSolved,
        lastSolvedAt,
        isFavorite,
        notes,
        solutionLink,
      ];

  // Optional: Add copyWith method for easier state updates in Blocs/Cubits
  ProblemEntity copyWith({
    int? id,
    int? contestId,
    int? trackId,
    String? name,
    String? difficulty,
    ProblemDifficultyLevel? difficultyLevel,
    List<String>? tags,
    String? platform,
    String? link,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSolved,
    DateTime? lastSolvedAt,
    bool? isFavorite,
    String? notes,
    String? solutionLink,
  }) {
    return ProblemEntity(
      id: id ?? this.id,
      contestId: contestId ?? this.contestId,
      trackId: trackId ?? this.trackId,
      name: name ?? this.name,
      difficulty: difficulty ?? this.difficulty,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      tags: tags ?? this.tags,
      platform: platform ?? this.platform,
      link: link ?? this.link,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSolved: isSolved ?? this.isSolved,
      lastSolvedAt: lastSolvedAt ?? this.lastSolvedAt,
      isFavorite: isFavorite ?? this.isFavorite,
      notes: notes ?? this.notes,
      solutionLink: solutionLink ?? this.solutionLink,
    );
  }
}

// Helper function (can be placed here or in a utility file)
// This logic might live in the Data layer (Model's fromJson/toEntity)
// or Domain layer (if complexity warrants a helper/service).
ProblemDifficultyLevel parseDifficulty(String? difficultyString) {
  if (difficultyString == null) return ProblemDifficultyLevel.unknown;
  final lowerCaseDiff = difficultyString.toLowerCase();
  if (lowerCaseDiff == 'easy') return ProblemDifficultyLevel.easy;
  if (lowerCaseDiff == 'medium') return ProblemDifficultyLevel.medium;
  if (lowerCaseDiff == 'hard') return ProblemDifficultyLevel.hard;
  // Add more parsing logic if needed (e.g., for numeric ratings)
  // Example: int? rating = int.tryParse(difficultyString); if (rating != null) ...
  return ProblemDifficultyLevel.unknown;
}

List<String> parseTags(String? tagString) {
  if (tagString == null || tagString.isEmpty) {
    return [];
  }
  // Assuming tags in the DB are comma-separated, trim whitespace
  return tagString
      .split(',')
      .map((tag) => tag.trim())
      .where((tag) => tag.isNotEmpty)
      .toList();
}
