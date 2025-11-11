// lib/pages/student_pages/exam_slip_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luc/utils/app_theme.dart';
import 'dart:async';

// --- MOCK DATA ---
final mockStudentData = {
  'name': 'John Doe',
  'studentId': 'LUC123456',
  'course': 'B.Sc. (Hons) in Computer Science',
  'intake': 'September 2023',
};

final mockExamSlipData = {
  'name': 'Final Examination Semester 1',
  'subjects': [
    {
      'subjectName': 'Introduction to Programming',
      'subjectCode': 'CS101',
      'date': DateTime.now().add(const Duration(days: 5, hours: 2)),
      'venue': 'Main Hall A',
      'spot': 'A-32',
      'entranceCode': '1111',
      'exitCode': '2222',
    },
    {
      'subjectName': 'Calculus I',
      'subjectCode': 'MA101',
      'date': DateTime.now().add(const Duration(days: 6, hours: 5)),
      'venue': 'Main Hall B',
      'spot': 'B-15',
      'entranceCode': '3333',
      'exitCode': '4444',
    },
    {
      'subjectName': 'Academic English',
      'subjectCode': 'EN101',
      'date': DateTime.now().add(const Duration(days: 7, hours: 3)),
      'venue': 'Lecture Hall 3',
      'spot': 'C-05',
      'entranceCode': '5555',
      'exitCode': '6666',
    },
  ]
};

// --- MAIN WIDGET ---

class ExamSlipPage extends StatelessWidget {
  const ExamSlipPage({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app, this data would come from a FutureBuilder or Provider
    final studentData = mockStudentData;
    final slipData = mockExamSlipData;
    final List<dynamic> subjects = slipData['subjects'] as List<dynamic>;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Exam Admission Slip'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
          children: [
            _buildHeader(slipData),
            const SizedBox(height: 24),
            _buildStudentInfoCard(studentData),
            const SizedBox(height: 24),
            _buildSubjectsSection(subjects),
            const SizedBox(height: 24),
            _buildInstructionsCard(),
          ],
        ),
      ),
    );
  }

  // UI Helper Widgets
  Widget _buildHeader(Map<String, dynamic> slipData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          slipData['name'] as String,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const Text(
          'ADMISSION SLIP',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.secondaryText,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStudentInfoCard(Map<String, dynamic> studentData) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoRow(
              Icons.person_outline,
              "Student Name",
              studentData['name']!,
            ),
            _buildInfoRow(
              Icons.badge_outlined,
              "Student ID",
              studentData['studentId']!,
            ),
            _buildInfoRow(
              Icons.school_outlined,
              "Program",
              studentData['course']!,
            ),
            _buildInfoRow(
              Icons.class_outlined,
              "Intake",
              studentData['intake']!,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value,
      {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(color: AppTheme.secondaryText)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectsSection(List<dynamic> subjects) {
    return ListView.separated(
      itemCount: subjects.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final subjectMap = subjects[index] as Map<String, dynamic>;
        return _SubjectInfoCard(
            subjectData: subjectMap, studentData: mockStudentData);
      },
    );
  }

  Widget _buildInstructionsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.blue.shade50,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  "Important Instructions",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Divider(height: 20),
            Text(
              "1. You must bring a valid Student ID Card for verification.\n"
              "2. Electronic devices (phones, smart watches) are strictly prohibited.\n"
              "3. Arrive at the examination venue at least 15 minutes before the scheduled start time.",
              style: TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// --- SUBJECT CARD WIDGET ---
enum ExamStatus { notEntered, entered, exited }

class _SubjectInfoCard extends StatefulWidget {
  final Map<String, dynamic> subjectData;
  final Map<String, dynamic> studentData;

  const _SubjectInfoCard(
      {required this.subjectData, required this.studentData});

  @override
  State<_SubjectInfoCard> createState() => _SubjectInfoCardState();
}

class _SubjectInfoCardState extends State<_SubjectInfoCard> {
  final _codeController = TextEditingController();
  ExamStatus _status = ExamStatus.notEntered;
  bool _isButtonLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _handleEntry() async {
    final success = await _showCodeDialog(
      title: "Enter Exam Hall Code",
      correctCode: widget.subjectData['entranceCode'] as String,
    );
    if (success) {
      setState(() => _status = ExamStatus.entered);
      _showReceiptDialog();
    }
  }

  Future<void> _handleExit() async {
    final success = await _showCodeDialog(
      title: "Enter Exit Code",
      correctCode: widget.subjectData['exitCode'] as String,
    );
    if (success) setState(() => _status = ExamStatus.exited);
  }

  Future<bool> _showCodeDialog(
      {required String title, required String correctCode}) async {
    final completer = Completer<bool>();
    _codeController.clear();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: _codeController,
            autofocus: true,
            decoration:
                const InputDecoration(hintText: "Ask admin for the code"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                if (!completer.isCompleted) completer.complete(false);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                if (correctCode == _codeController.text.trim()) {
                  if (!completer.isCompleted) completer.complete(true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Incorrect code."),
                      backgroundColor: Colors.red));
                  if (!completer.isCompleted) completer.complete(false);
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
    return completer.future;
  }

  void _showReceiptDialog() {
    final dateTime = widget.subjectData['date'] as DateTime;
    final formattedDate = DateFormat.yMMMEd().format(dateTime);
    final formattedTime = DateFormat.jm().format(dateTime);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Center(child: Text("Exam Admission Details")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child:
                      Icon(Icons.check_circle, color: Colors.green, size: 40)),
              const SizedBox(height: 10),
              const Center(
                  child: Text("VERIFIED",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold))),
              const Divider(height: 20),
              _buildReceiptRow("Subject:", widget.subjectData['subjectName']),
              _buildReceiptRow("Program:", widget.studentData['course']),
              _buildReceiptRow("Student ID:", widget.studentData['studentId']),
              const Divider(height: 20),
              _buildReceiptRow("Date:", formattedDate),
              _buildReceiptRow("Time:", formattedTime),
              _buildReceiptRow("Venue:", widget.subjectData['venue']),
              _buildReceiptRow("Spot/Seat:", widget.subjectData['spot'],
                  isLast: true),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Close"))
          ],
        );
      },
    );
  }

  Widget _buildReceiptRow(String title, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey.shade600)),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = widget.subjectData['date'] as DateTime;
    final formattedDate = DateFormat.yMMMEd().format(dateTime);
    final formattedTime = DateFormat.jm().format(dateTime);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.subjectData['subjectName'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            Text(widget.subjectData['subjectCode'],
                style: const TextStyle(
                    color: AppTheme.secondaryText, fontSize: 14)),
            const Divider(height: 24),
            _buildDetailRow(Icons.calendar_today_outlined, formattedDate),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.access_time_outlined, formattedTime),
            const Divider(height: 24),
            Center(child: _buildActionButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    if (_isButtonLoading) {
      return const CircularProgressIndicator(color: AppTheme.primaryColor);
    }
    switch (_status) {
      case ExamStatus.notEntered:
        return ElevatedButton.icon(
          icon: const Icon(Icons.login),
          label: const Text("Enter Exam Hall"),
          onPressed: _handleEntry,
        );
      case ExamStatus.entered:
        return Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Exit Exam Hall"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade800),
              onPressed: _handleExit,
            ),
            TextButton(
                onPressed: _showReceiptDialog,
                child: const Text("View Admission Slip")),
          ],
        );
      case ExamStatus.exited:
        return Chip(
          avatar: const Icon(Icons.check_circle, color: Colors.white),
          label: const Text("Exited (Duration: 2h 15m)"),
          backgroundColor: Colors.green.shade700,
          labelStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        );
    }
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 18),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
      ],
    );
  }
}
