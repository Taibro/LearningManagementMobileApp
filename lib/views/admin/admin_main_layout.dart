import 'package:flutter/material.dart';
import 'admin_home_screen.dart';
import 'admin_schedule_screen.dart';
import 'admin_users_screen.dart';
import 'admin_reports_screen.dart';
import 'admin_settings_screen.dart';

/// Thêm vào main.dart:
///   import 'views/admin/admin_main_layout.dart';
///   home: const AdminMainLayout()
class AdminMainLayout extends StatefulWidget {
  const AdminMainLayout({super.key});

  @override
  State<AdminMainLayout> createState() => _AdminMainLayoutState();
}

class _AdminMainLayoutState extends State<AdminMainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const AdminHomeScreen(),
    const AdminScheduleScreen(),
    const AdminUsersScreen(),
    const AdminReportsScreen(),
    const AdminSettingsScreen(),
  ];

  static const _kPrimary = Color(0xFF1A237E);
  static const _kGrey    = Color(0xFF9E9E9E);

  final _navItems = const [
    {'icon': Icons.dashboard_rounded,        'label': 'Dashboard'},
    {'icon': Icons.calendar_month_rounded,   'label': 'Lịch học'},
    {'icon': Icons.manage_accounts_rounded,  'label': 'Quản lý'},
    {'icon': Icons.bar_chart_rounded,        'label': 'Báo cáo'},
    {'icon': Icons.settings_rounded,         'label': 'Cài đặt'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: _buildNav(),
    );
  }

  Widget _buildNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 14,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_navItems.length, (i) {
              final sel = _selectedIndex == i;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: sel ? _kPrimary.withOpacity(0.10) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _navItems[i]['icon'] as IconData,
                        color: sel ? _kPrimary : _kGrey,
                        size: 24,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _navItems[i]['label'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: sel ? FontWeight.w700 : FontWeight.normal,
                          color: sel ? _kPrimary : _kGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}