import 'package:flutter/material.dart';
import 'dart:async';

class LecturerAttendanceScreen extends StatefulWidget {
  const LecturerAttendanceScreen({super.key});

  @override
  State<LecturerAttendanceScreen> createState() =>
      _LecturerAttendanceScreenState();
}

class _LecturerAttendanceScreenState extends State<LecturerAttendanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ── Attendance tab state ──────────────────────────────────
  String _selectedSemester = 'HK2 - 2025-2026';
  String _selectedClass = '010110195604 - 14DHTH04';
  String _searchQuery = '';
  String _comment = 'Lớp học nghiêm túc, đúng giờ.';
  final TextEditingController _commentController =
      TextEditingController(text: 'Lớp học nghiêm túc, đúng giờ.');

 
  final List<Map<String, dynamic>> _students = [
    {'name': 'Kiều Tấn Phát', 'mssv': '14DHTH13001', 'dob': '12/03/2001', 'class': '14DHTH13', 'status': 0},
    {'name': 'Âu Gia Quốc', 'mssv': '14DHTH12005', 'dob': '05/07/2001', 'class': '14DHTH12', 'status': 0},
    {'name': 'Cao Đức Mạnh', 'mssv': '14DHTH12007', 'dob': '22/11/2001', 'class': '14DHTH12', 'status': 0},
    {'name': 'Nguyễn Thị Mai', 'mssv': '14DHTH13002', 'dob': '14/06/2001', 'class': '14DHTH13', 'status': 2},
    {'name': 'Phan Trọng Nghiêm', 'mssv': '12DHBM05001', 'dob': '09/01/2000', 'class': '12DHBM05', 'status': 1},
    {'name': 'Trần Minh Khoa', 'mssv': '14DHTH13010', 'dob': '30/08/2001', 'class': '14DHTH13', 'status': 0},
    {'name': 'Lê Thu Hà', 'mssv': '14DHTH14003', 'dob': '18/02/2001', 'class': '14DHTH14', 'status': 0},
    {'name': 'Đặng Văn Hùng', 'mssv': '14DHTH12009', 'dob': '25/10/2000', 'class': '14DHTH12', 'status': 0},
  ];

  // ── QR tab state ──────────────────────────────────────────
  bool _qrGenerated = false;
  int _qrSeconds = 900; // 15 min
  Timer? _qrTimer;

  final List<Map<String, dynamic>> _qrScanned = [
    {'name': 'Kiều Tấn Phát', 'mssv': '14DHTH13001', 'time': '07:32:15', 'late': false},
    {'name': 'Âu Gia Quốc', 'mssv': '14DHTH12005', 'time': '07:35:42', 'late': false},
    {'name': 'Cao Đức Mạnh', 'mssv': '14DHTH12007', 'time': '07:42:01', 'late': true},
  ];

  // ── Grades tab state ─────────────────────────────────────
  final List<Map<String, dynamic>> _grades = [
    {'name': 'Kiều Tấn Phát', 'mssv': '14DHTH13001', 'cc': 9.0, 'gk': 8.5, 'ck': 9.2},
    {'name': 'Âu Gia Quốc', 'mssv': '14DHTH12005', 'cc': 8.5, 'gk': 7.0, 'ck': 8.0},
    {'name': 'Cao Đức Mạnh', 'mssv': '14DHTH12007', 'cc': 7.0, 'gk': 6.5, 'ck': 7.8},
    {'name': 'Nguyễn Thị Mai', 'mssv': '14DHTH13002', 'cc': 6.0, 'gk': 7.5, 'ck': 7.0},
    {'name': 'Phan Trọng Nghiêm', 'mssv': '12DHBM05001', 'cc': 4.0, 'gk': 3.5, 'ck': 4.2},
  ];

  double _computeTotal(Map<String, dynamic> g) =>
      g['cc'] * 0.1 + g['gk'] * 0.3 + g['ck'] * 0.6;

  String _gradeLabel(double total) {
    if (total >= 9.0) return 'Xuất sắc';
    if (total >= 8.0) return 'Giỏi';
    if (total >= 7.0) return 'Khá';
    if (total >= 5.0) return 'Trung bình';
    return 'Không đạt';
  }

  Color _gradeLabelColor(double total) {
    if (total >= 9.0) return const Color(0xFF2E7D32);
    if (total >= 7.0) return const Color(0xFF1565C0);
    if (total >= 5.0) return const Color(0xFFE65100);
    return const Color(0xFFC62828);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _qrTimer?.cancel();
    _commentController.dispose();
    super.dispose();
  }

  void _startQrTimer() {
    _qrTimer?.cancel();
    _qrSeconds = 900;
    _qrTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_qrSeconds > 0) {
        setState(() => _qrSeconds--);
      } else {
        _qrTimer?.cancel();
      }
    });
  }

  String _formatQrTime(int s) =>
      '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1F8),
      body: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAttendanceTab(),
                _buildQrTab(),
                _buildGradesTab(),
              ],
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
        top: MediaQuery.of(context).padding.top + 14,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: const Row(
        children: [
          Icon(Icons.how_to_reg_outlined, color: Colors.white, size: 22),
          SizedBox(width: 10),
          Text(
            'Quản lý điểm danh',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: const Color(0xFF6B4FA0),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const [
          Tab(text: 'Điểm danh'),
          Tab(text: 'QR Code'),
          Tab(text: 'Kết quả HT'),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // TAB 1 – ĐIỂM DANH THỦ CÔNG
  // ═══════════════════════════════════════════════════════════
  Widget _buildAttendanceTab() {
    final present =
        _students.where((s) => s['status'] == 0).length;
    final excused =
        _students.where((s) => s['status'] == 1).length;
    final absent =
        _students.where((s) => s['status'] == 2).length;

    final filtered = _searchQuery.isEmpty
        ? _students
        : _students
            .where((s) =>
                (s['name'] as String)
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ||
                (s['mssv'] as String)
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()))
            .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Filter card
          _buildFilterCard(),
          const SizedBox(height: 14),
          // Stats
          Row(
            children: [
              _buildStatChip('Sĩ số', '${_students.length}',
                  const Color(0xFF6B4FA0)),
              const SizedBox(width: 8),
              _buildStatChip(
                  'Có mặt', '$present', const Color(0xFF4CAF50)),
              const SizedBox(width: 8),
              _buildStatChip(
                  'Vắng có phép', '$excused', const Color(0xFFE65100)),
              const SizedBox(width: 8),
              _buildStatChip(
                  'Vắng không phép', '$absent', const Color(0xFFC62828)),
            ],
          ),
          const SizedBox(height: 14),
          // Comment
          _buildCommentCard(),
          const SizedBox(height: 14),
          // Student list
          _buildStudentList(filtered),
        ],
      ),
    );
  }

  Widget _buildFilterCard() {
    final semesters = ['HK2 - 2025-2026', 'HK1 - 2025-2026'];
    final classes = [
      '010110195604 - 14DHTH04',
      '010110195603 - 14DHTH03',
      '010110195602 - 14DHTH02',
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDropdown('Học kỳ', semesters, _selectedSemester,
                    (v) => setState(() => _selectedSemester = v!)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDropdown('Lớp học phần', classes,
                    _selectedClass,
                    (v) => setState(() => _selectedClass = v!)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm sinh viên...',
              hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFBDBDBD)),
              prefixIcon:
                  const Icon(Icons.search, size: 18, color: Color(0xFF9E9E9E)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF6B4FA0)),
              ),
            ),
            style: const TextStyle(fontSize: 13),
            onChanged: (v) => setState(() => _searchQuery = v),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String value,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                const TextStyle(fontSize: 11, color: Color(0xFF616161))),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
            ),
          ),
          isExpanded: true,
          style: const TextStyle(fontSize: 12, color: Color(0xFF212121)),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Color(0xFF6B4FA0), size: 18),
        ),
      ],
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white70, fontSize: 9, height: 1.2)),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nhận xét lớp',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF424242))),
          const SizedBox(height: 8),
          TextField(
            controller: _commentController,
            maxLines: 2,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildActionBtn('Lưu điểm danh', const Color(0xFF6B4FA0),
                    Icons.save_outlined),
                const SizedBox(width: 8),
                _buildActionBtn('Xuất Excel', const Color(0xFF2E7D32),
                    Icons.table_chart_outlined),
                const SizedBox(width: 8),
                _buildActionBtn('Đồng bộ', const Color(0xFFC62828),
                    Icons.sync_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String label, Color color, IconData icon) {
    return GestureDetector(
      onTap: () => _showSnack(label),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 15),
            const SizedBox(width: 5),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentList(List<Map<String, dynamic>> list) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              'Danh sách sinh viên (${list.length})',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121)),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          ...list.asMap().entries.map((entry) {
            final i = entry.key;
            final s = entry.value;
            return Column(
              children: [
                _buildStudentRow(i, s),
                if (i < list.length - 1)
                  const Divider(height: 1, indent: 16, color: Color(0xFFF0F0F0)),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStudentRow(int index, Map<String, dynamic> s) {
    final labels = ['Có mặt', 'Vắng phép', 'Vắng'];
    final colors = [
      const Color(0xFF4CAF50),
      const Color(0xFFE65100),
      const Color(0xFFC62828),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFFEDE7F6),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B4FA0)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['name'],
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                Text('${s['mssv']} · ${s['class']}',
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF9E9E9E))),
              ],
            ),
          ),
          // Status toggle
          GestureDetector(
            onTap: () {
              setState(() {
                s['status'] = (s['status'] + 1) % 3;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: colors[s['status'] as int].withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: colors[s['status'] as int].withOpacity(0.4)),
              ),
              child: Text(
                labels[s['status'] as int],
                style: TextStyle(
                  fontSize: 11,
                  color: colors[s['status'] as int],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // TAB 2 – QR CODE
  // ═══════════════════════════════════════════════════════════
  Widget _buildQrTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildQrForm()),
              const SizedBox(width: 12),
              Expanded(child: _buildQrDisplay()),
            ],
          ),
          const SizedBox(height: 16),
          _buildQrScannedList(),
        ],
      ),
    );
  }

  Widget _buildQrForm() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tạo mã QR điểm danh',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          const Text('Lớp học phần',
              style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0D8F0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('010110195604 - 14DHTH04',
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis),
                ),
                Icon(Icons.keyboard_arrow_down,
                    color: Color(0xFF6B4FA0), size: 18),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text('Thời gian hiệu lực (phút)',
              style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0D8F0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('15 phút',
                style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(height: 10),
          const Text('Buổi học',
              style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0D8F0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded( // Bọc Expanded tại đây
                  child: Text('Buổi sáng - 28/04/2026',
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis), 
                ),
                Icon(Icons.keyboard_arrow_down,
                    color: Color(0xFF6B4FA0), size: 18),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () {
              setState(() => _qrGenerated = true);
              _startQrTimer();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_2_rounded,
                      color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text('Tạo mã QR',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrDisplay() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(
                color: _qrGenerated
                    ? const Color(0xFF6B4FA0)
                    : const Color(0xFFE0D8F0),
                width: 2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFF9F7FF),
            ),
            child: _qrGenerated
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.qr_code_2_rounded,
                          size: 80, color: Color(0xFF6B4FA0)),
                      const SizedBox(height: 4),
                      Text(
                        'HUIT-14DHTH04-${DateTime.now().millisecondsSinceEpoch % 99999}',
                        style: const TextStyle(
                            fontSize: 9,
                            color: Color(0xFF9E9E9E)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_outlined,
                          size: 48, color: Color(0xFFD1C4E9)),
                      SizedBox(height: 8),
                      Text(
                        'Nhấn "Tạo mã QR"\nđể hiển thị',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFFBDBDBD)),
                      ),
                    ],
                  ),
          ),
          if (_qrGenerated) ...[
            const SizedBox(height: 14),
            Text(
              _formatQrTime(_qrSeconds),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B4FA0),
              ),
            ),
            const Text('Thời gian còn lại',
                style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _qrSeconds / 900,
                backgroundColor: const Color(0xFFE0D8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF6B4FA0)),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _startQrTimer(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF6B4FA0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '🔄  Làm mới QR',
                  style: TextStyle(
                      color: Color(0xFF6B4FA0),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQrScannedList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(14),
            child: Text(
              'Sinh viên đã điểm danh QR hôm nay',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          ..._qrScanned.asMap().entries.map((entry) {
            final i = entry.key;
            final s = entry.value;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: s['late']
                              ? const Color(0xFFFFEBEE)
                              : const Color(0xFFE8F5E9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          s['late']
                              ? Icons.access_time_rounded
                              : Icons.check_circle_outline,
                          color: s['late']
                              ? const Color(0xFFC62828)
                              : const Color(0xFF4CAF50),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s['name'],
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                            Text(s['mssv'],
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF9E9E9E))),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(s['time'],
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                          Container(
                            margin: const EdgeInsets.only(top: 3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: s['late']
                                  ? const Color(0xFFFFEBEE)
                                  : const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              s['late'] ? '! Trễ' : '✓ Đúng giờ',
                              style: TextStyle(
                                fontSize: 10,
                                color: s['late']
                                    ? const Color(0xFFC62828)
                                    : const Color(0xFF2E7D32),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (i < _qrScanned.length - 1)
                  const Divider(
                      height: 1, indent: 60, color: Color(0xFFF0F0F0)),
              ],
            );
          }),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // TAB 3 – KẾT QUẢ HỌC TẬP
  // ═══════════════════════════════════════════════════════════
  Widget _buildGradesTab() {
    final avg = _grades.fold<double>(
            0, (sum, g) => sum + _computeTotal(g)) /
        _grades.length;
    final passed = _grades.where((g) => _computeTotal(g) >= 5.0).length;
    final failed = _grades.where((g) => _computeTotal(g) < 5.0).length;
    final excellent =
        _grades.where((g) => _computeTotal(g) >= 9.0).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Filter
          _buildGradesFilter(),
          const SizedBox(height: 14),
          // Summary stats
          Row(
            children: [
              _buildGradeStat(avg.toStringAsFixed(1), 'Điểm TB',
                  const Color(0xFF6B4FA0)),
              const SizedBox(width: 8),
              _buildGradeStat('$passed', 'Đạt (≥5)',
                  const Color(0xFF4CAF50)),
              const SizedBox(width: 8),
              _buildGradeStat('$failed', 'Không đạt',
                  const Color(0xFFC62828)),
              const SizedBox(width: 8),
              _buildGradeStat('$excellent', 'Xuất sắc',
                  const Color(0xFFE65100)),
            ],
          ),
          const SizedBox(height: 14),
          // Grade table
          _buildGradeTable(),
        ],
      ),
    );
  }

  Widget _buildGradesFilter() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lớp học phần',
                    style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0D8F0)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('010110195604 - 14DHTH04',
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis),
                      ),
                      Icon(Icons.keyboard_arrow_down,
                          color: Color(0xFF6B4FA0), size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Tìm',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _showSnack('Xuất Excel'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF6B4FA0)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.table_chart_outlined,
                          color: Color(0xFF6B4FA0), size: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGradeStat(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(top: BorderSide(color: color, width: 3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color)),
            const SizedBox(height: 2),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10, color: Color(0xFF9E9E9E))),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF9F7FF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Row(
              children: [
                SizedBox(width: 24, child: Text('#', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF6B4FA0)))),
                SizedBox(width: 8),
                Expanded(flex: 3, child: Text('Họ tên', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF424242)))),
                SizedBox(width: 4),
                SizedBox(width: 36, child: Text('CC\n10%', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF424242)))),
                SizedBox(width: 4),
                SizedBox(width: 36, child: Text('GK\n30%', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF424242)))),
                SizedBox(width: 4),
                SizedBox(width: 36, child: Text('CK\n60%', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF424242)))),
                SizedBox(width: 4),
                SizedBox(width: 38, child: Text('Tổng', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF424242)))),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          ..._grades.asMap().entries.map((entry) {
            final i = entry.key;
            final g = entry.value;
            final total = _computeTotal(g);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        child: Text('${i + 1}',
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF9E9E9E))),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(g['name'],
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            Text(g['mssv'],
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF9E9E9E))),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(
                            '${g['cc']}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text('${g['gk']}',
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text('${g['ck']}',
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 38,
                        child: Column(
                          children: [
                            Text(
                              total.toStringAsFixed(1),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: _gradeLabelColor(total),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: _gradeLabelColor(total)
                                    .withOpacity(0.12),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _gradeLabel(total),
                                style: TextStyle(
                                  fontSize: 8,
                                  color: _gradeLabelColor(total),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < _grades.length - 1)
                  const Divider(
                      height: 1,
                      indent: 16,
                      color: Color(0xFFF0F0F0)),
              ],
            );
          }),
          // Actions
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildActionBtn(
                    'Lưu điểm', const Color(0xFF6B4FA0), Icons.save_outlined),
                const SizedBox(width: 8),
                _buildActionBtn('Khóa điểm', const Color(0xFF2E7D32),
                    Icons.lock_outline_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xFF6B4FA0),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}