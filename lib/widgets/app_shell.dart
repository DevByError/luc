import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:luc/models/user.dart';
import 'package:luc/services/auth_service.dart';
import 'package:luc/utils/app_theme.dart';
import 'package:luc/widgets/menu_popup.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  final int selectedIndex;

  const AppShell({
    super.key,
    required this.child,
    required this.selectedIndex,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with TickerProviderStateMixin {
  late int _currentIndex;
  late final AnimationController _menuAnimationController;
  late final AnimationController _navBarAnimationController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
    _menuAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _navBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _menuAnimationController.dispose();
    _navBarAnimationController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    if (_currentIndex == index) return; // Do nothing if it's the same tab

    setState(() {
      _currentIndex = index;
    });

    // Navigate based on index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/chat');
        break;
      case 2:
        Navigator.pushNamed(context, '/notifications');
        break;
      case 3:
        Navigator.pushNamed(context, '/classes');
        break;
    }
  }

  void _showMenuPopup() {
    _menuAnimationController.forward();
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (_) => MenuPopup(
        animationController: _menuAnimationController,
        onShowTutorial: () {/* Add tutorial logic later */},
      ),
    ).then((_) => _menuAnimationController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _buildAppBar(context, user),
      body: widget.child,
      bottomNavigationBar: _buildAnimatedBottomNav(),
      floatingActionButton: _currentIndex == 0 && user?.role == UserRole.student
          ? FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, '/chatbot'),
              backgroundColor: AppTheme.accentColor,
              child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            )
          : null,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, AppUser? user) {
    return AppBar(
      backgroundColor: AppTheme.primaryColor,
      elevation: 4,
      leading: IconButton(
        icon: const Icon(Icons.menu, size: 28),
        onPressed: _showMenuPopup,
      ),
      title: Image.asset('assets/images/luc_logo.png', height: 40),
      centerTitle: true,
      actions: [
        Tooltip(
          message: 'Show Tutorial',
          child: IconButton(
            icon: const Icon(Icons.help_outline_rounded, size: 26),
            onPressed: () {/* Add tutorial logic later */},
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/profile'),
          child: Container(
            margin: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.green, width: 2.0), // Default to green
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppTheme.backgroundColor,
              backgroundImage: user?.profileImageProvider,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedBottomNav() {
    final double itemWidth = MediaQuery.of(context).size.width / 4;

    return SafeArea(
      top: false,
      child: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              left: _currentIndex * itemWidth,
              top: 0,
              bottom: 0,
              child: Container(
                width: itemWidth,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // --- Pass both icon types to our updated method ---
                _buildNavItem(0, Icons.home, Icons.home_outlined, 'Home'),
                _buildNavItem(
                    1, Icons.chat_bubble, Icons.chat_bubble_outline, 'Chat'),
                _buildNavItem(
                    2, Icons.notifications, Icons.notifications_none, 'Alerts'),
                _buildNavItem(3, Icons.class_, Icons.class_outlined, 'Classes'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData selectedIcon, IconData unselectedIcon, String label) {
    final isSelected = _currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => _onNavItemTapped(index),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // This is the key change: we now use a different icon based on `isSelected`
            Icon(isSelected ? selectedIcon : unselectedIcon,
                color: Colors.white, size: isSelected ? 28 : 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(isSelected ? 1.0 : 0.7),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
