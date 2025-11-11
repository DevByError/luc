// lib/pages/student_pages/exam_result_page.dart

import 'package:flutter/material.dart';
import 'package:luc/utils/app_theme.dart'; // Your app's theme
import 'dart:math'; // Used for mock data generation

// ==========================================================
// === STYLING & UTILITIES (No changes here)               ===
// ==========================================================
class GradeColors {
  static const Color success = Color(0xFF10B981);
  static const Color accent = Color(0xFF3B82F6);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static List<Color> get successGradient =>
      [const Color(0xFF10B981), const Color(0xFF059669)];
  static List<Color> get accentGradient =>
      [const Color(0xFF3B82F6), const Color(0xFF2563EB)];
  static List<Color> get warningGradient =>
      [const Color(0xFFF59E0B), const Color(0xFFD97706)];
  static List<Color> get errorGradient =>
      [const Color(0xFFEF4444), const Color(0xFFDC2626)];
}

class ResponsiveUtil {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;
  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static EdgeInsets getResponsivePadding(BuildContext context) =>
      isMobile(context)
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 20)
          : const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
}

class AppShadows {
  static List<BoxShadow> get card => [
        BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12)),
        BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4)),
      ];
}

// ==========================================================
// === DATA MODELS & MOCK DATA (No changes here)           ===
// ==========================================================
class SubjectResult {
  final String subjectCode;
  final String subjectName;
  final int mark;
  final String grade;
  final int semester;
  SubjectResult(
      {required this.subjectCode,
      required this.subjectName,
      required this.mark,
      required this.grade,
      required this.semester});
  Color get gradeColor {
    switch (grade.toUpperCase()) {
      case 'A+':
      case 'A':
        return GradeColors.success;
      case 'B+':
      case 'B':
        return GradeColors.accent;
      case 'C+':
      case 'C':
        return GradeColors.warning;
      default:
        return GradeColors.error;
    }
  }

  List<Color> get gradeGradient {
    switch (grade.toUpperCase()) {
      case 'A+':
      case 'A':
        return GradeColors.successGradient;
      case 'B+':
      case 'B':
        return GradeColors.accentGradient;
      case 'C+':
      case 'C':
        return GradeColors.warningGradient;
      default:
        return GradeColors.errorGradient;
    }
  }
}

class SemesterResult {
  final int semesterNumber;
  final List<SubjectResult> subjects;
  SemesterResult({required this.semesterNumber, required this.subjects});
}

class ExamResult {
  final double gpa;
  final List<SemesterResult> semesters;
  final DateTime lastUpdated;
  ExamResult(
      {required this.gpa, required this.semesters, required this.lastUpdated});
}

final mockExamResult = ExamResult(
  gpa: 3.8,
  lastUpdated: DateTime.now().subtract(const Duration(hours: 3)),
  semesters: [
    SemesterResult(
      semesterNumber: 1,
      subjects: [
        SubjectResult(
            subjectCode: 'BTTA 6013',
            subjectName: 'Principles of Programming',
            mark: 92,
            grade: 'A+',
            semester: 1),
        SubjectResult(
            subjectCode: 'BTTA 6024',
            subjectName: 'Discrete Mathematics',
            mark: 85,
            grade: 'A',
            semester: 1),
        SubjectResult(
            subjectCode: 'BTTA 6043',
            subjectName: 'Computer Architecture',
            mark: 78,
            grade: 'B+',
            semester: 1),
      ],
    ),
    SemesterResult(
      semesterNumber: 2,
      subjects: [
        SubjectResult(
            subjectCode: 'BTTA 6053',
            subjectName: 'Computer Networks',
            mark: 88,
            grade: 'A',
            semester: 2),
        SubjectResult(
            subjectCode: 'BTTA 6063',
            subjectName: 'Database Management Systems',
            mark: 95,
            grade: 'A+',
            semester: 2),
        SubjectResult(
            subjectCode: 'BTTA 6083',
            subjectName: 'Object Oriented Programming',
            mark: 81,
            grade: 'A-',
            semester: 2),
        SubjectResult(
            subjectCode: 'MPU 3143',
            subjectName: 'Malay Language Communication 2',
            mark: 74,
            grade: 'B',
            semester: 2),
      ],
    ),
  ],
);

// ==========================================================
// === MAIN PAGE WIDGET (REBUILT WITH SIMPLER LAYOUT)      ===
// ==========================================================

class ExamResultPage extends StatelessWidget {
  const ExamResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    // We use a Scaffold with a standard AppBar and a SingleChildScrollView.
    // This is much more stable than CustomScrollView for this type of layout.
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _buildModernAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _ModernResultsView(examResult: mockExamResult),
        ),
      ),
    );
  }

  // The AppBar is now a standard PreferredSizeWidget, not a SliverAppBar.
  PreferredSizeWidget _buildModernAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.primaryColor, AppTheme.accentColor],
          ),
        ),
      ),
      title: const Text('Exam Results',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {/* Refresh logic will go here */},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.refresh_rounded, color: Colors.white, size: 24),
            ),
          ),
        ),
      ],
    );
  }
}

// ==========================================================
// === UI COMPONENTS (NO CHANGES BELOW THIS LINE)          ===
// ==========================================================
// All the child widgets remain the same as they were not the cause of the problem.

class _ModernResultsView extends StatelessWidget {
  final ExamResult examResult;
  const _ModernResultsView({required this.examResult});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsiveUtil.getResponsivePadding(context),
      child: Column(
        children: [
          _ModernGpaHeader(
              gpa: examResult.gpa, lastUpdated: examResult.lastUpdated),
          const SizedBox(height: 24),
          _ModernSubjectsSection(semesters: examResult.semesters),
        ],
      ),
    );
  }
}

class _ModernGpaHeader extends StatelessWidget {
  final double gpa;
  final DateTime lastUpdated;

  const _ModernGpaHeader({required this.gpa, required this.lastUpdated});

  @override
  Widget build(BuildContext context) {
    final normalizedGpa = (gpa / 4.0).clamp(0.0, 1.0);
    final isMobile = ResponsiveUtil.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: AppShadows.card,
        border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
      ),
      padding: EdgeInsets.all(isMobile ? 24 : 32),
      child: Column(
        children: [
          Row(
            children: [
              _buildModernGpaCircle(context, normalizedGpa),
              SizedBox(width: isMobile ? 24 : 32),
              Expanded(child: _buildGpaInfo(context)),
            ],
          ),
          const SizedBox(height: 24),
          _buildPerformanceMetrics(context),
          const SizedBox(height: 16),
          _buildLastUpdatedInfo(context),
        ],
      ),
    );
  }

  Color _getGpaColor(double gpa) {
    if (gpa >= 3.5) return GradeColors.success;
    if (gpa >= 3.0) return GradeColors.accent;
    if (gpa >= 2.5) return GradeColors.warning;
    return GradeColors.error;
  }

  String _getGpaDescription(double gpa) {
    if (gpa >= 3.8) return 'Outstanding';
    if (gpa >= 3.5) return 'Excellent';
    if (gpa >= 3.0) return 'Good';
    if (gpa >= 2.5) return 'Satisfactory';
    return 'Needs Improvement';
  }

  IconData _getGpaIcon(double gpa) {
    if (gpa >= 3.5) return Icons.emoji_events_rounded;
    if (gpa >= 3.0) return Icons.star_rounded;
    if (gpa >= 2.5) return Icons.trending_up_rounded;
    return Icons.trending_down_rounded;
  }

  String _getGpaPercentage(double gpa) => '${((gpa / 4.0) * 100).toInt()}%';

  Widget _buildModernGpaCircle(BuildContext context, double normalizedGpa) {
    final size = ResponsiveUtil.isMobile(context) ? 120.0 : 140.0;
    final gpaColor = _getGpaColor(gpa);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: gpaColor.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
              color: gpaColor.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size - 20,
            height: size - 20,
            child: CircularProgressIndicator(
              value: normalizedGpa,
              strokeWidth: 8,
              backgroundColor: Colors.grey.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(gpaColor),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(gpa.toStringAsFixed(1),
                  style: TextStyle(
                      fontSize: size > 120 ? 36 : 32,
                      fontWeight: FontWeight.w800,
                      color: gpaColor,
                      letterSpacing: -1)),
              Text('/ 4.0',
                  style: TextStyle(
                      fontSize: size > 120 ? 16 : 14,
                      color: AppTheme.secondaryText,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGpaInfo(BuildContext context) {
    final gpaColor = _getGpaColor(gpa);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: gpaColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: gpaColor.withOpacity(0.2), width: 1),
          ),
          child: Text('Overall GPA',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: gpaColor)),
        ),
        const SizedBox(height: 16),
        Text(_getGpaDescription(gpa),
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppTheme.primaryText,
                letterSpacing: -0.5)),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: gpaColor, borderRadius: BorderRadius.circular(12)),
              child: Icon(_getGpaIcon(gpa), size: 20, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(_getGpaPercentage(gpa),
                style: const TextStyle(
                    fontSize: 16,
                    color: AppTheme.secondaryText,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformanceMetrics(BuildContext context) {
    final gpaColor = _getGpaColor(gpa);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: gpaColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gpaColor.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
              child: _buildMetricItem(context, 'Performance',
                  _getGpaDescription(gpa), _getGpaIcon(gpa))),
          Container(
              width: 1,
              height: 40,
              color: AppTheme.secondaryText.withOpacity(0.2)),
          Expanded(
              child: _buildMetricItem(context, 'Score', _getGpaPercentage(gpa),
                  Icons.trending_up_rounded)),
        ],
      ),
    );
  }

  Widget _buildLastUpdatedInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: GradeColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: GradeColors.accent.withOpacity(0.2), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: GradeColors.accent,
                borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.schedule_rounded,
                size: 16, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Last Updated',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.secondaryText,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(
                  // Using a simple format for UI display
                  '${lastUpdated.day}/${lastUpdated.month}/${lastUpdated.year} • ${lastUpdated.hour}:${lastUpdated.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                      fontSize: 13,
                      color: GradeColors.accent,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(
      BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: _getGpaColor(gpa)),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryText,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryText)),
      ],
    );
  }
}

class _ModernSubjectsSection extends StatefulWidget {
  final List<SemesterResult> semesters;
  const _ModernSubjectsSection({required this.semesters});

  @override
  State<_ModernSubjectsSection> createState() => _ModernSubjectsSectionState();
}

class _ModernSubjectsSectionState extends State<_ModernSubjectsSection> {
  PageController? _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pageController ??= PageController(
      viewportFraction: ResponsiveUtil.isMobile(context) ? 0.85 : 0.75,
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.semesters.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context),
        const SizedBox(height: 16),
        SizedBox(
          height: 450,
          child: PageView.builder(
            controller: _pageController!,
            onPageChanged: (page) => setState(() => _currentPage = page),
            itemCount: widget.semesters.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _ModernSemesterCard(semester: widget.semesters[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        _buildPageIndicators(context),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.card,
        border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6))
              ],
            ),
            child:
                const Icon(Icons.school_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Semester Results',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primaryText,
                        letterSpacing: -0.5)),
                SizedBox(height: 6),
                Text('Swipe to explore different semesters',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondaryText,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicators(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.semesters.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: 8,
          width: _currentPage == index ? 32 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? AppTheme.primaryColor
                : AppTheme.secondaryText.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class _ModernSemesterCard extends StatelessWidget {
  final SemesterResult semester;
  const _ModernSemesterCard({required this.semester});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: AppShadows.card,
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        children: [
          _buildSemesterHeader(context),
          Expanded(child: _buildSubjectsList(context)),
        ],
      ),
    );
  }

  Widget _buildSemesterHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border:
                  Border.all(color: Colors.white.withOpacity(0.3), width: 1),
            ),
            child: const Icon(Icons.calendar_today_rounded,
                color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Semester ${semester.semesterNumber}',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5)),
                const SizedBox(height: 6),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.2), width: 1),
                    ),
                    child: Text('${semester.subjects.length} Subjects',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9)))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: semester.subjects.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) =>
            _ModernSubjectCard(subject: semester.subjects[index]),
      ),
    );
  }
}

class _ModernSubjectCard extends StatelessWidget {
  final SubjectResult subject;
  const _ModernSubjectCard({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subject.subjectName,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryText,
                            height: 1.3),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryText.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(subject.subjectCode,
                          style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.secondaryText,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: subject.gradeGradient),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: subject.gradeColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Text(subject.grade,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ModernScoreIndicator(
            label: 'Score',
            value: '${subject.mark}%',
            progress: subject.mark / 100.0,
            color: subject.gradeColor,
          ),
        ],
      ),
    );
  }
}

class _ModernScoreIndicator extends StatelessWidget {
  final String label;
  final String value;
  final double progress;
  final Color color;

  const _ModernScoreIndicator({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondaryText,
                    fontWeight: FontWeight.w600)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withOpacity(0.3), width: 1),
              ),
              child: Text(value,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700, color: color)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 8,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ),
      ],
    );
  }
}
