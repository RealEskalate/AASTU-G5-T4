import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:mobile/core/error/failure.dart';
import 'package:mobile/features/Problems/data/models/problem_model.dart';
import 'package:mobile/features/Problems/domain/entities/problem_entity.dart';
import 'package:mobile/features/Problems/presentation/widgets/data_table.dart';

part 'problems_event.dart';
part 'problems_state.dart';

// Define Default Values
const int defaultPage = 1;
const int defaultItemsPerPage = 50; // Or your preferred default

class ProblemsBloc extends Bloc<ProblemsEvent, ProblemsState> {
  // TODO: Inject actual GetProblemsUseCase
  // final GetProblemsUseCase _getProblemsUseCase;

  // Internal state for pagination and filters - This is one way to manage it.
  // Alternatively, always read from the current `ProblemsLoadSuccess` state.
  ProblemFilters _currentFilters = ProblemFilters.initial();
  int _currentPage = defaultPage;
  int _itemsPerPage = defaultItemsPerPage;

  ProblemsBloc(
      // TODO: required GetProblemsUseCase getProblemsUseCase
      )
      : // _getProblemsUseCase = getProblemsUseCase,
        super(ProblemsInitial()) {
    // Register handlers for all events
    on<FetchProblems>(_onFetchProblems);
    on<FiltersChanged>(_onFiltersChanged);
    on<PageChanged>(_onPageChanged);
    on<ItemsPerPageChanged>(_onItemsPerPageChanged);
    on<SortChanged>(_onSortChanged);
  }

  // --- Event Handlers ---

  Future<void> _onFetchProblems(
    FetchProblems event,
    Emitter<ProblemsState> emit,
  ) async {
    // Use current internal state for page, filters, etc.
    await _fetchAndEmitProblems(
      emit: emit,
      page: _currentPage, // Use internal state
      itemsPerPage: _itemsPerPage, // Use internal state
      filters: _currentFilters, // Use internal state
      isFilteringOrPaging: event.refresh, // Indicate if it's just a refresh
    );
  }

  Future<void> _onFiltersChanged(
    FiltersChanged event,
    Emitter<ProblemsState> emit,
  ) async {
    // Update internal filters
    _currentFilters = ProblemFilters(
      // Create new filter object
      platforms: event.platforms,
      difficulties: event.difficulties,
      tags: event.tags,
      isSolved: event.isSolved,
      // Keep existing sort settings when filters change
      sortColumn: _currentFilters.sortColumn,
      sortDirection: _currentFilters.sortDirection,
    );
    // Reset page to 1 when filters change
    _currentPage = defaultPage;

    await _fetchAndEmitProblems(
      emit: emit,
      page: _currentPage, // Use updated page (1)
      itemsPerPage: _itemsPerPage,
      filters: _currentFilters, // Use updated filters
      isFilteringOrPaging: true,
    );
  }

  Future<void> _onSortChanged(
    SortChanged event,
    Emitter<ProblemsState> emit,
  ) async {
    // Update internal filters with new sort parameters
    _currentFilters = _currentFilters.copyWith(
      sortColumn: () => event.columnId,
      sortDirection: () => event.direction,
    );
    // Reset page to 1 when sort changes
    _currentPage = defaultPage;

    await _fetchAndEmitProblems(
      emit: emit,
      page: _currentPage, // Use updated page (1)
      itemsPerPage: _itemsPerPage,
      filters: _currentFilters, // Use updated filters (with sort)
      isFilteringOrPaging: true,
    );
  }

  Future<void> _onPageChanged(
    PageChanged event,
    Emitter<ProblemsState> emit,
  ) async {
    if (event.newPage <= 0) return; // Ignore invalid page numbers
    _currentPage = event.newPage;

    await _fetchAndEmitProblems(
      emit: emit,
      page: _currentPage, // Use new page
      itemsPerPage: _itemsPerPage,
      filters: _currentFilters,
      isFilteringOrPaging: true,
    );
  }

  Future<void> _onItemsPerPageChanged(
    ItemsPerPageChanged event,
    Emitter<ProblemsState> emit,
  ) async {
    if (event.newSize <= 0) return; // Ignore invalid size
    _itemsPerPage = event.newSize;
    // Reset page to 1 when size changes
    _currentPage = defaultPage;

    await _fetchAndEmitProblems(
      emit: emit,
      page: _currentPage, // Use updated page (1)
      itemsPerPage: _itemsPerPage, // Use new size
      filters: _currentFilters,
      isFilteringOrPaging: true,
    );
  }

  // --- Core Fetching Logic ---

  Future<void> _fetchAndEmitProblems({
    required Emitter<ProblemsState> emit,
    required int page,
    required int itemsPerPage,
    required ProblemFilters filters,
    bool isFilteringOrPaging = false, // Flag to differentiate UI
  }) async {
    // Check if already loading a full refresh to avoid duplicate calls
    // Allow filtering/paging calls even if already in success state
    if (state is ProblemsLoadInProgress && !isFilteringOrPaging) {
      return;
    }

    emit(ProblemsLoadInProgress(isFilteringOrPaging: isFilteringOrPaging));

    // --- TEMPORARY MOCK DATA LOGIC (Simulates API call) ---
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Simulate filtering and pagination on the mock data
      final String jsonString =
          await rootBundle.loadString('assets/mock_data/mock_problems.json');
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      List<ProblemEntity> allProblems = jsonList
          .map((jsonItem) =>
              ProblemModel.fromJson(jsonItem as Map<String, dynamic>)
                  .toEntity())
          .toList();

      // Apply Filters (Basic Examples - Real filtering happens on backend)
      List<ProblemEntity> filteredProblems = allProblems.where((p) {
        bool platformMatch = filters.platforms == null ||
            filters.platforms!.isEmpty ||
            filters.platforms!.contains(p.platform);
        bool difficultyMatch = filters.difficulties == null ||
            filters.difficulties!.isEmpty ||
            filters.difficulties!.contains(p.difficultyLevel);
        bool tagsMatch = filters.tags == null ||
            filters.tags!.isEmpty ||
            filters.tags!.any((tag) => p.tags.contains(tag)); // Basic tag check
        bool solvedMatch =
            filters.isSolved == null || p.isSolved == filters.isSolved;
        return platformMatch && difficultyMatch && tagsMatch && solvedMatch;
      }).toList();

      // Apply Sorting (Basic Examples)
      if (filters.sortColumn != null && filters.sortDirection != null) {
        filteredProblems.sort((a, b) {
          int comparison = 0;
          switch (filters.sortColumn) {
            case 'name':
              comparison = a.name.compareTo(b.name);
              break;
            case 'platform':
              comparison = a.platform.compareTo(b.platform);
              break;
            case 'difficulty':
              comparison =
                  a.difficultyLevel.index.compareTo(b.difficultyLevel.index);
              break;
            case 'createdAt':
              comparison = a.createdAt.compareTo(b.createdAt);
              break;
            case 'isSolved':
              comparison = (a.isSolved ? 1 : 0).compareTo(b.isSolved ? 1 : 0);
              break;
            // Add more sortable columns
          }
          return filters.sortDirection == SortDirection.ascending
              ? comparison
              : -comparison;
        });
      }

      // Apply Pagination
      int totalFilteredCount = filteredProblems.length;
      int startIndex = (page - 1) * itemsPerPage;
      int endIndex = (startIndex + itemsPerPage > totalFilteredCount)
          ? totalFilteredCount
          : startIndex + itemsPerPage;

      // Ensure indices are valid
      startIndex = startIndex < 0 ? 0 : startIndex;
      endIndex = endIndex > totalFilteredCount ? totalFilteredCount : endIndex;

      List<ProblemEntity> paginatedProblems = (startIndex < endIndex)
          ? filteredProblems.sublist(startIndex, endIndex)
          : [];

      // Simulate successful result
      emit(ProblemsLoadSuccess(
        problems: paginatedProblems,
        totalProblemCount: totalFilteredCount, // Total matching filters
        currentPage: page,
        itemsPerPage: itemsPerPage,
        currentFilters: filters,
      ));
    } catch (e, stackTrace) {
      debugPrint("-----------------------------------------");
      debugPrint("Error MOCK fetching in Bloc: $e");
      debugPrint("Stack trace:\n$stackTrace");
      debugPrint("-----------------------------------------");
      // Simulate a specific failure type
      emit(ProblemsLoadFailure(ParsingFailure(details: e.toString())));
    }
    // --- END OF TEMPORARY MOCK LOGIC ---

    /* --- REPLACE WITH ACTUAL USE CASE CALL ---
     final result = await _getProblemsUseCase(GetProblemsParams(
        page: page,
        limit: itemsPerPage,
        platforms: filters.platforms,
        difficulties: filters.difficulties,
        tags: filters.tags,
        isSolved: filters.isSolved,
        sortColumn: filters.sortColumn,
        sortDirection: filters.sortDirection,
        // Add other filter params as needed
     ));

     result.fold(
        (failure) => emit(ProblemsLoadFailure(failure)),
        (queryResult) => emit(ProblemsLoadSuccess(
            problems: queryResult.problems,
            totalProblemCount: queryResult.totalCount,
            currentPage: page,
            itemsPerPage: itemsPerPage,
            currentFilters: filters,
        )),
     );
    --- END OF ACTUAL USE CASE CALL --- */
  }
}
