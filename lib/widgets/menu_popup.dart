import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:luc/services/auth_service.dart';
import 'package:luc/utils/app_theme.dart';

class MenuPopup extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onShowTutorial;

  const MenuPopup({
    super.key,
    required this.animationController,
    required this.onShowTutorial,
  });

  void _showLogoutDialog(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              authService.logout();
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(
                '/login',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fadeAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    final slideAnimation =
        Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero)
            .animate(fadeAnimation);

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Stack(
        children: [
          if (animationController.value > 0)
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 5 * fadeAnimation.value,
                    sigmaY: 5 * fadeAnimation.value),
                child: Container(
                    color: Colors.black.withOpacity(0.4 * fadeAnimation.value)),
              ),
            ),
          Positioned(
            top: 90,
            left: 16,
            child: SlideTransition(
              position: slideAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.opaque,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 280,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20)
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildUserInfoHeader(context),
                          _buildMenuOption(context,
                              icon: Icons.person_outline,
                              title: 'View Profile',
                              onTap: () =>
                                  Navigator.pushNamed(context, '/profile')),
                          _buildMenuOption(context,
                              icon: Icons.help_outline,
                              title: 'Replay Tutorial',
                              onTap: onShowTutorial),
                          _buildMenuOption(context,
                              icon: Icons.settings_outlined, title: 'Settings',
                              onTap: () {/* Navigate to Settings */}),
                          const Divider(height: 16),
                          _buildMenuOption(
                            context,
                            icon: Icons.logout,
                            title: 'Logout',
                            isDestructive: true,
                            popBeforeOnTap: false,
                            onTap: () => _showLogoutDialog(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoHeader(BuildContext context) {
    final user = Provider.of<AuthService>(context, listen: false).currentUser;
    if (user == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: user.profileImageProvider,
            backgroundColor: AppTheme.backgroundColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor)),
                Text(user.email,
                    style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.primaryColor.withOpacity(0.7)),
                    overflow: TextOverflow.ellipsis),
                Text('Role: ${user.role.name}',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.primaryColor.withOpacity(0.5))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap,
      bool isDestructive = false,
      bool popBeforeOnTap = true}) {
    final color = isDestructive ? AppTheme.errorColor : AppTheme.primaryColor;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title,
          style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      trailing: Icon(Icons.arrow_forward_ios_rounded,
          size: 16, color: color.withOpacity(0.7)),
      onTap: () {
        if (popBeforeOnTap) {
          Navigator.pop(context);
        }
        onTap();
      },
    );
  }
}
