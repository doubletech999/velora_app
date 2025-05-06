import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/navigation/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        actions: [
          IconButton(
            icon: const Icon(PhosphorIcons.gear),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const Icon(
                      PhosphorIcons.user,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'ماجد ولدعلي',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'majedweldali1@gmail.com',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            // Stats
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatItem(
                    icon: PhosphorIcons.flag_checkered,
                    value: '12',
                    label: 'رحلات مكتملة',
                  ),
                  _StatItem(
                    icon: PhosphorIcons.bookmark,
                    value: '8',
                    label: 'رحلات محفوظة',
                  ),
                  _StatItem(
                    icon: PhosphorIcons.trophy,
                    value: '5',
                    label: 'إنجازات',
                  ),
                ],
              ),
            ),
            
            const Divider(),
            
            // Menu items
            _MenuItem(
              icon: PhosphorIcons.path,
              title: 'رحلاتي',
              onTap: () {},
            ),
            _MenuItem(
              icon: PhosphorIcons.bookmark_simple,
              title: 'المحفوظات',
              onTap: () {},
            ),
            _MenuItem(
              icon: PhosphorIcons.trophy,
              title: 'الإنجازات',
              onTap: () {},
            ),
            _MenuItem(
              icon: PhosphorIcons.heart,
              title: 'المفضلة',
              onTap: () {},
            ),
            _MenuItem(
              icon: PhosphorIcons.translate,
              title: 'اللغة',
              trailing: 'العربية',
              onTap: () {},
            ),
            _MenuItem(
              icon: PhosphorIcons.question,
              title: 'المساعدة والدعم',
              onTap: () {},
            ),
            _MenuItem(
              icon: PhosphorIcons.info,
              title: 'عن التطبيق',
              onTap: () {},
            ),
             _MenuItem(
              icon: PhosphorIcons.sign_out,
              title: 'تسجيل الخروج',
              onTap: () {
                // TODO: Implement logout
              },
              textColor: AppColors.error,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;
  final Color? textColor;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? AppColors.textPrimary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? AppColors.textPrimary,
        ),
      ),
      trailing: trailing != null
          ? Text(
              trailing!,
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            )
          : const Icon(
              PhosphorIcons.caret_right,
              color: AppColors.textSecondary,
            ),
      onTap: onTap,
    );
  }
}