import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceHeatmap extends StatelessWidget {
  final List<AttendanceRecord> attendanceRecords;
  final String title;
  final bool showDetail;
  final Function(bool)? onToggleDetail;

  const AttendanceHeatmap({
    Key? key,
    required this.attendanceRecords,
    this.title = 'Attendance',
    this.showDetail = false,
    this.onToggleDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate statistics
    int present = 0;
    int absent = 0;
    int excused = 0;

    for (var record in attendanceRecords) {
      if (record.status == AttendanceStatus.present) {
        present++;
      } else if (record.status == AttendanceStatus.absent) {
        absent++;
      } else if (record.status == AttendanceStatus.excused) {
        excused++;
      }
    }

    double attendanceRate = attendanceRecords.isEmpty
        ? 0
        : (present / attendanceRecords.length) * 100;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.publicSans(
                    textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                )),
              ),
              GestureDetector(
                onTap: () {
                  if (onToggleDetail != null) {
                    onToggleDetail!(!showDetail);
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      showDetail
                          ? FontAwesomeIcons.toggleOn
                          : FontAwesomeIcons.toggleOff,
                      size: 30,
                      color: showDetail
                          ? Color.fromRGBO(84, 214, 44, 1)
                          : Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Show detail',
                      style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Attendance grid
          SizedBox(
            height: 200,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: showDetail ? 10 : 23, // 15 cells per row
                  crossAxisSpacing: showDetail ? 6 : 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: showDetail ? 0.8 : 1.0,
                  mainAxisExtent: showDetail ? 30 : 16),
              itemCount: attendanceRecords.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: _getStatusColor(attendanceRecords[index].status),
                    borderRadius: BorderRadius.circular(0),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Summary statistics
          Row(
            children: [
              // Absent count
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Absent: ',
                      style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black87,
                      )),
                    ),
                    TextSpan(
                      text: '$absent',
                      style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Excused count
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Excused: ',
                      style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black87,
                      )),
                    ),
                    TextSpan(
                      text: '$excused',
                      style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Present count and percentage
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Present: ',
                      style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black87,
                      )),
                    ),
                    TextSpan(
                      text: '$present',
                      style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )),
                    ),
                    TextSpan(
                      text: ' | ${attendanceRate.toStringAsFixed(0)}%',
                      style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return Color.fromRGBO(84, 214, 44, 1); // Green
      case AttendanceStatus.excused:
        return Color.fromRGBO(255, 193, 7, 1); // Orange
      case AttendanceStatus.absent:
        return Color.fromRGBO(255, 72, 66, 1); // Red
      default:
        return Colors.grey.shade300;
    }
  }
}

// Enum for attendance status
enum AttendanceStatus {
  present,
  absent,
  excused,
}

// Class to represent an attendance record
class AttendanceRecord {
  final DateTime date;
  final AttendanceStatus status;

  AttendanceRecord({
    required this.date,
    required this.status,
  });
}

// Generate sample data to match the image
List<AttendanceRecord> generateSampleData() {
  final List<AttendanceRecord> records = [];
  final DateTime now = DateTime.now();

  // Create 300 attendance records (similar to the image)
  for (int i = 0; i < 300; i++) {
    AttendanceStatus status;

    // Replicate the pattern in the image
    if (i % 75 == 13 || i % 75 == 32 || i % 60 == 47) {
      status = AttendanceStatus.excused;
    } else if (i >= 260 && i <= 268 || i >= 20 && i <= 28) {
      status = AttendanceStatus.absent;
    } else {
      status = AttendanceStatus.present;
    }

    records.add(AttendanceRecord(
      date: now.subtract(Duration(days: 300 - i)),
      status: status,
    ));
  }

  return records;
}

// // Example usage
// class AttendanceHeatmapDemo extends StatefulWidget {
//   const AttendanceHeatmapDemo({Key? key}) : super(key: key);

//   @override
//   State<AttendanceHeatmapDemo> createState() => _AttendanceHeatmapDemoState();
// }

// class _AttendanceHeatmapDemoState extends State<AttendanceHeatmapDemo> {
//   bool _showDetail = false;
  
//   // Generate sample data to match the image
//   List<AttendanceRecord> _generateSampleData() {
//     final List<AttendanceRecord> records = [];
//     final DateTime now = DateTime.now();
    
//     // Create 300 attendance records (similar to the image)
//     for (int i = 0; i < 300; i++) {
//       AttendanceStatus status;
      
//       // Replicate the pattern in the image
//       if (i % 75 == 13 || i % 75 == 32 || i % 60 == 47) {
//         status = AttendanceStatus.excused;
//       } else if (i >= 260 && i <= 268 || i >= 20 && i <= 28) {
//         status = AttendanceStatus.absent;
//       } else {
//         status = AttendanceStatus.present;
//       }
      
//       records.add(AttendanceRecord(
//         date: now.subtract(Duration(days: 300 - i)),
//         status: status,
//       ));
//     }
    
//     return records;
//   };