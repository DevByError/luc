import 'package:flutter/material.dart';
import 'package:luc/utils/app_theme.dart'; // <-- Correct theme import

class MyProgramPage extends StatelessWidget {
  const MyProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    // This is the main screen widget
    return const MyProgramScreen();
  }
}

class MyProgramScreen extends StatefulWidget {
  const MyProgramScreen({super.key});

  @override
  _MyProgramScreenState createState() => _MyProgramScreenState();
}

class _MyProgramScreenState extends State<MyProgramScreen> {
  // --- Data for Subjects by Semester ---
  // This data is hardcoded for now, but could come from your DataService later
  final List<Subject> _semester1Subjects = [
    Subject('Principles of Programming', 'BTTA 6013'),
    Subject('Discrete Mathematics and Probabilities', 'BTTA 6024'),
    Subject('English', 'BTTA 6033'),
    Subject('Computer Architecture and Organization', 'BTTA 6043'),
    Subject('Malay Language Communication 2', 'MPU 3143'),
  ];

  final List<Subject> _semester2Subjects = [
    Subject('Computer Networks', 'BTTA 6053'),
    Subject('Database Management Systems', 'BTTA 6063'),
    Subject('Applied Statistics', 'BTTA 6073'),
    Subject('Object Oriented Programming', 'BTTA 6083'),
  ];
  final List<Subject> _semester3Subjects = []; // Example of an empty semester

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor, // Use theme background color
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: AppTheme.primaryColor), // Use theme primary color
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor:
            AppTheme.cardColor, // Use theme card color for a distinct look
        elevation: 0,
        title: Column(
          children: const [
            Text(
              'My Program',
              style: TextStyle(
                color: AppTheme.primaryColor, // Use theme color
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Bachelor of Information Technology',
              style: TextStyle(
                color: AppTheme.primaryColor, // Use theme color
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              '(Hons.) Data Analytics',
              style: TextStyle(
                color: AppTheme.primaryColor, // Use theme color
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'School of AI Computing and Multimedia',
              style: TextStyle(
                color: AppTheme.secondaryText, // Use theme secondary text color
                fontSize: 11,
              ),
            ),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 120,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Program Info Row ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Duration: 3 years',
                  style: TextStyle(
                    color: AppTheme.primaryColor, // Use theme color
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Intakes: March, July, November',
                  style: TextStyle(
                    color: AppTheme.primaryColor, // Use theme color
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // --- Semester Cards ---
            _buildSemesterCard('1st Year', 'Semester 1', _semester1Subjects),
            const SizedBox(height: 20),
            _buildSemesterCard('1st Year', 'Semester 2', _semester2Subjects),
            const SizedBox(height: 20),
            _buildSemesterCard('1st Year', 'Semester 3', _semester3Subjects),
          ],
        ),
      ),
    );
  }

  /// Builds a styled card for a single semester.
  Widget _buildSemesterCard(
    String year,
    String semester,
    List<Subject> subjects,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.cardColor, // Use theme card color
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  year,
                  style: const TextStyle(
                    color: AppTheme.primaryColor, // Use theme color
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  semester,
                  style: const TextStyle(
                    color: AppTheme.primaryColor, // Use theme color
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (subjects.isNotEmpty)
            _buildSubjectTable(subjects)
          else
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Center(
                child: Text(
                  'No subjects listed for this semester.',
                  style: TextStyle(
                    color: AppTheme.secondaryText, // Use theme color
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          if (subjects.isNotEmpty) const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Builds the table view for the subjects.
  Widget _buildSubjectTable(List<Subject> subjects) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              _buildTableHeader('Subject Name', flex: 3),
              const SizedBox(width: 8),
              _buildTableHeader('Subject Code', flex: 2),
            ],
          ),
          const SizedBox(height: 8),
          ...subjects.map((subject) => _buildSubjectRow(subject)).toList(),
        ],
      ),
    );
  }

  /// Helper for building the table header.
  Widget _buildTableHeader(String title, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor, // Use theme color
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white, // Text on primary color should be white
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// Helper for building a subject row.
  Widget _buildSubjectRow(Subject subject) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _buildTableCell(subject.name, align: TextAlign.left),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: _buildTableCell(subject.code, align: TextAlign.center),
          ),
        ],
      ),
    );
  }

  /// Helper for building a table cell.
  Widget _buildTableCell(String text, {TextAlign align = TextAlign.left}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor, // Use theme background color
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: AppTheme.secondaryText, fontSize: 13), // Use theme color
        textAlign: align,
      ),
    );
  }
}

/// A simple data class to represent a single subject.
class Subject {
  final String name;
  final String code;

  const Subject(this.name, this.code);
}
