import 'package:flutter/material.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});
  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  static const _kPrimary = Color(0xFF1A237E);
  static const _kBg      = Color(0xFFF0F2FF);
  String _selectedSemester = 'HK2 - 2025-2026';
  String _selectedDept     = 'Tất cả khoa';

  @override
  void initState() { super.initState(); _tab = TabController(length: 4, vsync: this); }
  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(children: [
        _buildHeader(),
        _buildFilter(),
        _buildTabBar(),
        Expanded(child: TabBarView(controller: _tab, children: [
          _buildAttendanceTab(),
          _buildGradesTab(),
          _buildTeachingTab(),
          _buildRequestsTab(),
        ])),
      ]),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF0D1B6E), _kPrimary], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 14, left: 16, right: 16, bottom: 14),
      child: Row(children: [
        const Icon(Icons.bar_chart_rounded, color: Colors.white, size: 22),
        const SizedBox(width: 10),
        const Text('Báo cáo & Thống kê', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
        const Spacer(),
        GestureDetector(
          onTap: () => _snack('Xuất báo cáo tổng hợp'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
            child: const Row(children: [
              Icon(Icons.download_outlined, color: Colors.white, size: 16),
              SizedBox(width: 5),
              Text('Xuất', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _buildFilter() {
    final semesters = ['HK2 - 2025-2026', 'HK1 - 2025-2026', 'HK2 - 2024-2025'];
    final depts     = ['Tất cả khoa', 'Khoa CNTT', 'Khoa HTTT', 'Khoa KHMT'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(children: [
        Expanded(child: _dropdownField('Học kỳ', semesters, _selectedSemester, (v) => setState(() => _selectedSemester = v!))),
        const SizedBox(width: 10),
        Expanded(child: _dropdownField('Khoa', depts, _selectedDept, (v) => setState(() => _selectedDept = v!))),
      ]),
    );
  }

  Widget _dropdownField(String label, List<String> items, String value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label, labelStyle: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0D8F0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0D8F0))),
      ),
      isExpanded: true, style: const TextStyle(fontSize: 12, color: Color(0xFF212121)),
      icon: const Icon(Icons.keyboard_arrow_down, color: _kPrimary, size: 18),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: _kPrimary,
      child: TabBar(
        controller: _tab,
        isScrollable: true,
        indicatorColor: Colors.white, indicatorWeight: 3,
        labelColor: Colors.white, unselectedLabelColor: Colors.white54,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const [Tab(text: 'Điểm danh'), Tab(text: 'Kết quả HT'), Tab(text: 'Giảng dạy'), Tab(text: 'Đề xuất')],
      ),
    );
  }

  // ══ TAB 1: ATTENDANCE REPORT ════════════════════════════
  Widget _buildAttendanceTab() {
    final classStats = [
      {'class': '14DHTH04', 'subject': 'QTHTMM', 'lecturer': 'Nguyễn Văn A', 'present': 58, 'total': 60, 'absent': 2, 'excused': 0},
      {'class': '16DHTH10', 'subject': 'KTMT',   'lecturer': 'Nguyễn Văn A', 'present': 40, 'total': 42, 'absent': 1, 'excused': 1},
      {'class': '14DHTH40', 'subject': 'TH QTHTMM','lecturer':'Nguyễn Văn A','present': 26, 'total': 28, 'absent': 2, 'excused': 0},
      {'class': '14DHTH01', 'subject': 'KPD',    'lecturer': 'Trần Thị B',   'present': 44, 'total': 48, 'absent': 3, 'excused': 1},
      {'class': '14DHTH05', 'subject': 'LTDĐ',   'lecturer': 'Lê Văn C',     'present': 35, 'total': 38, 'absent': 2, 'excused': 1},
    ];

    final warningStudents = [
      {'name': 'Cao Đức Mạnh', 'mssv': '14DHTH12007', 'absent': 6, 'total': 15, 'pct': 40},
      {'name': 'Phan Trọng Nghiêm', 'mssv': '12DHBM05001', 'absent': 5, 'total': 15, 'pct': 33},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        // Summary
        Row(children: [
          _summaryCard('96.2%',  'Tỉ lệ đi học TB', const Color(0xFF4CAF50)),
          const SizedBox(width: 8),
          _summaryCard('5',      'Sinh viên cảnh báo', const Color(0xFFE85D75)),
          const SizedBox(width: 8),
          _summaryCard('312',    'Buổi đã điểm danh', _kPrimary),
        ]),
        const SizedBox(height: 14),
        // By class
        _sectionCard('Tỉ lệ điểm danh theo lớp học phần', Icons.class_outlined, Column(children: [
          ...classStats.map((s) {
            final pct = (s['present'] as int) / (s['total'] as int);
            final col = pct >= 0.95 ? const Color(0xFF4CAF50) : pct >= 0.85 ? const Color(0xFFE65100) : const Color(0xFFC62828);
            return Padding(padding: const EdgeInsets.only(bottom: 12), child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${s['class']} – ${s['subject']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  Text(s['lecturer'] as String, style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('${(pct * 100).toStringAsFixed(1)}%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: col)),
                  Text('${s['present']}/${s['total']} SV', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                ]),
              ]),
              const SizedBox(height: 6),
              ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(
                value: pct, backgroundColor: const Color(0xFFE8E8F0),
                valueColor: AlwaysStoppedAnimation<Color>(col), minHeight: 7)),
            ]));
          }),
        ])),
        const SizedBox(height: 12),
        // Warning students
        _sectionCard('Sinh viên vắng quá 20%', Icons.warning_amber_outlined, Column(children: [
          ...warningStudents.map((s) => Container(
            margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              const Icon(Icons.warning_amber_rounded, color: Color(0xFFC62828), size: 20),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                Text('${s['mssv']}  ·  Vắng ${s['absent']}/${s['total']} buổi', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
              ])),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFC62828), borderRadius: BorderRadius.circular(20)),
                child: Text('${s['pct']}%', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ]),
          )),
        ])),
      ]),
    );
  }

  // ══ TAB 2: GRADES REPORT ════════════════════════════════
  Widget _buildGradesTab() {
    final distribution = [
      {'label': 'Xuất sắc (≥9.0)', 'count': 215, 'pct': 0.18, 'color': const Color(0xFF1A237E)},
      {'label': 'Giỏi (8.0–8.9)',   'count': 380, 'pct': 0.32, 'color': const Color(0xFF4CAF50)},
      {'label': 'Khá (7.0–7.9)',    'count': 290, 'pct': 0.24, 'color': const Color(0xFF2196F3)},
      {'label': 'TB (5.0–6.9)',     'count': 215, 'pct': 0.18, 'color': const Color(0xFFE65100)},
      {'label': 'Không đạt (<5)',   'count': 95,  'pct': 0.08, 'color': const Color(0xFFC62828)},
    ];

    final topClasses = [
      {'class': '14DHTH04', 'subject': 'QTHTMM', 'avg': 8.2, 'passed': 98},
      {'class': '16DHTH10', 'subject': 'KTMT',   'avg': 7.6, 'passed': 95},
      {'class': '14DHTH01', 'subject': 'KPD',    'avg': 7.1, 'passed': 91},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        Row(children: [
          _summaryCard('7.4', 'Điểm TB toàn trường', _kPrimary),
          const SizedBox(width: 8),
          _summaryCard('92%', 'Tỉ lệ đạt', const Color(0xFF4CAF50)),
          const SizedBox(width: 8),
          _summaryCard('1195','Tổng sinh viên', const Color(0xFFE65100)),
        ]),
        const SizedBox(height: 14),
        _sectionCard('Phân bố kết quả học tập', Icons.bar_chart_rounded, Column(children: [
          ...distribution.map((d) {
            final col = d['color'] as Color;
            return Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [
              Container(width: 12, height: 12, decoration: BoxDecoration(color: col, borderRadius: BorderRadius.circular(3))),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(d['label'] as String, style: const TextStyle(fontSize: 12, color: Color(0xFF424242))),
                  Text('${d['count']} SV  (${((d['pct'] as double)*100).toInt()}%)',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: col)),
                ]),
                const SizedBox(height: 4),
                ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(
                  value: d['pct'] as double, backgroundColor: const Color(0xFFE8E8F0),
                  valueColor: AlwaysStoppedAnimation<Color>(col), minHeight: 7)),
              ])),
            ]));
          }),
        ])),
        const SizedBox(height: 12),
        _sectionCard('Lớp có điểm TB cao nhất', Icons.emoji_events_outlined, Column(children: [
          ...topClasses.asMap().entries.map((e) {
            final idx = e.key; final c = e.value;
            final medals = ['🥇', '🥈', '🥉'];
            return Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [
              Text(medals[idx], style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${c['class']} – ${c['subject']}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                Text('Đạt: ${c['passed']}%', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
              ])),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: _kPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Text('ĐTB: ${c['avg']}', style: const TextStyle(fontSize: 13, color: _kPrimary, fontWeight: FontWeight.bold)),
              ),
            ]));
          }),
        ])),
      ]),
    );
  }

  // ══ TAB 3: TEACHING STATS ═══════════════════════════════
  Widget _buildTeachingTab() {
    final lecturers = [
      {'name': 'Nguyễn Văn A', 'code': 'GV001', 'planned': 120, 'done': 87,  'extra': 12, 'exam': 3},
      {'name': 'Trần Thị B',   'code': 'GV002', 'planned': 90,  'done': 90,  'extra': 0,  'exam': 2},
      {'name': 'Lê Văn C',     'code': 'GV003', 'planned': 75,  'done': 60,  'extra': 0,  'exam': 1},
      {'name': 'Phạm Thị D',   'code': 'GV004', 'planned': 105, 'done': 105, 'extra': 15, 'exam': 4},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        Row(children: [
          _summaryCard('342/450', 'Tiết đã dạy / KH', _kPrimary),
          const SizedBox(width: 8),
          _summaryCard('27',     'Tiết vượt KH',     const Color(0xFF4CAF50)),
          const SizedBox(width: 8),
          _summaryCard('10',     'Buổi coi thi',     const Color(0xFFE65100)),
        ]),
        const SizedBox(height: 14),
        _sectionCard('Thống kê giảng viên', Icons.person_outlined, Column(children: [
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(color: _kPrimary.withOpacity(0.06), borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Expanded(flex: 3, child: Text('Giảng viên', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)))),
              SizedBox(width: 50, child: Text('KH',  textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)))),
              SizedBox(width: 50, child: Text('Thực', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)))),
              SizedBox(width: 50, child: Text('Vượt', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)))),
            ]),
          ),
          const SizedBox(height: 8),
          ...lecturers.asMap().entries.map((e) {
            final idx = e.key; final l = e.value;
            final pct  = (l['done'] as int) / (l['planned'] as int);
            final col  = pct >= 1.0 ? const Color(0xFF4CAF50) : pct >= 0.7 ? _kPrimary : const Color(0xFFE65100);
            return Container(
              margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: idx.isEven ? const Color(0xFFF9F9FF) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(children: [
                Row(children: [
                  Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(l['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                    Text(l['code'] as String, style: const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
                  ])),
                  SizedBox(width: 50, child: Text('${l['planned']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))),
                  SizedBox(width: 50, child: Text('${l['done']}', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: col))),
                  SizedBox(width: 50, child: Text(
                    (l['extra'] as int) > 0 ? '+${l['extra']}' : '0',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: (l['extra'] as int) > 0 ? const Color(0xFF4CAF50) : const Color(0xFF9E9E9E)),
                  )),
                ]),
                const SizedBox(height: 6),
                ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(
                  value: pct.clamp(0.0, 1.0),
                  backgroundColor: const Color(0xFFE8E8F0),
                  valueColor: AlwaysStoppedAnimation<Color>(col), minHeight: 5)),
              ]),
            );
          }),
        ])),
      ]),
    );
  }

  // ══ TAB 4: REQUESTS REPORT ══════════════════════════════
  Widget _buildRequestsTab() {
    final byStatus = [
      {'label': 'Đã duyệt',   'count': 18, 'color': const Color(0xFF4CAF50)},
      {'label': 'Chờ duyệt',  'count': 3,  'color': const Color(0xFFE65100)},
      {'label': 'Từ chối',    'count': 5,  'color': const Color(0xFFC62828)},
    ];
    final byType = [
      {'label': 'Tạm ngừng lịch dạy', 'count': 12, 'approved': 8,  'color': const Color(0xFFF5A623)},
      {'label': 'Dạy bù',             'count': 9,  'approved': 8,  'color': const Color(0xFF4CAF50)},
      {'label': 'Dạy thay',           'count': 5,  'approved': 2,  'color': const Color(0xFF1565C0)},
    ];
    final recentDecisions = [
      {'type': 'Đề xuất dạy bù',  'from': 'GV Nguyễn Văn A', 'status': 'approved', 'date': '25/04/2026'},
      {'type': 'Tạm ngừng',       'from': 'GV Trần Thị B',   'status': 'rejected', 'date': '24/04/2026'},
      {'type': 'Đề xuất dạy bù',  'from': 'GV Lê Văn C',     'status': 'approved', 'date': '22/04/2026'},
      {'type': 'Tạm ngừng',       'from': 'GV Phạm Thị D',   'status': 'pending',  'date': '28/04/2026'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        Row(children: byStatus.map((s) {
          final col = s['color'] as Color;
          return Expanded(child: Padding(padding: const EdgeInsets.only(right: 8), child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [col, col.withOpacity(0.8)]), borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              Text('${s['count']}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(s['label'] as String, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.white70)),
            ]),
          )));
        }).toList()),
        const SizedBox(height: 14),
        _sectionCard('Theo loại đề xuất', Icons.category_outlined, Column(children: [
          ...byType.map((t) {
            final col = t['color'] as Color;
            final pct = (t['approved'] as int) / (t['count'] as int);
            return Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(color: col, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(t['label'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  Text('${t['approved']}/${t['count']} duyệt', style: TextStyle(fontSize: 12, color: col, fontWeight: FontWeight.w600)),
                ]),
                const SizedBox(height: 5),
                ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(
                  value: pct, backgroundColor: const Color(0xFFE8E8F0),
                  valueColor: AlwaysStoppedAnimation<Color>(col), minHeight: 7)),
              ])),
            ]));
          }),
        ])),
        const SizedBox(height: 12),
        _sectionCard('Lịch sử quyết định', Icons.history_rounded, Column(children: [
          ...recentDecisions.map((d) {
            Color col; String label; IconData icon;
            switch (d['status']) {
              case 'approved': col = const Color(0xFF4CAF50); label = 'Đã duyệt'; icon = Icons.check_circle_outline; break;
              case 'rejected': col = const Color(0xFFC62828); label = 'Từ chối';  icon = Icons.cancel_outlined; break;
              default:         col = const Color(0xFFE65100); label = 'Chờ duyệt'; icon = Icons.pending_outlined;
            }
            return Container(
              margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFF9F9FF), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFEEEEEE))),
              child: Row(children: [
                Icon(icon, color: col, size: 20),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(d['type'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  Text('${d['from']}  ·  ${d['date']}', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: col.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: Text(label, style: TextStyle(fontSize: 11, color: col, fontWeight: FontWeight.w600)),
                ),
              ]),
            );
          }),
        ])),
      ]),
    );
  }

  // ── Shared helpers ────────────────────────────────────────
  Widget _summaryCard(String value, String label, Color color) {
    return Expanded(child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),
          border: Border(top: BorderSide(color: color, width: 3)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))]),
      child: Column(children: [
        Text(value, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E), height: 1.3)),
      ]),
    ));
  }

  Widget _sectionCard(String title, IconData icon, Widget content) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, color: _kPrimary, size: 18),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF212121))),
        ]),
        const SizedBox(height: 14),
        content,
      ]),
    );
  }

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: _kPrimary, behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 2)),
  );
}