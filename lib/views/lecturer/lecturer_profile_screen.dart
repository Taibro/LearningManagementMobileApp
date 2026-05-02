import 'package:flutter/material.dart';

class LecturerProfileScreen extends StatefulWidget {
  const LecturerProfileScreen({super.key});

  @override
  State<LecturerProfileScreen> createState() => _LecturerProfileScreenState();
}

class _LecturerProfileScreenState extends State<LecturerProfileScreen> {
  bool _notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1F8),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildSemesterCard(),
                  const SizedBox(height: 12),
                  _buildMainMenuCard(),
                  const SizedBox(height: 12),
                  _buildRequestMenuCard(),
                  const SizedBox(height: 12),
                  _buildSettingsCard(),
                  const SizedBox(height: 24),
                  const Text(
                    'HUIT E-Office · Phiên bản 2.1.0',
                    style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
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

  // ─── Header ─────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A3570), Color(0xFF6B4FA0)],
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
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
              color: Colors.white,
            ),
            child: ClipOval(
              child: Icon(Icons.person, size: 46, color: Colors.grey[400]),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nguyễn Văn A',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Mã GV: GV001  ·  Khoa CNTT',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 2),
                Text(
                  'Tiến sĩ · Giảng viên chính',
                  style: TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showEditProfile(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Chỉnh sửa',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Semester summary card ───────────────────────────────────
  Widget _buildSemesterCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.school_outlined,
                    color: Color(0xFF6B4FA0), size: 18),
              ),
              const SizedBox(width: 10),
              const Text(
                'Học kỳ 2 - 2025/2026',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF212121)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSemStat('5', 'Lớp phụ\ntrách'),
              _buildSemDivider(),
              _buildSemStat('120', 'Tiết kế\nhoạch'),
              _buildSemDivider(),
              _buildSemStat('87', 'Tiết đã\ndạy'),
              _buildSemDivider(),
              _buildSemStat('33', 'Tiết còn\nlại'),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 87 / 120,
              backgroundColor: const Color(0xFFE0D8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6B4FA0)),
              minHeight: 7,
            ),
          ),
          const SizedBox(height: 4),
          const Text('Tiến độ giảng dạy: 72.5%',
              style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
        ],
      ),
    );
  }

  Widget _buildSemStat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B4FA0))),
        const SizedBox(height: 2),
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 10, color: Color(0xFF9E9E9E), height: 1.3)),
      ],
    );
  }

  Widget _buildSemDivider() {
    return Container(width: 1, height: 36, color: const Color(0xFFF0F0F0));
  }

  // ─── Main menu ───────────────────────────────────────────────
  Widget _buildMainMenuCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.badge_outlined,
            iconBgColor: const Color(0xFFE8EAF6),
            iconColor: const Color(0xFF5C6BC0),
            label: 'Hồ sơ cá nhân',
            subtitle: 'Thông tin giảng viên',
            onTap: () => _showComingSoon('Hồ sơ cá nhân'),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.monetization_on_outlined,
            iconBgColor: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF2E7D32),
            label: 'Thông tin lương',
            subtitle: 'Xem bảng lương theo tháng',
            onTap: () => _showSalarySheet(),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.assignment_outlined,
            iconBgColor: const Color(0xFFFFF3E0),
            iconColor: const Color(0xFFE65100),
            label: 'Khai báo thông tin',
            subtitle: 'Cập nhật thông tin giảng dạy HK',
            onTap: () => _showDeclarationSheet(),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.library_books_outlined,
            iconBgColor: const Color(0xFFEDE7F6),
            iconColor: const Color(0xFF6B4FA0),
            label: 'Quản lý tài liệu bài giảng',
            subtitle: 'Tải lên và quản lý giáo án',
            onTap: () => _showComingSoon('Tài liệu bài giảng'),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.bar_chart_rounded,
            iconBgColor: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF4CAF50),
            label: 'Thống kê thực giảng, coi thi',
            subtitle: 'Tổng hợp giờ giảng, giờ coi thi',
            onTap: () => _showStatisticsSheet(),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.poll_outlined,
            iconBgColor: const Color(0xFFFCE4EC),
            iconColor: const Color(0xFFE85D75),
            label: 'Khảo sát',
            subtitle: 'Lấy ý kiến sinh viên về môn học',
            onTap: () => _showComingSoon('Khảo sát'),
          ),
        ],
      ),
    );
  }

  // ─── Request menu ────────────────────────────────────────────
  Widget _buildRequestMenuCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const Text(
                  'ĐỀ XUẤT LỊCH DẠY',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6B4FA0),
                      letterSpacing: 0.5),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE85D75),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                const Text('1 chờ duyệt',
                    style: TextStyle(fontSize: 11, color: Color(0xFFE85D75))),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF5F5F5)),
          _buildMenuItem(
            icon: Icons.pause_circle_outline_rounded,
            iconBgColor: const Color(0xFFFFF8E1),
            iconColor: const Color(0xFFF5A623),
            label: 'Đề xuất tạm ngừng lịch dạy',
            subtitle: '2 đề xuất gần đây',
            onTap: () => _showRequestSheet('tamNgung'),
            badge: null,
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.add_circle_outline_rounded,
            iconBgColor: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF4CAF50),
            label: 'Đề xuất dạy bù',
            subtitle: '1 chờ duyệt · 1 đã hoàn thành',
            onTap: () => _showRequestSheet('dayBu'),
            badge: '1',
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.swap_horiz_rounded,
            iconBgColor: const Color(0xFFE3F2FD),
            iconColor: const Color(0xFF1565C0),
            label: 'Đề xuất dạy thay',
            subtitle: 'Không có đề xuất mới',
            onTap: () => _showRequestSheet('dayThay'),
          ),
        ],
      ),
    );
  }

  // ─── Settings card ───────────────────────────────────────────
  Widget _buildSettingsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.lock_outline_rounded,
            iconBgColor: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF2E7D32),
            label: 'Đổi mật khẩu',
            onTap: () => _showComingSoon('Đổi mật khẩu'),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.description_outlined,
            iconBgColor: const Color(0xFFEDE7F6),
            iconColor: const Color(0xFF6B4FA0),
            label: 'Điều khoản & chính sách',
            onTap: () => _showComingSoon('Điều khoản'),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.chat_bubble_outline_rounded,
            iconBgColor: const Color(0xFFFFF3E0),
            iconColor: const Color(0xFFE65100),
            label: 'Góp ý ứng dụng',
            onTap: () => _showComingSoon('Góp ý'),
          ),
          _buildDivider(),
          // Notification toggle
          _buildToggleItem(),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.logout_rounded,
            iconBgColor: const Color(0xFFFFEBEE),
            iconColor: const Color(0xFFC62828),
            label: 'Đăng xuất',
            onTap: _showLogoutDialog,
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
    String? subtitle,
    required VoidCallback onTap,
    String? badge,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF212121),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ],
              ),
            ),
            if (badge != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE85D75),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right,
                color: Color(0xFFBDBDBD), size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.notifications_outlined,
                color: Color(0xFF616161), size: 20),
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
            onChanged: (val) =>
                setState(() => _notificationEnabled = val),
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF6B4FA0),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFBDBDBD),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => const Divider(
      height: 1, indent: 68, color: Color(0xFFF0F0F0));

  // ─── Bottom sheets ───────────────────────────────────────────

  void _showSalarySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SalarySheet(),
    );
  }

  void _showDeclarationSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _DeclarationSheet(),
    );
  }

  void _showStatisticsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _StatisticsSheet(),
    );
  }

  void _showRequestSheet(String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RequestSheet(type: type),
    );
  }

  void _showEditProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _EditProfileSheet(),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Sắp ra mắt'),
        backgroundColor: const Color(0xFF6B4FA0),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Đăng xuất',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        content: const Text('Bạn có chắc chắn muốn đăng xuất không?',
            style: TextStyle(fontSize: 14, color: Color(0xFF616161))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Huỷ',
                style: TextStyle(color: Color(0xFF616161))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// SALARY BOTTOM SHEET
// ════════════════════════════════════════════════════════════
class _SalarySheet extends StatelessWidget {
  _SalarySheet();

  final List<Map<String, dynamic>> _items = [
    {'label': 'Lương cơ bản', 'amount': '12,500,000đ', 'note': 'Hệ số 3.0', 'plus': true},
    {'label': 'Phụ cấp chức vụ', 'amount': '800,000đ', 'note': '', 'plus': true},
    {'label': 'Phụ cấp thâm niên', 'amount': '1,200,000đ', 'note': '8% lương CB', 'plus': true},
    {'label': 'Thưởng tiết dạy vượt', 'amount': '1,200,000đ', 'note': '12 tiết × 100,000đ', 'plus': true},
    {'label': 'Bảo hiểm xã hội (8%)', 'amount': '-1,000,000đ', 'note': '', 'plus': false},
    {'label': 'Thuế TNCN', 'amount': '-1,100,000đ', 'note': '', 'plus': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildSheetHandle(),
          _buildSheetHeader('Thông tin lương', 'Tháng 3/2026',
              const Color(0xFF2E7D32)),
          // Summary
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildSalaryStat('12,500,000đ', 'Lương cơ bản',
                    const Color(0xFF4CAF50)),
                const SizedBox(width: 8),
                _buildSalaryStat('3,200,000đ', 'Phụ cấp',
                    const Color(0xFF6B4FA0)),
                const SizedBox(width: 8),
                _buildSalaryStat('14,800,000đ', 'Thực nhận',
                    const Color(0xFFE85D75)),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ..._items.map((item) => _buildSalaryRow(item)),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('THỰC NHẬN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Text('14,800,000đ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryStat(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(value,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: color)),
            const SizedBox(height: 2),
            Text(label,
                style:
                    const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryRow(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['label'],
                    style: TextStyle(
                        fontSize: 13,
                        color: item['plus']
                            ? const Color(0xFF212121)
                            : const Color(0xFFC62828))),
                if ((item['note'] as String).isNotEmpty)
                  Text(item['note'],
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9E9E9E))),
              ],
            ),
          ),
          Text(
            item['amount'],
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: item['plus']
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFFC62828)),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// DECLARATION BOTTOM SHEET
// ════════════════════════════════════════════════════════════
class _DeclarationSheet extends StatelessWidget {
  const _DeclarationSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildSheetHandle(),
          _buildSheetHeader('Khai báo thông tin',
              'HK2 - 2025/2026', const Color(0xFFE65100)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Họ và tên', 'Nguyễn Văn A', readOnly: true),
                  const SizedBox(height: 12),
                  _buildInfoRow('Mã giảng viên', 'GV001', readOnly: true),
                  const SizedBox(height: 12),
                  _buildInfoRow('Khoa / Bộ môn', 'Công nghệ thông tin', readOnly: true),
                  const SizedBox(height: 12),
                  _buildInfoRow('Học kỳ khai báo', 'HK2 - 2025-2026'),
                  const SizedBox(height: 12),
                  _buildInfoRow('Số tiết dạy dự kiến', '120'),
                  const SizedBox(height: 12),
                  _buildInfoRow('Số lớp phụ trách', '5'),
                  const SizedBox(height: 12),
                  const Text('Ghi chú',
                      style: TextStyle(
                          fontSize: 12, color: Color(0xFF616161))),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0D8F0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Không có ghi chú đặc biệt.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text('💾  Lưu khai báo',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12, color: Color(0xFF616161))),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: readOnly ? const Color(0xFFF9F7FF) : Colors.white,
            border: Border.all(color: const Color(0xFFE0D8F0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value,
              style: TextStyle(
                  fontSize: 13,
                  color: readOnly
                      ? const Color(0xFF9E9E9E)
                      : const Color(0xFF212121))),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════
// STATISTICS BOTTOM SHEET
// ════════════════════════════════════════════════════════════
class _StatisticsSheet extends StatelessWidget {
  const _StatisticsSheet();

  @override
  Widget build(BuildContext context) {
    final stats = [
      {'label': 'Tổng tiết đã dạy', 'value': '87 tiết', 'color': const Color(0xFF6B4FA0)},
      {'label': 'Tiết lý thuyết', 'value': '45 tiết', 'color': const Color(0xFF4CAF50)},
      {'label': 'Tiết thực hành', 'value': '30 tiết', 'color': const Color(0xFF5C6BC0)},
      {'label': 'Tiết trực tuyến', 'value': '12 tiết', 'color': const Color(0xFFE65100)},
      {'label': 'Số buổi coi thi', 'value': '3 buổi', 'color': const Color(0xFFE85D75)},
      {'label': 'Tiết vượt kế hoạch', 'value': '+12 tiết', 'color': const Color(0xFF2E7D32)},
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildSheetHandle(),
          _buildSheetHeader('Thống kê thực giảng', 'HK2 - 2025/2026',
              const Color(0xFF4CAF50)),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemCount: stats.length,
              itemBuilder: (_, i) {
                final s = stats[i];
                final color = s['color'] as Color;
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(s['value'] as String,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color)),
                      Text(s['label'] as String,
                          style: const TextStyle(
                              fontSize: 11, color: Color(0xFF9E9E9E))),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// REQUEST BOTTOM SHEET (Tạm ngừng / Dạy bù / Dạy thay)
// ════════════════════════════════════════════════════════════
class _RequestSheet extends StatefulWidget {
  final String type;
  const _RequestSheet({required this.type});

  @override
  State<_RequestSheet> createState() => _RequestSheetState();
}

class _RequestSheetState extends State<_RequestSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  String get _title {
    switch (widget.type) {
      case 'dayBu': return 'Đề xuất dạy bù';
      case 'dayThay': return 'Đề xuất dạy thay';
      default: return 'Đề xuất tạm ngừng lịch dạy';
    }
  }

  final List<Map<String, dynamic>> _history = [
    {'class': '14DHTH04', 'date': '15/03/2026', 'reason': 'Tham dự hội thảo khoa học', 'status': 'approved'},
    {'class': '14DHTH03', 'date': '22/02/2026', 'reason': 'Ốm, có giấy tờ y tế', 'status': 'pending'},
    {'class': '16DHTH10', 'date': '10/01/2026', 'reason': 'Việc gia đình', 'status': 'rejected'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildSheetHandle(),
          _buildSheetHeader(_title, 'Quản lý đề xuất', const Color(0xFFE65100)),
          TabBar(
            controller: _tab,
            labelColor: const Color(0xFF6B4FA0),
            unselectedLabelColor: const Color(0xFF9E9E9E),
            indicatorColor: const Color(0xFF6B4FA0),
            indicatorWeight: 2,
            labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            tabs: const [Tab(text: 'Tạo đề xuất'), Tab(text: 'Lịch sử')],
          ),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _buildCreateForm(),
                _buildHistory(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildFormField('Lớp học phần', '010110195604 - 14DHTH04', isDropdown: true),
          const SizedBox(height: 12),
          _buildFormField('Ngày xin ngừng / bù', '25/04/2026', isDate: true),
          const SizedBox(height: 12),
          _buildFormField('Ca học', 'Sáng (Tiết 1–3)', isDropdown: true),
          const SizedBox(height: 12),
          if (widget.type == 'dayBu') ...[
            _buildFormField('Ngày dạy bù đề xuất', '28/04/2026', isDate: true),
            const SizedBox(height: 12),
            _buildFormField('Phòng học đề xuất', 'VD: A401'),
            const SizedBox(height: 12),
          ],
          const Text('Lý do',
              style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
          const SizedBox(height: 4),
          Container(
            height: 80,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0D8F0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text('Nhập lý do đề xuất...',
                  style: TextStyle(fontSize: 13, color: Color(0xFFBDBDBD))),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('📤  Gửi đề xuất',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String hint,
      {bool isDropdown = false, bool isDate = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF616161))),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0D8F0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hint,
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFF424242))),
              if (isDropdown)
                const Icon(Icons.keyboard_arrow_down,
                    color: Color(0xFF6B4FA0), size: 18)
              else if (isDate)
                const Icon(Icons.calendar_today_outlined,
                    color: Color(0xFF6B4FA0), size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _history.map((item) {
        Color statusColor;
        String statusLabel;
        switch (item['status']) {
          case 'approved':
            statusColor = const Color(0xFF4CAF50);
            statusLabel = 'Đã duyệt';
            break;
          case 'rejected':
            statusColor = const Color(0xFFC62828);
            statusLabel = 'Từ chối';
            break;
          default:
            statusColor = const Color(0xFFE65100);
            statusLabel = 'Chờ duyệt';
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F7FF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE0D8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${item['class']} · ${item['date']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(statusLabel,
                        style: TextStyle(
                            fontSize: 11,
                            color: statusColor,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Lý do: ${item['reason']}',
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF616161))),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ════════════════════════════════════════════════════════════
// EDIT PROFILE BOTTOM SHEET
// ════════════════════════════════════════════════════════════
class _EditProfileSheet extends StatelessWidget {
  const _EditProfileSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildSheetHandle(),
          _buildSheetHeader(
              'Thông tin giảng viên', 'Chỉ đọc', const Color(0xFF6B4FA0)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProfileRow('Họ và tên', 'Nguyễn Văn A'),
                  _buildProfileRow('Mã giảng viên', 'GV001'),
                  _buildProfileRow('Khoa / Bộ môn', 'Công nghệ thông tin'),
                  _buildProfileRow('Học hàm / Học vị', 'Tiến sĩ'),
                  _buildProfileRow('Chức danh', 'Giảng viên chính'),
                  _buildProfileRow('Email công vụ', 'gv001@huit.edu.vn'),
                  _buildProfileRow('Điện thoại', '0901 234 567'),
                  _buildProfileRow('Ngày vào trường', '15/08/2015'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 13, color: Color(0xFF9E9E9E))),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF212121))),
          ),
        ],
      ),
    );
  }
}

// ─── Shared helpers ──────────────────────────────────────────
Widget _buildSheetHandle() {
  return Center(
    child: Container(
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: const Color(0xFFE0D8F0),
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );
}

Widget _buildSheetHeader(String title, String subtitle, Color color) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.info_outline, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF212121))),
            Text(subtitle,
                style:
                    const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
          ],
        ),
      ],
    ),
  );
}