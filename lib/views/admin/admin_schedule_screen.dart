import 'package:flutter/material.dart';

class AdminScheduleScreen extends StatefulWidget {
  const AdminScheduleScreen({super.key});
  @override
  State<AdminScheduleScreen> createState() => _AdminScheduleScreenState();
}

class _AdminScheduleScreenState extends State<AdminScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  static const _kPrimary = Color(0xFF1A237E);
  static const _kBg      = Color(0xFFF0F2FF);

  int _weekOffset = 0;

  // ── Class list (shared) ─────────────────────────────────
  final List<Map<String, dynamic>> _classes = [
    {'id': 'C01', 'subject': 'Kiến trúc máy tính (LT)',            'code': '010100228915', 'group': '16DHTH10', 'lecturer': 'Nguyễn Văn A', 'room': 'A401', 'day': 'Thứ 2', 'session': 'Tiết 1–3',   'type': 'theory',   'enrolled': 42, 'capacity': 50},
    {'id': 'C02', 'subject': 'TH Quản trị HTMM (TH)',              'code': '010110192400', 'group': '14DHTH40', 'lecturer': 'Nguyễn Văn A', 'room': 'A107', 'day': 'Thứ 2', 'session': 'Tiết 13–15', 'type': 'practice', 'enrolled': 28, 'capacity': 30},
    {'id': 'C03', 'subject': 'Quản trị hệ thống mạng (LT)',        'code': '010110197304', 'group': '14DHTH04', 'lecturer': 'Nguyễn Văn A', 'room': 'A202', 'day': 'Thứ 5', 'session': 'Tiết 7–9',   'type': 'theory',   'enrolled': 55, 'capacity': 60},
    {'id': 'C04', 'subject': 'Khai phá dữ liệu (LT)',              'code': '010110218801', 'group': '14DHTH01', 'lecturer': 'Trần Thị B',   'room': 'B305', 'day': 'Thứ 3', 'session': 'Tiết 1–3',   'type': 'theory',   'enrolled': 48, 'capacity': 50},
    {'id': 'C05', 'subject': 'Lập trình di động (LT)',             'code': '010110220501', 'group': '14DHTH05', 'lecturer': 'Lê Văn C',     'room': 'A301', 'day': 'Thứ 4', 'session': 'Tiết 7–9',   'type': 'theory',   'enrolled': 38, 'capacity': 40},
    {'id': 'C06', 'subject': 'Các vấn đề biên đại ATTT (LT)',     'code': '932210293002', 'group': '09CUIC02', 'lecturer': 'Nguyễn Văn A', 'room': 'DP01', 'day': 'Thứ 6', 'session': 'Tiết 2–6',   'type': 'online',   'enrolled': 22, 'capacity': 30},
  ];

  String _scheduleFilter = 'Tất cả';
  String _scheduleSearch = '';

  // ── Rooms ────────────────────────────────────────────────
  final List<Map<String, dynamic>> _rooms = [
    {'id': 'A101', 'name': 'A101 - Phòng lý thuyết', 'capacity': 60, 'status': 'available', 'facility': 'Máy chiếu, Điều hòa'},
    {'id': 'A107', 'name': 'A107 - Phòng máy BM',    'capacity': 30, 'status': 'occupied',  'facility': 'Máy tính, Điều hòa'},
    {'id': 'A202', 'name': 'A202 - Phòng lý thuyết', 'capacity': 60, 'status': 'occupied',  'facility': 'Máy chiếu, Điều hòa'},
    {'id': 'A301', 'name': 'A301 - Phòng lý thuyết', 'capacity': 50, 'status': 'available', 'facility': 'Máy chiếu'},
    {'id': 'A401', 'name': 'A401 - Phòng lý thuyết', 'capacity': 50, 'status': 'occupied',  'facility': 'Máy chiếu, Điều hòa'},
    {'id': 'B305', 'name': 'B305 - Hội trường',      'capacity': 100,'status': 'available', 'facility': 'Máy chiếu, Mic'},
    {'id': 'B407', 'name': 'B407 - Phòng lý thuyết', 'capacity': 50, 'status': 'maintenance','facility': 'Đang bảo trì'},
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  List<Map<String, dynamic>> get _filteredClasses {
    return _classes.where((c) {
      final matchType = _scheduleFilter == 'Tất cả' ||
          (_scheduleFilter == 'Lý thuyết' && c['type'] == 'theory') ||
          (_scheduleFilter == 'Thực hành' && c['type'] == 'practice') ||
          (_scheduleFilter == 'Trực tuyến' && c['type'] == 'online');
      final q = _scheduleSearch.toLowerCase();
      final matchSearch = q.isEmpty ||
          (c['subject'] as String).toLowerCase().contains(q) ||
          (c['lecturer'] as String).toLowerCase().contains(q) ||
          (c['group'] as String).toLowerCase().contains(q);
      return matchType && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(children: [
        _buildHeader(),
        _buildTabBar(),
        Expanded(child: TabBarView(controller: _tab, children: [
          _buildClassListTab(),
          _buildWeeklyViewTab(),
          _buildRoomsTab(),
        ])),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddClassSheet(),
        backgroundColor: _kPrimary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Thêm lịch', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF0D1B6E), _kPrimary], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 14, left: 16, right: 16, bottom: 16),
      child: Row(children: [
        const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 22),
        const SizedBox(width: 10),
        const Text('Quản lý lịch học', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
        const Spacer(),
        Text('${_classes.length} lớp', style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ]),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: _kPrimary,
      child: TabBar(
        controller: _tab,
        indicatorColor: Colors.white, indicatorWeight: 3,
        labelColor: Colors.white, unselectedLabelColor: Colors.white54,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const [Tab(text: 'Danh sách lớp'), Tab(text: 'Lịch theo tuần'), Tab(text: 'Phòng học')],
      ),
    );
  }

  // ══ TAB 1: CLASS LIST ═══════════════════════════════════
  Widget _buildClassListTab() {
    return Column(children: [
      _buildClassFilter(),
      Expanded(
        child: _filteredClasses.isEmpty
            ? const Center(child: Text('Không tìm thấy lớp học', style: TextStyle(color: Color(0xFF9E9E9E))))
            : ListView.separated(
                padding: const EdgeInsets.all(14),
                itemCount: _filteredClasses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => _buildClassCard(_filteredClasses[i]),
              ),
      ),
    ]);
  }

  Widget _buildClassFilter() {
    final filters = ['Tất cả', 'Lý thuyết', 'Thực hành', 'Trực tuyến'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Column(children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Tìm môn học, giảng viên, nhóm lớp...',
            hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFBDBDBD)),
            prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xFF9E9E9E)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE8E0F0))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE8E0F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: _kPrimary)),
          ),
          style: const TextStyle(fontSize: 13),
          onChanged: (v) => setState(() => _scheduleSearch = v),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: filters.map((f) {
            final sel = _scheduleFilter == f;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => _scheduleFilter = f),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: sel ? _kPrimary : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: sel ? _kPrimary : const Color(0xFFE0D8F0)),
                  ),
                  child: Text(f, style: TextStyle(fontSize: 12, color: sel ? Colors.white : const Color(0xFF424242), fontWeight: FontWeight.w500)),
                ),
              ),
            );
          }).toList()),
        ),
      ]),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> c) {
    Color col; Color bg;
    switch (c['type']) {
      case 'practice': col = const Color(0xFF5C6BC0); bg = const Color(0xFFE8EAF6); break;
      case 'online':   col = const Color(0xFFE65100); bg = const Color(0xFFFFF3E0); break;
      default:         col = const Color(0xFF2E7D32); bg = const Color(0xFFE8F5E9);
    }
    final enrolled = c['enrolled'] as int;
    final capacity = c['capacity'] as int;
    final ratio = enrolled / capacity;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: col, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      padding: const EdgeInsets.all(13),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
            child: Text(c['type'] == 'theory' ? 'LT' : c['type'] == 'practice' ? 'TH' : 'TT',
                style: TextStyle(fontSize: 10, color: col, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(c['subject'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF212121)))),
          PopupMenuButton<String>(
            onSelected: (v) => _handleClassAction(v, c),
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit',   child: Row(children: [Icon(Icons.edit_outlined, size: 16), SizedBox(width: 8), Text('Chỉnh sửa')])),
              const PopupMenuItem(value: 'room',   child: Row(children: [Icon(Icons.meeting_room_outlined, size: 16), SizedBox(width: 8), Text('Đổi phòng')])),
              const PopupMenuItem(value: 'cancel', child: Row(children: [Icon(Icons.cancel_outlined, size: 16, color: Colors.red), SizedBox(width: 8), Text('Huỷ lịch', style: TextStyle(color: Colors.red))])),
            ],
            icon: const Icon(Icons.more_vert, color: Color(0xFF9E9E9E), size: 20),
          ),
        ]),
        const SizedBox(height: 8),
        Wrap(spacing: 14, runSpacing: 4, children: [
          _infoChip(Icons.person_outlined, c['lecturer'] as String),
          _infoChip(Icons.group_outlined, c['group'] as String),
          _infoChip(Icons.location_on_outlined, c['room'] as String),
          _infoChip(Icons.access_time_outlined, '${c['day']} · ${c['session']}'),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Sĩ số: $enrolled/$capacity', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
              Text('${(ratio * 100).toInt()}%', style: TextStyle(fontSize: 11, color: col, fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: ratio, backgroundColor: const Color(0xFFE8E8F0), valueColor: AlwaysStoppedAnimation<Color>(col), minHeight: 5),
            ),
          ])),
        ]),
      ]),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 12, color: const Color(0xFF9E9E9E)),
      const SizedBox(width: 3),
      Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF616161))),
    ]);
  }

  // ══ TAB 2: WEEKLY VIEW ══════════════════════════════════
  Widget _buildWeeklyViewTab() {
    final days = ['T2\n28/04', 'T3\n29/04', 'T4\n30/04', 'T5\n01/05', 'T6\n02/05', 'T7\n03/05'];
    final classMap = {0: ['C01','C02'], 1: ['C04'], 2: ['C05'], 3: ['C03'], 4: ['C06'], 5: []};

    return Column(children: [
      // Week navigator
      Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(children: [
          IconButton(onPressed: () => setState(() => _weekOffset--),
              icon: const Icon(Icons.chevron_left, color: _kPrimary), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
          Expanded(child: Text('Tuần ${20 + _weekOffset}/04 – ${26 + _weekOffset}/04/2026',
              textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
          IconButton(onPressed: () => setState(() => _weekOffset++),
              icon: const Icon(Icons.chevron_right, color: _kPrimary), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
          GestureDetector(
            onTap: () => setState(() => _weekOffset = 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: _kPrimary, borderRadius: BorderRadius.circular(7)),
              child: const Text('Hôm nay', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
            ),
          ),
        ]),
      ),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: List.generate(6, (dayIdx) {
              final dayClasses = (classMap[dayIdx] ?? [])
                  .map((id) => _classes.firstWhere((c) => c['id'] == id))
                  .toList();
              final isToday = dayIdx == 0;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12),
                  border: isToday ? Border.all(color: _kPrimary, width: 1.5) : null,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
                ),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isToday ? _kPrimary.withOpacity(0.07) : const Color(0xFFF9F9FF),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Row(children: [
                      Text(days[dayIdx].replaceAll('\n', '  '), style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13,
                          color: isToday ? _kPrimary : const Color(0xFF424242))),
                      if (isToday) ...[
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(color: _kPrimary, borderRadius: BorderRadius.circular(6)),
                          child: const Text('Hôm nay', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600))),
                      ],
                      const Spacer(),
                      Text('${dayClasses.length} lớp', style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
                    ]),
                  ),
                  if (dayClasses.isEmpty)
                    Padding(padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text('Không có lịch', style: TextStyle(fontSize: 13, color: Colors.grey[400], fontStyle: FontStyle.italic)))
                  else
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: dayClasses.map((c) {
                        Color col = c['type'] == 'practice' ? const Color(0xFF5C6BC0)
                            : c['type'] == 'online' ? const Color(0xFFE65100) : const Color(0xFF2E7D32);
                        Color bg  = c['type'] == 'practice' ? const Color(0xFFE8EAF6)
                            : c['type'] == 'online' ? const Color(0xFFFFF3E0) : const Color(0xFFE8F5E9);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 7),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                          decoration: BoxDecoration(
                            color: bg, borderRadius: BorderRadius.circular(8),
                            border: Border(left: BorderSide(color: col, width: 3)),
                          ),
                          child: Row(children: [
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(c['subject'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: col)),
                              Text('${c['lecturer']} · ${c['group']} · ${c['room']}',
                                  style: TextStyle(fontSize: 11, color: col.withOpacity(0.75))),
                            ])),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(color: col.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                              child: Text(c['session'] as String, style: TextStyle(fontSize: 10, color: col, fontWeight: FontWeight.w600)),
                            ),
                          ]),
                        );
                      }).toList()),
                    ),
                ]),
              );
            }),
          ),
        ),
      ),
    ]);
  }

  // ══ TAB 3: ROOMS ════════════════════════════════════════
  Widget _buildRoomsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        // Summary chips
        Row(children: [
          _roomSummaryChip('Trống', _rooms.where((r) => r['status'] == 'available').length.toString(), const Color(0xFF4CAF50)),
          const SizedBox(width: 8),
          _roomSummaryChip('Đang dùng', _rooms.where((r) => r['status'] == 'occupied').length.toString(), _kPrimary),
          const SizedBox(width: 8),
          _roomSummaryChip('Bảo trì', _rooms.where((r) => r['status'] == 'maintenance').length.toString(), const Color(0xFFE85D75)),
        ]),
        const SizedBox(height: 14),
        ..._rooms.map((r) => Padding(padding: const EdgeInsets.only(bottom: 10), child: _buildRoomCard(r))),
      ]),
    );
  }

  Widget _roomSummaryChip(String label, String count, Color col) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: col.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Text(count, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: col)),
          Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
        ]),
      ),
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> r) {
    Color statusColor;
    String statusLabel;
    IconData statusIcon;
    switch (r['status']) {
      case 'occupied':    statusColor = _kPrimary;                  statusLabel = 'Đang dùng'; statusIcon = Icons.lock_outline_rounded; break;
      case 'maintenance': statusColor = const Color(0xFFE85D75);    statusLabel = 'Bảo trì';   statusIcon = Icons.build_outlined; break;
      default:            statusColor = const Color(0xFF4CAF50);    statusLabel = 'Trống';      statusIcon = Icons.check_circle_outline;
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(Icons.meeting_room_outlined, color: statusColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(r['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 3),
          Text('Sức chứa: ${r['capacity']}  ·  ${r['facility']}',
              style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: statusColor.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(statusIcon, size: 12, color: statusColor),
            const SizedBox(width: 4),
            Text(statusLabel, style: TextStyle(fontSize: 11, color: statusColor, fontWeight: FontWeight.w600)),
          ]),
        ),
      ]),
    );
  }

  // ── Handlers ─────────────────────────────────────────────
  void _handleClassAction(String action, Map<String, dynamic> c) {
    if (action == 'edit')   _showEditClassSheet(c);
    if (action == 'room')   _showChangeRoomSheet(c);
    if (action == 'cancel') _showCancelConfirm(c);
  }

  void _showAddClassSheet() => _showClassFormSheet(null);
  void _showEditClassSheet(Map<String, dynamic> c) => _showClassFormSheet(c);

  void _showClassFormSheet(Map<String, dynamic>? existing) {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => _ClassFormSheet(existing: existing),
    );
  }

  void _showChangeRoomSheet(Map<String, dynamic> c) {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => _ChangeRoomSheet(rooms: _rooms, currentClass: c),
    );
  }

  void _showCancelConfirm(Map<String, dynamic> c) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Huỷ lịch học', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      content: Text('Xác nhận huỷ lịch "${c['subject']}" - ${c['group']}?',
          style: const TextStyle(fontSize: 14, color: Color(0xFF616161))),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Không', style: TextStyle(color: Color(0xFF616161)))),
        ElevatedButton(
          onPressed: () => Navigator.pop(ctx),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC62828), foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          child: const Text('Huỷ lịch'),
        ),
      ],
    ));
  }
}

// ════ CLASS FORM SHEET ═══════════════════════════════════════
class _ClassFormSheet extends StatelessWidget {
  final Map<String, dynamic>? existing;
  const _ClassFormSheet({this.existing});

  @override
  Widget build(BuildContext context) {
    final isEdit = existing != null;
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(children: [
        _handle(),
        _header(isEdit ? 'Chỉnh sửa lịch học' : 'Thêm lịch học mới', isEdit ? Icons.edit_outlined : Icons.add_box_outlined),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
          _field('Môn học', existing?['subject'] ?? 'Nhập tên môn học'),
          const SizedBox(height: 12),
          _field('Mã học phần', existing?['code'] ?? 'VD: 010110218801'),
          const SizedBox(height: 12),
          _field('Nhóm lớp', existing?['group'] ?? 'VD: 14DHTH04'),
          const SizedBox(height: 12),
          _field('Giảng viên', existing?['lecturer'] ?? 'Chọn giảng viên'),
          const SizedBox(height: 12),
          _field('Phòng học', existing?['room'] ?? 'Chọn phòng học'),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _field('Thứ', existing?['day'] ?? 'Thứ 2')),
            const SizedBox(width: 12),
            Expanded(child: _field('Tiết học', existing?['session'] ?? 'Tiết 1–3')),
          ]),
          const SizedBox(height: 12),
          _field('Loại lớp', 'Lý thuyết'),
          const SizedBox(height: 20),
          _submitBtn(context, isEdit ? 'Lưu thay đổi' : 'Tạo lịch học'),
        ]))),
      ]),
    );
  }

  Widget _field(String label, String hint) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF616161))),
    const SizedBox(height: 4),
    Container(
      width: double.infinity, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE0D8F0)), borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(child: Text(hint, style: const TextStyle(fontSize: 13, color: Color(0xFF424242)))),
        const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1A237E), size: 18),
      ]),
    ),
  ]);

  Widget _submitBtn(BuildContext ctx, String label) => GestureDetector(
    onTap: () => Navigator.pop(ctx),
    child: Container(
      width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF0D1B6E), Color(0xFF1A237E)]), borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14))),
    ),
  );
}

// ════ CHANGE ROOM SHEET ══════════════════════════════════════
class _ChangeRoomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> rooms;
  final Map<String, dynamic> currentClass;
  const _ChangeRoomSheet({required this.rooms, required this.currentClass});

  @override
  Widget build(BuildContext context) {
    final available = rooms.where((r) => r['status'] == 'available').toList();
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(children: [
        _handle(),
        _header('Đổi phòng học', Icons.meeting_room_outlined),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text('Phòng hiện tại: ${currentClass['room']}  ·  ${currentClass['session']}',
              style: const TextStyle(fontSize: 13, color: Color(0xFF9E9E9E)))),
        const Divider(height: 1, color: Color(0xFFF0F0F0)),
        Expanded(child: ListView(padding: const EdgeInsets.all(14), children: [
          const Text('Phòng đang trống:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF424242))),
          const SizedBox(height: 10),
          ...available.map((r) => GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.4)),
              ),
              child: Row(children: [
                const Icon(Icons.meeting_room_outlined, color: Color(0xFF4CAF50), size: 20),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  Text('Sức chứa: ${r['capacity']}  ·  ${r['facility']}', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                ])),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF4CAF50)),
              ]),
            ),
          )),
        ])),
      ]),
    );
  }
}

// ── Shared helpers ──────────────────────────────────────────
Widget _handle() => Center(child: Container(
  margin: const EdgeInsets.only(top: 12, bottom: 8),
  width: 40, height: 4,
  decoration: BoxDecoration(color: const Color(0xFFE0D8F0), borderRadius: BorderRadius.circular(2)),
));

Widget _header(String title, IconData icon) => Padding(
  padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
  child: Row(children: [
    Container(width: 40, height: 40,
      decoration: BoxDecoration(color: const Color(0xFF1A237E).withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(icon, color: const Color(0xFF1A237E), size: 20)),
    const SizedBox(width: 12),
    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF212121))),
  ]),
);