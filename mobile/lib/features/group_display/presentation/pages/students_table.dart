import 'package:flutter/material.dart';
import 'dart:math'; // Import for max function if needed for layout calculations

class Student {
  final int id;
  final String name;
  final String photo;
  final int groupId;
  final Map<String, dynamic> meta;
  final Map<String, dynamic> title;
  final Map<String, dynamic> lastSeen;

  Student({
    required this.id,
    required this.name,
    required this.photo,
    required this.groupId,
    required this.meta,
    required this.title,
    required this.lastSeen,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      groupId: json['group_id'],
      meta: json['meta'],
      title: json['title'],
      lastSeen: json['last_seen'],
    );
  }
}

class StudentDataTable extends StatefulWidget {
  final List<Student> students;

  const StudentDataTable({Key? key, required this.students}) : super(key: key);

  @override
  _StudentDataTableState createState() => _StudentDataTableState();
}

class _StudentDataTableState extends State<StudentDataTable>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isShowingStatistics = false;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  late List<Student> _sortedStudents;

  @override
  void initState() {
    super.initState();
    _sortedStudents = List.from(widget.students);
    _sortStudents(); // Initial sort
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        isShowingStatistics = _tabController.index == 1;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _sortStudents() {
    _sortedStudents.sort((a, b) {
      int result = 0;
      // Define comparison logic based on the sort column index
      switch (_sortColumnIndex) {
        case 0: // Name
          result = a.name.compareTo(b.name);
          break;
        case 1: // Problems
          // Assuming meta['solvedProblems_count'] is int or can be parsed
          final aValue =
              int.tryParse(a.meta['solvedProblems_count']?.toString() ?? '0') ??
                  0;
          final bValue =
              int.tryParse(b.meta['solvedProblems_count']?.toString() ?? '0') ??
                  0;
          result = aValue.compareTo(bValue);
          break;
        case 2: // Time Spent
          // Assuming meta['time_spent'] is int or can be parsed (e.g., total seconds)
          // TODO: Implement proper parsing/comparison for time spent format if it's not numeric
          final aValue =
              int.tryParse(a.meta['time_spent']?.toString() ?? '0') ?? 0;
          final bValue =
              int.tryParse(b.meta['time_spent']?.toString() ?? '0') ?? 0;
          result = aValue.compareTo(bValue);
          break;
        case 3: // Rating
          // Assuming meta['rating'] is num
          final aValue = a.meta['rating'] ?? 0;
          final bValue = b.meta['rating'] ?? 0;
          result = (aValue as num).compareTo(bValue as num);
          break;
        case 4: // Last Seen
          // TODO: Implement proper comparison logic for last seen dates/status
          // This is complex due to relative times and "online" status.
          // Placeholder: sort by raw map data for now, needs refinement.
          result = a.lastSeen.toString().compareTo(b.lastSeen.toString());
          break;
      }
      return _sortAscending ? result : -result;
    });
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _sortStudents();
    });
  }

  // Helper function to format last seen (Placeholder - needs actual implementation)
  String _formatLastSeen(Map<String, dynamic> lastSeenData) {
    // TODO: Implement actual logic based on the structure of lastSeenData
    // Example: Check for an 'online' flag or format a relative time string
    if (lastSeenData['status'] == 'online') {
      return 'online *';
    }
    // Placeholder for relative time format like "19d 16h 32m"
    return lastSeenData['relativeTime'] ?? 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    // Remove screen height calculation as Expanded will handle it
    // final screenHeight = MediaQuery.of(context).size.height;
    // final availableHeight = screenHeight - kToolbarHeight - kTextTabBarHeight - 100; // Adjust 100 based on other UI elements

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          // Restore mainAxisSize if needed, as we are not using Expanded for TabBarView parent
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tab Bar
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Students'),
                  Tab(text: 'Statistics'),
                ],
                labelColor: Colors.green,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.green,
                indicatorWeight: 3.0,
              ),
            ),

            // Tab Content - Revert to SizedBox with fixed height
            SizedBox(
              // Revert back to SizedBox
              height: MediaQuery.of(context).size.height *
                  0.8, // Use the fixed height again
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildStudentsTab(),
                  _buildStatisticsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentsTab() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        columnSpacing: 10.0,
        horizontalMargin: 10.0,
        headingRowHeight: 35,
        dataRowMinHeight: 50,
        dataRowMaxHeight: 60,
        columns: [
          DataColumn(
            label: const Text('Name',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            onSort: _onSort,
          ),
          DataColumn(
            label: const Text('Problems',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            numeric: true,
            onSort: _onSort,
          ),
          DataColumn(
            label: const Text('Time',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            numeric: true,
            onSort: _onSort,
          ),
          DataColumn(
            label: const Text('Rating',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            numeric: true,
            onSort: _onSort,
          ),
          DataColumn(
            label: const Text('Last Seen',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            onSort: _onSort,
          ),
        ],
        rows: _sortedStudents.map((student) {
          final lastSeenText = _formatLastSeen(student.lastSeen);
          final isOnline = lastSeenText.startsWith('online');
          final lastSeenColor = isOnline ? Colors.green : Colors.black;

          final problemsCount =
              student.meta['solvedProblems_count']?.toString() ?? '0';
          final timeSpent = student.meta['time_spent']?.toString() ?? '0';
          final rating = student.meta['rating']?.toString() ?? '0';

          // Abbreviate name
          String abbreviatedName = student.name.isNotEmpty
              ? (student.name.length > 10
                  ? "${student.name.substring(0, 5)}..."
                  : student.name)
              : "";

          return DataRow(
            cells: [
              // Restore Row structure for Name cell with abbreviation
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min, // Keep this
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(student.photo),
                      onBackgroundImageError: (exception, stackTrace) {
                        print('Error loading image: $exception');
                      },
                    ),
                    const SizedBox(width: 6),
                    Text(
                      abbreviatedName, // Use abbreviated name
                      // overflow: TextOverflow.ellipsis, // Ellipsis is now part of the string
                      softWrap: false,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              DataCell(
                  Text(problemsCount, style: const TextStyle(fontSize: 13))),
              DataCell(Text(timeSpent, style: const TextStyle(fontSize: 13))),
              DataCell(Text(rating, style: const TextStyle(fontSize: 13))),
              DataCell(
                Text(
                  lastSeenText,
                  style: TextStyle(
                      fontSize: 13,
                      color: lastSeenColor,
                      fontWeight:
                          isOnline ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatisticsTab() {
    // Placeholder for statistics tab
    return const Center(
      child: Text('Statistics would go here'),
    );
  }
}
