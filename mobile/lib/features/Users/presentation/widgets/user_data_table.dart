import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Note: You need to add data_table_2 to your pubspec.yaml first
// data_table_2: ^2.5.10 (or latest version)
import 'package:data_table_2/data_table_2.dart';

// Convert to StatefulWidget for sorting functionality
class UserDataTable extends StatefulWidget {
  final List<Map<String, dynamic>> usersData;

  const UserDataTable({super.key, required this.usersData});

  @override
  State<UserDataTable> createState() => _UserDataTableState();
}

class _UserDataTableState extends State<UserDataTable> {
  // Sorting state
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  late List<Map<String, dynamic>> _sortedData;

  @override
  void initState() {
    super.initState();
    // Initialize sorted data
    _initSortedData();
  }

  @override
  void didUpdateWidget(UserDataTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.usersData != widget.usersData) {
      _initSortedData();
    }
  }

  void _initSortedData() {
    // Create expanded list of users by duplicating the first entry
    _sortedData = [];
    if (widget.usersData.isNotEmpty) {
      _sortedData.addAll(widget.usersData); // Add original data first

      // Add duplicates of the first entry to fill the table
      final firstUser = widget.usersData[0];
      // Add 20 more duplicates (adjust as needed)
      for (int i = 0; i < 20; i++) {
        // Create a copy with a slightly modified name to differentiate
        final Map<String, dynamic> duplicatedUser =
            Map<String, dynamic>.from(firstUser);
        duplicatedUser['name'] = '${firstUser['name']} (Copy ${i + 1})';
        _sortedData.add(duplicatedUser);
      }
    }
    // Apply initial sorting
    _sort(_sortColumnIndex, _sortAscending);
  }

  // Sort the data based on column index and order
  void _sort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      _sortedData.sort((a, b) {
        // Extract values for comparison based on column index
        dynamic aValue;
        dynamic bValue;

        switch (columnIndex) {
          case 0: // Name
            aValue = a['name'] ?? '';
            bValue = b['name'] ?? '';
            break;
          case 1: // Role
            aValue = (a['role'] as Map?)?['type'] ?? '';
            bValue = (b['role'] as Map?)?['type'] ?? '';
            break;
          case 2: // Group
            aValue = (a['group'] as Map?)?['short_name'] ?? '';
            bValue = (b['group'] as Map?)?['short_name'] ?? '';
            break;
          case 3: // Problems
            aValue = int.tryParse(
                    (a['meta'] as Map?)?['solvedProblems_count'] as String? ??
                        '0') ??
                0;
            bValue = int.tryParse(
                    (b['meta'] as Map?)?['solvedProblems_count'] as String? ??
                        '0') ??
                0;
            break;
          case 4: // Submissions
            aValue = int.tryParse(
                    (a['meta'] as Map?)?['submissions_count'] as String? ??
                        '0') ??
                0;
            bValue = int.tryParse(
                    (b['meta'] as Map?)?['submissions_count'] as String? ??
                        '0') ??
                0;
            break;
          case 5: // Time Spent
            aValue = int.tryParse(
                    (a['meta'] as Map?)?['time_spent'] as String? ?? '0') ??
                0;
            bValue = int.tryParse(
                    (b['meta'] as Map?)?['time_spent'] as String? ?? '0') ??
                0;
            break;
          case 6: // University
            aValue = a['university'] ?? '';
            bValue = b['university'] ?? '';
            break;
          case 7: // Country
            aValue = (a['country'] as Map?)?['name'] ?? '';
            bValue = (b['country'] as Map?)?['name'] ?? '';
            break;
          default:
            aValue = a['name'] ?? '';
            bValue = b['name'] ?? '';
        }

        // Apply sort direction
        int result;
        if (aValue is String && bValue is String) {
          result = aValue.compareTo(bValue);
        } else if (aValue is num && bValue is num) {
          result = aValue.compareTo(bValue);
        } else {
          // Handle different types or null values
          if (aValue == null) return ascending ? -1 : 1;
          if (bValue == null) return ascending ? 1 : -1;
          result = 0;
        }

        return ascending ? result : -result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: const Color.fromRGBO(145, 158, 171, 0.2),
            cardColor: Colors.white,
          ),
          child: DataTable2(
            columnSpacing: 24,
            horizontalMargin: 20,
            minWidth: 900,
            border: TableBorder(
              horizontalInside: BorderSide(
                color: const Color.fromRGBO(145, 158, 171, 0.2),
                width: 1,
              ),
            ),
            headingRowHeight: 56,
            dataRowHeight: 60,
            headingRowColor: MaterialStateProperty.all(Colors.white),
            dividerThickness: 0,
            showBottomBorder: false,
            // Enable sorting
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            sortArrowIcon: Icons.arrow_upward,
            sortArrowAnimationDuration: const Duration(milliseconds: 200),
            empty: Center(
              child: Text(
                'No data available',
                style: GoogleFonts.publicSans(
                  color: const Color.fromRGBO(99, 115, 129, 1),
                  fontSize: 16,
                ),
              ),
            ),
            columns: [
              DataColumn2(
                label: _buildColumnHeader('Name'),
                size: ColumnSize.L,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending),
              ),
              DataColumn2(
                label: _buildColumnHeader('Role'),
                size: ColumnSize.S,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending),
              ),
              DataColumn2(
                label: _buildColumnHeader('Group'),
                size: ColumnSize.M,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending),
              ),
              DataColumn2(
                label: _buildColumnHeader('Problems'),
                size: ColumnSize.S,
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending),
              ),
              DataColumn2(
                label: _buildColumnHeader('Submissions'),
                size: ColumnSize.S,
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending),
              ),
              DataColumn2(
                label: _buildColumnHeader('Time Spent'),
                size: ColumnSize.S,
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending),
              ),
              DataColumn2(
                label: _buildColumnHeader('University'),
                size: ColumnSize.L,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending),
              ),
              DataColumn2(
                label: _buildColumnHeader('Country'),
                size: ColumnSize.M,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending),
              ),
            ],
            rows: _sortedData.asMap().entries.map((entry) {
              final int index = entry.key;
              final userData = entry.value;

              // Extract data safely for the row
              final String name = userData['name'] ?? 'N/A';
              final String role =
                  (userData['role'] as Map?)?['type'] as String? ?? 'N/A';
              final String group =
                  (userData['group'] as Map?)?['short_name'] as String? ??
                      'N/A';
              final String problems = (userData['meta']
                      as Map?)?['solvedProblems_count'] as String? ??
                  '0';
              final String submissions =
                  (userData['meta'] as Map?)?['submissions_count'] as String? ??
                      '0';

              final dynamic timeSpentRaw =
                  (userData['meta'] as Map?)?['time_spent'];
              final String timeSpent = timeSpentRaw is String
                  ? (int.tryParse(timeSpentRaw) != null
                      ? "${(int.parse(timeSpentRaw) / 60).round()} hrs"
                      : 'N/A')
                  : 'N/A';

              final String university =
                  userData['university'] as String? ?? 'N/A';
              final String country =
                  (userData['country'] as Map?)?['name'] as String? ?? 'N/A';
              // Get photo URL for avatar
              final String photoUrl = userData['photo'] as String? ?? '';

              return DataRow2(
                color: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  // Apply alternating row colors
                  if (index % 2 == 0) return Colors.white;
                  return const Color.fromRGBO(
                      244, 246, 248, 1); // Light gray for odd rows
                }),
                cells: [
                  // Replace simple text with Row containing avatar and name
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Circular avatar
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: photoUrl.isNotEmpty
                              ? NetworkImage(photoUrl)
                              : null,
                          child: photoUrl.isEmpty
                              ? Text(
                                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                                  style: const TextStyle(color: Colors.grey),
                                )
                              : null,
                        ),
                        const SizedBox(
                            width: 12), // Spacing between avatar and name
                        Flexible(
                          child: _buildCellText(name, isBold: true),
                        ),
                      ],
                    ),
                  ),
                  DataCell(_buildCellText(role)),
                  DataCell(_buildCellText(group)),
                  DataCell(_buildCellText(problems, isNumeric: true)),
                  DataCell(_buildCellText(submissions, isNumeric: true)),
                  DataCell(_buildCellText(timeSpent)),
                  DataCell(_buildCellText(university)),
                  DataCell(_buildCellText(country)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildColumnHeader(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        style: GoogleFonts.publicSans(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: const Color.fromRGBO(99, 115, 129, 1),
        ),
      ),
    );
  }

  Widget _buildCellText(String text,
      {bool isNumeric = false, bool isBold = false}) {
    return Text(
      text,
      style: GoogleFonts.publicSans(
        fontSize: 14,
        fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        color: const Color.fromRGBO(33, 43, 54, 1),
      ),
      textAlign: isNumeric ? TextAlign.right : TextAlign.left,
      overflow: TextOverflow.ellipsis,
    );
  }
}
