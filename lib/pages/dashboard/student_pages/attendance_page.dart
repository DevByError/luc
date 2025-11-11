// lib/pages/student_pages/attendance_page.dart

import 'package:flutter/material.dart';
import 'package:luc/utils/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

// --- DATA MODELS & MOCK DATA ---

class Course {
  final String code;
  final String name;
  final IconData icon;
  final Color color;
  const Course(
      {required this.code,
      required this.name,
      required this.icon,
      required this.color});
}

class AttendanceRecord {
  final String courseCode;
  final DateTime date;
  final bool isPresent;
  const AttendanceRecord(
      {required this.courseCode, required this.date, required this.isPresent});
}

// Mock Data
const List<Course> mockCourses = [
  Course(
      code: 'CS404',
      name: 'Advanced Algorithms',
      icon: Icons.hub,
      color: Colors.blue),
  Course(
      code: 'EE301',
      name: 'Signal Processing',
      icon: Icons.waves,
      color: Colors.purple),
  Course(
      code: 'ME210',
      name: 'Thermodynamics',
      icon: Icons.local_fire_department,
      color: Colors.orange),
  Course(
      code: 'BIO181',
      name: 'General Biology',
      icon: Icons.biotech,
      color: Colors.green),
];

List<AttendanceRecord> getMockRecordsForCourse(String courseCode) {
  final random = Random(courseCode.hashCode);
  return List.generate(15, (index) {
    return AttendanceRecord(
      courseCode: courseCode,
      date: DateTime.now().subtract(Duration(days: index * 2)),
      isPresent: random.nextDouble() > 0.2, // ~80% attendance
    );
  });
}

// --- MAIN COURSES LIST PAGE ---
class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data is now static mock data, no FutureBuilder needed.
    final courses = mockCourses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses Attendance'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return _buildCourseCard(context, courses[index]);
        },
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseDetailPage(course: course)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: course.color.withOpacity(0.15),
                child: Icon(course.icon, color: course.color, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.primaryText),
                    ),
                    const SizedBox(height: 4),
                    Text(course.code,
                        style: const TextStyle(
                            fontSize: 14, color: AppTheme.secondaryText)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// --- COURSE DETAIL PAGE ---
class CourseDetailPage extends StatelessWidget {
  final Course course;
  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    // Get static mock records for this course.
    final records = getMockRecordsForCourse(course.code);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        children: [
          _buildStatsHeader(context, records),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Attendance History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          ...records.map((record) => _buildHistoryTile(record)),
        ],
      ),
    );
  }

  Widget _buildStatsHeader(
      BuildContext context, List<AttendanceRecord> records) {
    final present = records.where((r) => r.isPresent).length;
    final absent = records.length - present;
    final percentage = (present / records.length * 100).toStringAsFixed(1);

    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: course.color.withOpacity(0.15),
                    child: Icon(course.icon, color: course.color, size: 30),
                  ),
                  const SizedBox(height: 16),
                  Text('Present: $present days',
                      style: const TextStyle(
                          fontSize: 16, color: AppTheme.secondaryText)),
                  const SizedBox(height: 6),
                  Text('Absent: $absent days',
                      style: const TextStyle(
                          fontSize: 16, color: AppTheme.secondaryText)),
                  const SizedBox(height: 10),
                  Text(
                    'Attendance: $percentage%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppTheme.primaryText,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 100,
                width: 100,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 3,
                    centerSpaceRadius: 25,
                    startDegreeOffset: -90,
                    pieTouchData: PieTouchData(enabled: false),
                    sections: [
                      PieChartSectionData(
                        value: present.toDouble(),
                        color: Colors.green.shade600,
                        radius: 22,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: absent.toDouble(),
                        color: Colors.red.shade400,
                        radius: 22,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTile(AttendanceRecord record) {
    final isPresent = record.isPresent;
    final statusColor = isPresent ? Colors.green.shade700 : AppTheme.errorColor;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(
          isPresent ? Icons.check_circle_outline : Icons.highlight_off,
          color: statusColor,
        ),
        title: Text(
          DateFormat('EEEE, MMM dd, yyyy').format(record.date),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Text(
          isPresent ? 'PRESENT' : 'ABSENT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: statusColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
