import 'package:flutter/material.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});
  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  static const _kPrimary = Color(0xFF1A237E);
  static const _kBg      = Color(0xFFF0F2FF);

  // ── Toggles ──────────────────────────────────────────────
  bool _notifNewRequest  = true;
  bool _notifAttendance  = true;
  bool _notifGrade       = false;
  bool _maintenanceMode  = false;
  bool _allowQr          = true;
  bool _allowOnline      = true;

  // ── Current semester ─────────────────────────────────────
  String _currentSemester = 'HK2 - 2025-2026';
  String _semesterStatus  = 'Đang diễn ra';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(children: [
        _buildHeader(),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            _buildAdminProfile(),
            const SizedBox(height: 14),
            _buildSemesterCard(),
            const SizedBox(height: 14),
            _buildSystemCard(),
            const SizedBox(height: 14),
            _buildNotifCard(),
            const SizedBox(height: 14),
            _buildAnnouncementCard(),
            const SizedBox(height: 14),
            _buildAccountCard(),
            const SizedBox(height: 24),
            const Text('HUIT E-Office Admin · v2.1.0',
                style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
            const SizedBox(height: 24),
          ]),
        )),
      ]),
    );
  }

  // ── Header ───────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D1B6E), _kPrimary],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 14,
        left: 16, right: 16, bottom: 16,
      ),
      child: const Row(children: [
        Icon(Icons.settings_rounded, color: Colors.white, size: 22),
        SizedBox(width: 10),
        Text('Cài đặt hệ thống',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
      ]),
    );
  }

  // ── Admin profile ─────────────────────────────────────────
  Widget _buildAdminProfile() {
    return _card(child: Row(children: [
      Container(
        width: 56, height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(colors: [Color(0xFF1A237E), Color(0xFF3949AB)]),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
        ),
        child: const Center(child: Text('AD',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
      ),
      const SizedBox(width: 14),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Quản trị viên', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF212121))),
        SizedBox(height: 3),
        Text('admin@huit.edu.vn', style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
        SizedBox(height: 3),
        Text('Trường ĐH Công nghiệp TP.HCM', style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
      ])),
      GestureDetector(
        onTap: () => _showEditProfile(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: _kPrimary, borderRadius: BorderRadius.circular(20)),
          child: const Text('Chỉnh sửa',
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
      ),
    ]));
  }

  // ── Semester management ───────────────────────────────────
  Widget _buildSemesterCard() {
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionTitle('Quản lý học kỳ', Icons.school_outlined),
      const SizedBox(height: 14),
      // Current semester info
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF0D1B6E), _kPrimary]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Học kỳ hiện tại', style: TextStyle(color: Colors.white70, fontSize: 12)),
            SizedBox(height: 4),
            Text('HK2 - 2025-2026', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('28/01/2026 – 31/05/2026', style: TextStyle(color: Colors.white60, fontSize: 11)),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: const Color(0xFF4CAF50), borderRadius: BorderRadius.circular(20)),
            child: const Text('Đang diễn ra',
                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
          ),
        ]),
      ),
      const SizedBox(height: 14),
      // Semester actions
      Row(children: [
        Expanded(child: _actionBtn('Tạo HK mới', const Color(0xFF4CAF50), Icons.add_circle_outline, () => _showNewSemesterSheet())),
        const SizedBox(width: 10),
        Expanded(child: _actionBtn('Kết thúc HK', const Color(0xFFC62828), Icons.stop_circle_outlined, () => _showEndSemesterDialog())),
      ]),
      const SizedBox(height: 10),
      // Semester history
      const Text('Lịch sử học kỳ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF424242))),
      const SizedBox(height: 8),
      ...[
        {'sem': 'HK1 - 2025-2026', 'period': '08/2025 – 01/2026', 'status': 'done'},
        {'sem': 'HK2 - 2024-2025', 'period': '01/2025 – 06/2025', 'status': 'done'},
      ].map((s) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9FF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Row(children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFF9E9E9E), size: 16),
          const SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s['sem']!, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
            Text(s['period']!, style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
          ])),
          const Text('Kết thúc', style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
        ]),
      )),
    ]));
  }

  // ── System settings ───────────────────────────────────────
  Widget _buildSystemCard() {
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionTitle('Cài đặt hệ thống', Icons.tune_rounded),
      const SizedBox(height: 14),
      _toggleRow('Chế độ bảo trì', 'Tắt tạm thời truy cập người dùng',
          Icons.build_outlined, const Color(0xFFE85D75), _maintenanceMode,
          (v) => setState(() => _maintenanceMode = v)),
      _divider(),
      _toggleRow('Cho phép điểm danh QR', 'Sinh viên quét mã điểm danh',
          Icons.qr_code_2_rounded, const Color(0xFF4CAF50), _allowQr,
          (v) => setState(() => _allowQr = v)),
      _divider(),
      _toggleRow('Cho phép học trực tuyến', 'Hiển thị lớp trực tuyến trên TKB',
          Icons.video_call_outlined, const Color(0xFF1565C0), _allowOnline,
          (v) => setState(() => _allowOnline = v)),
      _divider(),
      _menuRow('Sao lưu dữ liệu', 'Lần cuối: 14/05/2026 22:00',
          Icons.backup_outlined, const Color(0xFF2E7D32), () => _snack('Đang sao lưu...')),
      _divider(),
      _menuRow('Cấu hình phòng học', '86 phòng đang hoạt động',
          Icons.meeting_room_outlined, const Color(0xFFE65100), () => _showRoomConfig()),
      _divider(),
      _menuRow('Quản lý học kỳ & năm học', 'Thêm, xoá, cập nhật học kỳ',
          Icons.date_range_outlined, _kPrimary, () => _snack('Mở quản lý học kỳ')),
    ]));
  }

  // ── Notifications ─────────────────────────────────────────
  Widget _buildNotifCard() {
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionTitle('Cài đặt thông báo', Icons.notifications_outlined),
      const SizedBox(height: 14),
      _toggleRow('Đề xuất lịch dạy mới', 'Nhận TB khi GV gửi đề xuất',
          Icons.pending_actions_outlined, const Color(0xFFE65100), _notifNewRequest,
          (v) => setState(() => _notifNewRequest = v)),
      _divider(),
      _toggleRow('Cảnh báo điểm danh', 'SV vắng quá 20%',
          Icons.warning_amber_outlined, const Color(0xFFE85D75), _notifAttendance,
          (v) => setState(() => _notifAttendance = v)),
      _divider(),
      _toggleRow('Bảng điểm chưa nộp', 'GV chưa nộp điểm đúng hạn',
          Icons.grade_outlined, const Color(0xFF4CAF50), _notifGrade,
          (v) => setState(() => _notifGrade = v)),
      _divider(),
      _menuRow('Gửi thông báo hàng loạt', 'Gửi cho sinh viên / giảng viên',
          Icons.campaign_outlined, _kPrimary, () => _showBroadcastSheet()),
    ]));
  }

  // ── Announcements ─────────────────────────────────────────
  Widget _buildAnnouncementCard() {
    final announcements = [
      {'title': 'Lịch thi HK2 2025-2026 đã có', 'target': 'Tất cả', 'date': '10/05/2026', 'type': 'info'},
      {'title': 'Nhắc nhở nộp bảng điểm trước 20/05', 'target': 'Giảng viên', 'date': '08/05/2026', 'type': 'warning'},
      {'title': 'Hệ thống bảo trì 23:00 – 01:00', 'target': 'Tất cả', 'date': '05/05/2026', 'type': 'danger'},
    ];
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _sectionTitle('Thông báo đã gửi', Icons.campaign_outlined),
        GestureDetector(
          onTap: () => _showBroadcastSheet(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: _kPrimary, borderRadius: BorderRadius.circular(20)),
            child: const Row(children: [
              Icon(Icons.add, color: Colors.white, size: 14),
              SizedBox(width: 3),
              Text('Tạo mới', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
      ]),
      const SizedBox(height: 12),
      ...announcements.map((a) {
        Color col;
        IconData icon;
        switch (a['type']) {
          case 'warning': col = const Color(0xFFE65100); icon = Icons.warning_amber_outlined; break;
          case 'danger':  col = const Color(0xFFC62828); icon = Icons.error_outline; break;
          default:        col = _kPrimary;                icon = Icons.info_outline;
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: col.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: col.withOpacity(0.2)),
          ),
          child: Row(children: [
            Icon(icon, color: col, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(a['title']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 2),
              Text('Gửi tới: ${a['target']}  ·  ${a['date']}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
            ])),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 18),
          ]),
        );
      }),
    ]));
  }

  // ── Account settings ──────────────────────────────────────
  Widget _buildAccountCard() {
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionTitle('Tài khoản', Icons.manage_accounts_outlined),
      const SizedBox(height: 14),
      _menuRow('Đổi mật khẩu quản trị', '',
          Icons.lock_outline_rounded, const Color(0xFF2E7D32), () => _showChangePassword()),
      _divider(),
      _menuRow('Phân quyền quản trị', '2 tài khoản admin',
          Icons.admin_panel_settings_outlined, const Color(0xFF5C6BC0), () => _snack('Quản lý phân quyền')),
      _divider(),
      _menuRow('Nhật ký hoạt động', 'Xem log hệ thống',
          Icons.history_rounded, const Color(0xFF9E9E9E), () => _showActivityLog()),
      _divider(),
      _menuRow('Đăng xuất', '',
          Icons.logout_rounded, const Color(0xFFC62828), () => _showLogoutDialog()),
    ]));
  }

  // ── Shared helpers ────────────────────────────────────────
  Widget _card({required Widget child}) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(14),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
    ),
    child: child,
  );

  Widget _sectionTitle(String t, IconData icon) => Row(children: [
    Icon(icon, color: _kPrimary, size: 18),
    const SizedBox(width: 8),
    Text(t, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF212121))),
  ]);

  Widget _divider() => const Divider(height: 1, indent: 52, color: Color(0xFFF0F0F0));

  Widget _toggleRow(String label, String subtitle, IconData icon, Color col, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        Container(
          width: 38, height: 38,
          decoration: BoxDecoration(color: col.withOpacity(0.10), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: col, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF212121))),
          if (subtitle.isNotEmpty)
            Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
        ])),
        Switch(
          value: value, onChanged: onChanged,
          activeColor: Colors.white, activeTrackColor: _kPrimary,
          inactiveThumbColor: Colors.white, inactiveTrackColor: const Color(0xFFBDBDBD),
        ),
      ]),
    );
  }

  Widget _menuRow(String label, String subtitle, IconData icon, Color col, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: col.withOpacity(0.10), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: col, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF212121))),
            if (subtitle.isNotEmpty)
              Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
          ])),
          Icon(Icons.chevron_right, color: Colors.grey[400], size: 22),
        ]),
      ),
    );
  }

  Widget _actionBtn(String label, Color color, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(9)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
        ]),
      ),
    );
  }

  // ── Bottom sheets & dialogs ───────────────────────────────
  void _showEditProfile() {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => _buildBottomSheet('Chỉnh sửa hồ sơ Admin', Icons.person_outlined, [
        _sheetField('Tên hiển thị', 'Quản trị viên'),
        _sheetField('Email',        'admin@huit.edu.vn'),
        _sheetField('Điện thoại',   '0901 234 567'),
        _sheetField('Đơn vị',       'Phòng Đào tạo – HUIT'),
      ], 'Lưu thay đổi'),
    );
  }

  void _showNewSemesterSheet() {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => _buildBottomSheet('Tạo học kỳ mới', Icons.add_circle_outline, [
        _sheetField('Tên học kỳ', 'VD: HK1 - 2026-2027'),
        _sheetField('Ngày bắt đầu', '01/08/2026'),
        _sheetField('Ngày kết thúc', '15/01/2027'),
        _sheetField('Năm học', '2026-2027'),
      ], 'Tạo học kỳ'),
    );
  }

  void _showBroadcastSheet() {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.72,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(children: [
          _sheetHandle(),
          _sheetHeader('Gửi thông báo hàng loạt', Icons.campaign_outlined),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
            _sheetField('Tiêu đề', 'Nhập tiêu đề thông báo...'),
            const SizedBox(height: 12),
            const Text('Đối tượng nhận', style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
            const SizedBox(height: 6),
            Row(children: [
              _audienceChip('Tất cả', true),
              const SizedBox(width: 8),
              _audienceChip('Sinh viên', false),
              const SizedBox(width: 8),
              _audienceChip('Giảng viên', false),
            ]),
            const SizedBox(height: 12),
            const Text('Nội dung', style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
            const SizedBox(height: 4),
            Container(
              height: 100,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE0D8F0)), borderRadius: BorderRadius.circular(8)),
              child: const Align(alignment: Alignment.topLeft,
                child: Text('Nhập nội dung thông báo...', style: TextStyle(fontSize: 13, color: Color(0xFFBDBDBD)))),
            ),
            const SizedBox(height: 20),
            _submitButton('📣  Gửi thông báo', () => Navigator.pop(context)),
          ]))),
        ]),
      ),
    );
  }

  Widget _audienceChip(String label, bool selected) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? _kPrimary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? _kPrimary : const Color(0xFFE0D8F0)),
        ),
        child: Text(label, style: TextStyle(fontSize: 12, color: selected ? Colors.white : const Color(0xFF424242), fontWeight: FontWeight.w500)),
      ),
    );
  }

  void _showRoomConfig() {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.60,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(children: [
          _sheetHandle(),
          _sheetHeader('Cấu hình phòng học', Icons.meeting_room_outlined),
          Expanded(child: ListView(padding: const EdgeInsets.all(16), children: [
            ...[
              {'id': 'A101', 'cap': '60', 'status': 'Hoạt động'},
              {'id': 'A107', 'cap': '30', 'status': 'Hoạt động'},
              {'id': 'A202', 'cap': '60', 'status': 'Hoạt động'},
              {'id': 'B407', 'cap': '50', 'status': 'Bảo trì'},
            ].map((r) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FF), borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Row(children: [
                const Icon(Icons.meeting_room_outlined, color: Color(0xFF1A237E), size: 20),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Phòng ${r['id']}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  Text('Sức chứa: ${r['cap']}  ·  ${r['status']}', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                ])),
                Icon(Icons.edit_outlined, color: Colors.grey[400], size: 18),
              ]),
            )),
            const SizedBox(height: 8),
            _submitButton('+ Thêm phòng học', () => Navigator.pop(context)),
          ])),
        ]),
      ),
    );
  }

  void _showChangePassword() {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => _buildBottomSheet('Đổi mật khẩu', Icons.lock_outline_rounded, [
        _sheetField('Mật khẩu hiện tại', '••••••••'),
        _sheetField('Mật khẩu mới', ''),
        _sheetField('Xác nhận mật khẩu mới', ''),
      ], 'Đổi mật khẩu'),
    );
  }

  void _showActivityLog() {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(children: [
          _sheetHandle(),
          _sheetHeader('Nhật ký hoạt động', Icons.history_rounded),
          Expanded(child: ListView(padding: const EdgeInsets.all(16), children: [
            ...[
              {'msg': 'Admin duyệt đề xuất dạy bù – GV Nguyễn Văn A', 'time': '28/04 – 09:12', 'icon': Icons.check_circle_outline, 'color': const Color(0xFF4CAF50)},
              {'msg': 'Admin cập nhật phòng học A107', 'time': '27/04 – 15:44', 'icon': Icons.edit_outlined, 'color': _kPrimary},
              {'msg': 'Xuất báo cáo điểm danh HK2', 'time': '25/04 – 10:20', 'icon': Icons.download_outlined, 'color': const Color(0xFFE65100)},
              {'msg': 'Khoá tài khoản SV 12DHBM05001', 'time': '22/04 – 11:05', 'icon': Icons.block, 'color': const Color(0xFFC62828)},
              {'msg': 'Tạo học kỳ HK2 2025-2026', 'time': '28/01 – 08:00', 'icon': Icons.add_box_outlined, 'color': const Color(0xFF2E7D32)},
            ].map((log) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFF9F9FF), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFEEEEEE))),
              child: Row(children: [
                Icon(log['icon'] as IconData, color: log['color'] as Color, size: 18),
                const SizedBox(width: 10),
                Expanded(child: Text(log['msg'] as String, style: const TextStyle(fontSize: 12, color: Color(0xFF424242)))),
                Text(log['time'] as String, style: const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
              ]),
            )),
          ])),
        ]),
      ),
    );
  }

  void _showEndSemesterDialog() {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Kết thúc học kỳ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      content: const Text(
        'Xác nhận kết thúc HK2 - 2025-2026?\n\nThao tác này sẽ khoá toàn bộ việc chỉnh sửa lịch và điểm số.',
        style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Huỷ', style: TextStyle(color: Color(0xFF616161)))),
        ElevatedButton(
          onPressed: () => Navigator.pop(ctx),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC62828), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          child: const Text('Kết thúc HK'),
        ),
      ],
    ));
  }

  void _showLogoutDialog() {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Đăng xuất', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      content: const Text('Bạn có chắc muốn đăng xuất khỏi trang quản trị?',
          style: TextStyle(fontSize: 14, color: Color(0xFF616161))),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Huỷ', style: TextStyle(color: Color(0xFF616161)))),
        ElevatedButton(
          onPressed: () => Navigator.pop(ctx),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A237E), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          child: const Text('Đăng xuất'),
        ),
      ],
    ));
  }

  // ── Sheet builder helpers ─────────────────────────────────
  Widget _buildBottomSheet(String title, IconData icon, List<Widget> fields, String btnLabel) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(children: [
        _sheetHandle(),
        _sheetHeader(title, icon),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
          ...fields.map((f) => Padding(padding: const EdgeInsets.only(bottom: 12), child: f)),
          const SizedBox(height: 8),
          _submitButton(btnLabel, () => Navigator.pop(context)),
        ]))),
      ]),
    );
  }

  Widget _sheetHandle() => Center(child: Container(
    margin: const EdgeInsets.only(top: 12, bottom: 8),
    width: 40, height: 4,
    decoration: BoxDecoration(color: const Color(0xFFE0D8F0), borderRadius: BorderRadius.circular(2)),
  ));

  Widget _sheetHeader(String title, IconData icon) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
    child: Row(children: [
      Container(width: 40, height: 40,
        decoration: BoxDecoration(color: _kPrimary.withOpacity(0.10), shape: BoxShape.circle),
        child: Icon(icon, color: _kPrimary, size: 20)),
      const SizedBox(width: 12),
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF212121))),
    ]),
  );

  Widget _sheetField(String label, String value) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF616161))),
    const SizedBox(height: 4),
    Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: value.isEmpty ? Colors.white : const Color(0xFFF9F9FF),
        border: Border.all(color: const Color(0xFFE0D8F0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value.isEmpty ? 'Nhập $label...' : value,
        style: TextStyle(fontSize: 13, color: value.isEmpty ? const Color(0xFFBDBDBD) : const Color(0xFF212121)),
      ),
    ),
  ]);

  Widget _submitButton(String label, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF0D1B6E), _kPrimary]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14))),
    ),
  );

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: _kPrimary, behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 2)),
  );
}