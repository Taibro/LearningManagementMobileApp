import 'package:flutter/material.dart';
import 'lecturer_home_screen.dart';
import 'lecturer_schedule_screen.dart';
import 'lecturer_attendance_screen.dart';
import 'lecturer_profile_screen.dart';

/// Để dùng: thay `home: const MainLayout()` trong main.dart thành
/// `home: const LecturerMainLayout()` và import file này.
class LecturerMainLayout extends StatefulWidget {
  const LecturerMainLayout({super.key});

  @override
  State<LecturerMainLayout> createState() => _LecturerMainLayoutState();
}

class _LecturerMainLayoutState extends State<LecturerMainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const LecturerHomeScreen(),
    const LecturerScheduleScreen(),
    const LecturerAttendanceScreen(),
    const LecturerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Trang chủ'},
      {'icon': Icons.calendar_today_outlined, 'label': 'Lịch dạy'},
      {'icon': Icons.checklist_outlined, 'label': 'Điểm danh'},
      {'icon': Icons.person_outline_rounded, 'label': 'Cá nhân'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[index]['icon'] as IconData,
                      color: isSelected
                          ? const Color(0xFF6B4FA0)
                          : const Color(0xFF9E9E9E),
                      size: 24,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected
                            ? const Color(0xFF6B4FA0)
                            : const Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}