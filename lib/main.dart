import 'package:flutter/material.dart';
import 'package:learning_management_app/views/student/attendance_screen.dart';
import 'package:learning_management_app/views/student/home_screen.dart';
import 'package:learning_management_app/views/student/profile_screen.dart';
import 'package:learning_management_app/views/student/schedule_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
      ),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
int _selectedIndex = 0;

  // Danh sách các màn hình sẽ được tráo đổi
  final List<Widget> _screens = [
    const HomeScreen(),
    const ScheduleScreen(),
    const AttendanceScreen(), // Tạo tạm một màn hình rỗng nếu chưa có
    const ProfileScreen(),    // Tạo tạm một màn hình rỗng nếu chưa có
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
      {'icon': Icons.calendar_today_outlined, 'label': 'Lịch học'},
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
                      color: isSelected ? const Color(0xFF1565C0) : const Color(0xFF9E9E9E),
                      size: 24,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? const Color(0xFF1565C0) : const Color(0xFF9E9E9E),
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