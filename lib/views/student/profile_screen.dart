import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationEnabled = true;
  int _bottomIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildMenuCard(),
                  const SizedBox(height: 24),
                  const Text(
                    'Phiên bản 1.4.8',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      
    );
  }

  // ── Header ──────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
              color: Colors.white,
            ),
            child: ClipOval(
              child: Icon(Icons.person, size: 44, color: Colors.grey[400]),
            ),
          ),
          const SizedBox(width: 14),
          // Name + MSSV
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nguyễn Thành Tài',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'MSSV: 2001230773',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Menu Card ────────────────────────────────────────────────
  Widget _buildMenuCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.article_outlined,
            iconBgColor: const Color(0xFFE3F2FD),
            iconColor: const Color(0xFF1565C0),
            label: 'Thông tin sinh viên',
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.lock_clock_outlined,
            iconBgColor: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF2E7D32),
            label: 'Đổi mật khẩu',
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.description_outlined,
            iconBgColor: const Color(0xFFEDE7F6),
            iconColor: const Color(0xFF5E35B1),
            label: 'Điều khoản và chính sách sử dụng',
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.chat_bubble_outline_rounded,
            iconBgColor: const Color(0xFFFFF3E0),
            iconColor: const Color(0xFFE65100),
            label: 'Góp ý ứng dụng',
            onTap: () {},
          ),
          _buildDivider(),
          // Thông báo với Toggle
          _buildToggleItem(),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.logout_rounded,
            iconBgColor: const Color(0xFFFFEBEE),
            iconColor: const Color(0xFFC62828),
            label: 'Đăng xuất',
            onTap: _showLogoutDialog,
            showArrow: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Icon box
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            // Label
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (showArrow)
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFBDBDBD),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Color(0xFF616161),
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Thông báo',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: _notificationEnabled,
            onChanged: (val) => setState(() => _notificationEnabled = val),
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF43A047),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFBDBDBD),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      indent: 66,
      endIndent: 0,
      color: Color(0xFFF0F0F0),
    );
  }

  // ── Logout Dialog ────────────────────────────────────────────
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Đăng xuất',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: const Text(
          'Bạn có chắc chắn muốn đăng xuất không?',
          style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Huỷ',
              style: TextStyle(color: Color(0xFF616161)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: handle logout
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }

  }