import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});
  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  static const _kPrimary = Color(0xFF1A237E);
  static const _kAccent  = Color(0xFF283593);
  static const _kBg      = Color(0xFFF0F2FF);

  // ── Pending requests ─────────────────────────────────────
  final List<Map<String, dynamic>> _pendingRequests = [
    {'type': 'Đề xuất dạy bù',  'from': 'GV Nguyễn Văn A', 'class': '14DHTH04', 'date': '28/04/2026', 'icon': Icons.add_circle_outline_rounded,  'color': Color(0xFF4CAF50)},
    {'type': 'Đề xuất tạm ngừng', 'from': 'GV Trần Thị B',   'class': '16DHTH10', 'date': '30/04/2026', 'icon': Icons.pause_circle_outline_rounded, 'color': Color(0xFFE65100)},
    {'type': 'Đề xuất dạy thay', 'from': 'GV Lê Văn C',     'class': '14DHTH03', 'date': '02/05/2026', 'icon': Icons.swap_horiz_rounded,           'color': Color(0xFF1565C0)},
  ];

  // ── Recent activities ─────────────────────────────────────
  final List<Map<String, dynamic>> _activities = [
    {'icon': Icons.how_to_reg_outlined, 'color': Color(0xFF4CAF50), 'msg': 'GV Nguyễn Văn A vừa lưu điểm danh lớp 14DHTH04', 'time': '5 phút trước'},
    {'icon': Icons.grade_rounded,       'color': Color(0xFF1A237E), 'msg': 'Bảng điểm HK2 lớp 14DHTH03 đã được khóa',         'time': '1 giờ trước'},
    {'icon': Icons.person_add_outlined, 'color': Color(0xFF00695C), 'msg': '12 sinh viên mới đăng ký học kỳ 2 2025-2026',      'time': '2 giờ trước'},
    {'icon': Icons.warning_amber_outlined,'color':Color(0xFFE85D75),'msg': '5 sinh viên vắng quá 20% – 16DHTH10',              'time': '3 giờ trước'},
    {'icon': Icons.schedule_rounded,    'color': Color(0xFFE65100), 'msg': 'Thời khóa biểu tuần 19 đã được cập nhật',          'time': 'Hôm qua'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSystemStats(),
                  const SizedBox(height: 20),
                  _buildSemesterProgress(),
                  const SizedBox(height: 20),
                  _buildPendingRequests(),
                  const SizedBox(height: 20),
                  _buildQuickActions(),
                  const SizedBox(height: 20),
                  _buildActivityFeed(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D1B6E), _kPrimary, _kAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16, right: 16, bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3949AB), Color(0xFF5C6BC0)],
                  ),
                ),
                child: const Center(
                  child: Text('AD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Xin chào, Admin', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                    SizedBox(height: 2),
                    Text('Quản trị hệ thống · HUIT', style: TextStyle(color: Colors.white60, fontSize: 12)),
                  ],
                ),
              ),
              Stack(children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
                  child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                ),
                Positioned(right: 6, top: 6,
                  child: Container(width: 9, height: 9,
                    decoration: const BoxDecoration(color: Color(0xFFE85D75), shape: BoxShape.circle)),
                ),
              ]),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _hStat('HK2 2025-2026', 'Học kỳ'),
                _hDiv(),
                _hStat('3 chờ duyệt', 'Đề xuất'),
                _hDiv(),
                _hStat('Thứ 2, 28/04', 'Hôm nay'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hStat(String v, String l) => Column(children: [
    Text(v, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
    const SizedBox(height: 2),
    Text(l, style: const TextStyle(color: Colors.white60, fontSize: 11)),
  ]);
  Widget _hDiv() => Container(width: 1, height: 28, color: Colors.white24);

  // ── System stats grid ─────────────────────────────────────
  Widget _buildSystemStats() {
    final cards = [
      {'label': 'Sinh viên',   'value': '2,480', 'icon': Icons.school_outlined,       'color': const Color(0xFF1A237E)},
      {'label': 'Giảng viên',  'value': '148',   'icon': Icons.person_outlined,        'color': const Color(0xFF2E7D32)},
      {'label': 'Lớp học phần','value': '312',   'icon': Icons.class_outlined,         'color': const Color(0xFFE65100)},
      {'label': 'Phòng học',   'value': '86',    'icon': Icons.meeting_room_outlined,  'color': const Color(0xFFE85D75)},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.8,
      ),
      itemCount: cards.length,
      itemBuilder: (_, i) {
        final c = cards[i];
        final col = c['color'] as Color;
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: col.withOpacity(0.12), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Row(children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: col.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(c['icon'] as IconData, color: col, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(c['value'] as String, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: col)),
                Text(c['label'] as String, style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
              ],
            )),
          ]),
        );
      },
    );
  }

  // ── Semester progress ─────────────────────────────────────
  Widget _buildSemesterProgress() {
    final items = [
      {'label': 'Tiến độ giảng dạy toàn trường', 'pct': 0.72, 'color': const Color(0xFF1A237E)},
      {'label': 'Tỉ lệ điểm danh trung bình',     'pct': 0.89, 'color': const Color(0xFF4CAF50)},
      {'label': 'Tỉ lệ nộp bảng điểm đúng hạn',  'pct': 0.61, 'color': const Color(0xFFE65100)},
    ];
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Tiến độ học kỳ 2 – 2025/2026', Icons.trending_up_rounded),
          const SizedBox(height: 14),
          ...items.map((item) {
            final col = item['color'] as Color;
            final pct = item['pct'] as double;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(item['label'] as String, style: const TextStyle(fontSize: 13, color: Color(0xFF424242))),
                    Text('${(pct * 100).toInt()}%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: col)),
                  ]),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: pct,
                      backgroundColor: const Color(0xFFE8E8F0),
                      valueColor: AlwaysStoppedAnimation<Color>(col),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ── Pending requests ──────────────────────────────────────
  Widget _buildPendingRequests() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _sectionTitle('Đề xuất chờ duyệt', Icons.pending_actions_rounded),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: const Color(0xFFE85D75), borderRadius: BorderRadius.circular(20)),
              child: Text('${_pendingRequests.length}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ]),
          const SizedBox(height: 12),
          ..._pendingRequests.map((r) {
            final col = r['color'] as Color;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: col.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: col.withOpacity(0.2)),
              ),
              child: Row(children: [
                Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(color: col.withOpacity(0.12), shape: BoxShape.circle),
                  child: Icon(r['icon'] as IconData, color: col, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r['type'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  Text('${r['from']} · ${r['class']} · ${r['date']}',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                ])),
                const SizedBox(width: 8),
                _approveBtn('Duyệt', const Color(0xFF4CAF50)),
                const SizedBox(width: 6),
                _approveBtn('Từ chối', const Color(0xFFC62828)),
              ]),
            );
          }),
        ],
      ),
    );
  }

  Widget _approveBtn(String label, Color color) {
    return GestureDetector(
      onTap: () => _snack(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
      ),
    );
  }

  // ── Quick actions ─────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.person_add_outlined,       'label': 'Thêm\nsinh viên',  'color': const Color(0xFF1A237E)},
      {'icon': Icons.person_add_alt_1_outlined, 'label': 'Thêm\ngiảng viên', 'color': const Color(0xFF2E7D32)},
      {'icon': Icons.add_box_outlined,          'label': 'Thêm\nlớp học',    'color': const Color(0xFFE65100)},
      {'icon': Icons.campaign_outlined,         'label': 'Thông\nbáo',       'color': const Color(0xFFE85D75)},
      {'icon': Icons.calendar_month_outlined,   'label': 'Cập nhật\nlịch',   'color': const Color(0xFF00695C)},
      {'icon': Icons.backup_outlined,           'label': 'Sao lưu\nDL',      'color': const Color(0xFF5C6BC0)},
    ];
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Thao tác nhanh', Icons.flash_on_rounded),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.3,
            ),
            itemCount: actions.length,
            itemBuilder: (_, i) {
              final a = actions[i];
              final col = a['color'] as Color;
              return GestureDetector(
                onTap: () => _snack(a['label'] as String),
                child: Container(
                  decoration: BoxDecoration(
                    color: col.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: col.withOpacity(0.2)),
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(a['icon'] as IconData, color: col, size: 26),
                    const SizedBox(height: 6),
                    Text(a['label'] as String, textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: col, fontWeight: FontWeight.w600, height: 1.3)),
                  ]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ── Activity feed ─────────────────────────────────────────
  Widget _buildActivityFeed() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _sectionTitle('Hoạt động gần đây', Icons.history_rounded),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: const Text('Xem tất cả', style: TextStyle(fontSize: 12, color: _kPrimary)),
            ),
          ]),
          const SizedBox(height: 10),
          ..._activities.asMap().entries.map((e) {
            final a = e.value;
            final col = a['color'] as Color;
            return Column(children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(width: 34, height: 34,
                  decoration: BoxDecoration(color: col.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(a['icon'] as IconData, color: col, size: 17)),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(a['msg'] as String, style: const TextStyle(fontSize: 12, color: Color(0xFF424242))),
                  const SizedBox(height: 2),
                  Text(a['time'] as String, style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                ])),
              ]),
              if (e.key < _activities.length - 1)
                Padding(
                  padding: const EdgeInsets.only(left: 17, top: 4, bottom: 4),
                  child: Row(children: [
                    Container(width: 1, height: 16, color: const Color(0xFFE0E0E0)),
                  ]),
                ),
            ]);
          }),
        ],
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String t, IconData icon) {
    return Row(children: [
      Icon(icon, color: _kPrimary, size: 18),
      const SizedBox(width: 8),
      Text(t, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF212121))),
    ]);
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg.replaceAll('\n', ' ')),
      backgroundColor: _kPrimary,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ));
  }
}