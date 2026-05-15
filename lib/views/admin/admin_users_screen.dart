import 'package:flutter/material.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});
  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  static const _kPrimary = Color(0xFF1A237E);
  static const _kBg      = Color(0xFFF0F2FF);

  String _studentSearch  = '';
  String _lecturerSearch = '';
  String _studentFilter  = 'Tất cả';
  String _lecturerFilter = 'Tất cả';

  final List<Map<String, dynamic>> _students = [
    {'id':'SV01','name':'Kiều Tấn Phát',    'mssv':'2001230773','class':'14DHTH13','major':'CNTT','status':'active', 'gpa':3.6,'email':'ktp@sinh.huit.edu.vn','phone':'0901111111'},
    {'id':'SV02','name':'Âu Gia Quốc',      'mssv':'2001230775','class':'14DHTH12','major':'CNTT','status':'active', 'gpa':3.2,'email':'agq@sinh.huit.edu.vn','phone':'0901222222'},
    {'id':'SV03','name':'Cao Đức Mạnh',     'mssv':'2001230777','class':'14DHTH12','major':'CNTT','status':'warning','gpa':2.1,'email':'cdm@sinh.huit.edu.vn','phone':'0901333333'},
    {'id':'SV04','name':'Nguyễn Thị Mai',   'mssv':'2001230778','class':'14DHTH13','major':'CNTT','status':'active', 'gpa':3.8,'email':'ntm@sinh.huit.edu.vn','phone':'0901444444'},
    {'id':'SV05','name':'Phan Trọng Nghiêm','mssv':'2001230779','class':'12DHBM05','major':'KHMT','status':'locked', 'gpa':1.4,'email':'ptn@sinh.huit.edu.vn','phone':'0901555555'},
    {'id':'SV06','name':'Trần Minh Khoa',   'mssv':'2001230780','class':'14DHTH13','major':'CNTT','status':'active', 'gpa':3.4,'email':'tmk@sinh.huit.edu.vn','phone':'0901666666'},
    {'id':'SV07','name':'Lê Thu Hà',        'mssv':'2001230781','class':'14DHTH14','major':'HTTT','status':'active', 'gpa':3.7,'email':'lth@sinh.huit.edu.vn','phone':'0901777777'},
  ];

  final List<Map<String, dynamic>> _lecturers = [
    {'id':'GV01','name':'Nguyễn Văn A','code':'GV001','department':'CNTT','degree':'Tiến sĩ', 'rank':'Giảng viên chính','classes':5,'status':'active', 'email':'gv001@huit.edu.vn','phone':'0901234567'},
    {'id':'GV02','name':'Trần Thị B',  'code':'GV002','department':'CNTT','degree':'Thạc sĩ', 'rank':'Giảng viên',      'classes':4,'status':'active', 'email':'gv002@huit.edu.vn','phone':'0902234567'},
    {'id':'GV03','name':'Lê Văn C',    'code':'GV003','department':'HTTT','degree':'Tiến sĩ', 'rank':'Giảng viên chính','classes':3,'status':'active', 'email':'gv003@huit.edu.vn','phone':'0903234567'},
    {'id':'GV04','name':'Phạm Thị D',  'code':'GV004','department':'KHMT','degree':'Thạc sĩ', 'rank':'Giảng viên',      'classes':6,'status':'active', 'email':'gv004@huit.edu.vn','phone':'0904234567'},
    {'id':'GV05','name':'Hoàng Văn E', 'code':'GV005','department':'CNTT','degree':'Tiến sĩ', 'rank':'Phó giáo sư',    'classes':2,'status':'inactive','email':'gv005@huit.edu.vn','phone':'0905234567'},
  ];

  @override
  void initState() { super.initState(); _tab = TabController(length: 2, vsync: this); }
  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  List<Map<String, dynamic>> get _filteredStudents => _students.where((s) {
    final q = _studentSearch.toLowerCase();
    final matchSearch = q.isEmpty || (s['name'] as String).toLowerCase().contains(q) || (s['mssv'] as String).contains(q);
    final matchFilter = _studentFilter == 'Tất cả' ||
        (_studentFilter == 'Hoạt động' && s['status'] == 'active') ||
        (_studentFilter == 'Cảnh báo'  && s['status'] == 'warning') ||
        (_studentFilter == 'Khoá'      && s['status'] == 'locked');
    return matchSearch && matchFilter;
  }).toList();

  List<Map<String, dynamic>> get _filteredLecturers => _lecturers.where((l) {
    final q = _lecturerSearch.toLowerCase();
    final matchSearch = q.isEmpty || (l['name'] as String).toLowerCase().contains(q) || (l['code'] as String).toLowerCase().contains(q);
    final matchFilter = _lecturerFilter == 'Tất cả' ||
        (_lecturerFilter == 'Hoạt động' && l['status'] == 'active') ||
        (_lecturerFilter == 'Nghỉ'      && l['status'] == 'inactive');
    return matchSearch && matchFilter;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(children: [
        _buildHeader(),
        _buildTabBar(),
        Expanded(child: TabBarView(controller: _tab, children: [
          _buildStudentsTab(),
          _buildLecturersTab(),
        ])),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showUserFormSheet(null, _tab.index == 0 ? 'student' : 'lecturer'),
        backgroundColor: _kPrimary,
        icon: const Icon(Icons.person_add_outlined, color: Colors.white),
        label: AnimatedBuilder(
          animation: _tab,
          builder: (_, __) => Text(
            _tab.index == 0 ? 'Thêm SV' : 'Thêm GV',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF0D1B6E), _kPrimary], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 14, left: 16, right: 16, bottom: 16),
      child: Column(children: [
        const Row(children: [
          Icon(Icons.manage_accounts_rounded, color: Colors.white, size: 22),
          SizedBox(width: 10),
          Text('Quản lý người dùng', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          _hCard('${_students.length}', 'Sinh viên', Icons.school_outlined),
          const SizedBox(width: 10),
          _hCard('${_lecturers.length}', 'Giảng viên', Icons.person_outlined),
          const SizedBox(width: 10),
          _hCard(
            '${_students.where((s) => s['status'] == 'warning' || s['status'] == 'locked').length}',
            'Cần xử lý', Icons.warning_amber_outlined,
          ),
        ]),
      ]),
    );
  }

  Widget _hCard(String value, String label, IconData icon) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label,  style: const TextStyle(color: Colors.white70, fontSize: 10)),
        ]),
      ]),
    ),
  );

  Widget _buildTabBar() => Container(
    color: _kPrimary,
    child: TabBar(
      controller: _tab,
      indicatorColor: Colors.white, indicatorWeight: 3,
      labelColor: Colors.white, unselectedLabelColor: Colors.white54,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      tabs: [
        Tab(text: 'Sinh viên (${_students.length})'),
        Tab(text: 'Giảng viên (${_lecturers.length})'),
      ],
    ),
  );

  // ══ TAB 1: STUDENTS ════════════════════════════════════
  Widget _buildStudentsTab() {
    final filters = ['Tất cả', 'Hoạt động', 'Cảnh báo', 'Khoá'];
    return Column(children: [
      _searchBar('Tìm sinh viên, MSSV...', (v) => setState(() => _studentSearch = v)),
      _filterRow(filters, _studentFilter, (f) => setState(() => _studentFilter = f)),
      Expanded(
        child: _filteredStudents.isEmpty
            ? const Center(child: Text('Không tìm thấy sinh viên', style: TextStyle(color: Color(0xFF9E9E9E))))
            : ListView.separated(
                padding: const EdgeInsets.all(14),
                itemCount: _filteredStudents.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => _studentCard(_filteredStudents[i]),
              ),
      ),
    ]);
  }

  Widget _studentCard(Map<String, dynamic> s) {
    Color statusColor; String statusLabel;
    switch (s['status']) {
      case 'warning': statusColor = const Color(0xFFE65100); statusLabel = 'Cảnh báo'; break;
      case 'locked':  statusColor = const Color(0xFFC62828); statusLabel = 'Bị khoá';  break;
      default:        statusColor = const Color(0xFF4CAF50); statusLabel = 'Hoạt động';
    }
    final gpa = s['gpa'] as double;
    final gpaColor = gpa >= 3.2 ? const Color(0xFF2E7D32)
        : gpa >= 2.0 ? const Color(0xFFE65100) : const Color(0xFFC62828);

    return GestureDetector(
      onTap: () => _showUserDetailSheet(s, 'student'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Row(children: [
          _avatarWidget((s['name'] as String).split(' ').last.substring(0, 1),
              [_kPrimary.withOpacity(0.7), _kPrimary]),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 2),
            Text('${s['mssv']}  ·  ${s['class']}  ·  ${s['major']}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
            const SizedBox(height: 6),
            Row(children: [
              _chipWidget(statusLabel, statusColor),
              const SizedBox(width: 8),
              _chipWidget('GPA: $gpa', gpaColor),
            ]),
          ])),
          PopupMenuButton<String>(
            onSelected: (v) => _handleAction(v, s, 'student'),
            itemBuilder: (_) => [
              _popupItem('detail', Icons.info_outline,  'Xem chi tiết', null),
              _popupItem('edit',   Icons.edit_outlined,  'Chỉnh sửa',   null),
              _popupItem('reset',  Icons.lock_reset,     'Đặt lại MK',  null),
              _popupItem('lock',   Icons.block,          'Khoá TK',     Colors.red),
            ],
            icon: const Icon(Icons.more_vert, color: Color(0xFF9E9E9E), size: 20),
          ),
        ]),
      ),
    );
  }

  // ══ TAB 2: LECTURERS ═══════════════════════════════════
  Widget _buildLecturersTab() {
    final filters = ['Tất cả', 'Hoạt động', 'Nghỉ'];
    return Column(children: [
      _searchBar('Tìm giảng viên, mã GV...', (v) => setState(() => _lecturerSearch = v)),
      _filterRow(filters, _lecturerFilter, (f) => setState(() => _lecturerFilter = f)),
      Expanded(
        child: _filteredLecturers.isEmpty
            ? const Center(child: Text('Không tìm thấy giảng viên', style: TextStyle(color: Color(0xFF9E9E9E))))
            : ListView.separated(
                padding: const EdgeInsets.all(14),
                itemCount: _filteredLecturers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => _lecturerCard(_filteredLecturers[i]),
              ),
      ),
    ]);
  }

  Widget _lecturerCard(Map<String, dynamic> l) {
    final isActive    = l['status'] == 'active';
    final statusColor = isActive ? const Color(0xFF4CAF50) : const Color(0xFF9E9E9E);
    return GestureDetector(
      onTap: () => _showUserDetailSheet(l, 'lecturer'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Row(children: [
          _avatarWidget((l['name'] as String).split(' ').last.substring(0, 1),
              [const Color(0xFF00695C), const Color(0xFF2E7D32)]),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(l['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(width: 6),
              Text(l['code'] as String, style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
            ]),
            const SizedBox(height: 2),
            Text('${l['degree']}  ·  ${l['rank']}  ·  ${l['department']}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
            const SizedBox(height: 6),
            Row(children: [
              _chipWidget(isActive ? 'Đang dạy' : 'Nghỉ', statusColor),
              const SizedBox(width: 8),
              Icon(Icons.class_outlined, size: 12, color: Colors.grey[500]),
              const SizedBox(width: 3),
              Text('${l['classes']} lớp', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
            ]),
          ])),
          PopupMenuButton<String>(
            onSelected: (v) => _handleAction(v, l, 'lecturer'),
            itemBuilder: (_) => [
              _popupItem('detail',  Icons.info_outline,  'Xem chi tiết',   null),
              _popupItem('edit',    Icons.edit_outlined,  'Chỉnh sửa',     null),
              _popupItem('classes', Icons.class_outlined, 'Phân công lớp', null),
              _popupItem('reset',   Icons.lock_reset,     'Đặt lại MK',   null),
            ],
            icon: const Icon(Icons.more_vert, color: Color(0xFF9E9E9E), size: 20),
          ),
        ]),
      ),
    );
  }

  // ── Shared list widgets ──────────────────────────────────
  Widget _searchBar(String hint, ValueChanged<String> onChanged) => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
    child: TextField(
      decoration: InputDecoration(
        hintText: hint, hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFBDBDBD)),
        prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xFF9E9E9E)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE8E0F0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE8E0F0))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: _kPrimary)),
      ),
      style: const TextStyle(fontSize: 13),
      onChanged: onChanged,
    ),
  );

  Widget _filterRow(List<String> filters, String selected, ValueChanged<String> onTap) => Container(
    color: Colors.white,
    padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: filters.map((f) {
        final sel = selected == f;
        return Padding(padding: const EdgeInsets.only(right: 8), child: GestureDetector(
          onTap: () => onTap(f),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: sel ? _kPrimary : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: sel ? _kPrimary : const Color(0xFFE0D8F0)),
            ),
            child: Text(f, style: TextStyle(fontSize: 12, color: sel ? Colors.white : const Color(0xFF424242), fontWeight: FontWeight.w500)),
          ),
        ));
      }).toList()),
    ),
  );

  Widget _avatarWidget(String letter, List<Color> colors) => Container(
    width: 46, height: 46,
    decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: colors)),
    child: Center(child: Text(letter, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
  );

  Widget _chipWidget(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
    child: Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
  );

  PopupMenuItem<String> _popupItem(String value, IconData icon, String label, Color? color) =>
      PopupMenuItem(value: value, child: Row(children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(color: color)),
      ]));

  // ── Actions ──────────────────────────────────────────────
  void _handleAction(String action, Map<String, dynamic> user, String type) {
    if (action == 'detail') _showUserDetailSheet(user, type);
    else if (action == 'edit') _showUserFormSheet(user, type);
    else _snack('$action: ${user['name']}');
  }

  // ── Detail sheet (all helpers are METHODS of this state, no cross-file call) ──
  void _showUserDetailSheet(Map<String, dynamic> user, String type) {
    final isStudent = type == 'student';
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(children: [
          // Handle
          Center(child: Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40, height: 4,
            decoration: BoxDecoration(color: const Color(0xFFE0D8F0), borderRadius: BorderRadius.circular(2)),
          )),
          // Profile header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF0D1B6E), _kPrimary], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2), color: Colors.white.withOpacity(0.2)),
                child: Center(child: Text(
                  (user['name'] as String).split(' ').last.substring(0, 1),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                )),
              ),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(user['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 3),
                Text(
                  isStudent ? 'MSSV: ${user['mssv']}  ·  ${user['class']}' : '${user['code']}  ·  ${user['department']}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ])),
            ]),
          ),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
            // Info section 1
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFF9F9FF), borderRadius: BorderRadius.circular(12)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(isStudent ? 'Thông tin sinh viên' : 'Thông tin giảng viên',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: _kPrimary)),
                const SizedBox(height: 10),
                if (isStudent) ...[
                  _detailInfoRow('MSSV',         user['mssv']),
                  _detailInfoRow('Lớp',          user['class']),
                  _detailInfoRow('Chuyên ngành', user['major']),
                  _detailInfoRow('GPA',          '${user['gpa']}'),
                  _detailInfoRow('Trạng thái',   user['status']),
                ] else ...[
                  _detailInfoRow('Mã GV',        user['code']),
                  _detailInfoRow('Khoa',         user['department']),
                  _detailInfoRow('Học vị',       user['degree']),
                  _detailInfoRow('Chức danh',    user['rank']),
                  _detailInfoRow('Số lớp',       '${user['classes']} lớp'),
                ],
              ]),
            ),
            const SizedBox(height: 12),
            // Info section 2
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFF9F9FF), borderRadius: BorderRadius.circular(12)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Liên hệ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: _kPrimary)),
                const SizedBox(height: 10),
                _detailInfoRow('Email',      user['email']),
                _detailInfoRow('Điện thoại', user['phone']),
              ]),
            ),
            const SizedBox(height: 16),
            // Action buttons
            Row(children: [
              Expanded(child: GestureDetector(
                onTap: () => Navigator.pop(ctx),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(color: _kPrimary, borderRadius: BorderRadius.circular(9)),
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.edit_outlined, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text('Chỉnh sửa', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                  ]),
                ),
              )),
              const SizedBox(width: 10),
              Expanded(child: GestureDetector(
                onTap: () => Navigator.pop(ctx),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(color: const Color(0xFF2E7D32), borderRadius: BorderRadius.circular(9)),
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.lock_reset, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text('Đặt lại MK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                  ]),
                ),
              )),
            ]),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => Navigator.pop(ctx),
              child: Container(
                width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 11),
                decoration: BoxDecoration(color: const Color(0xFFC62828), borderRadius: BorderRadius.circular(9)),
                child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.block, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text('Khoá tài khoản', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                ]),
              ),
            ),
          ]))),
        ]),
      ),
    );
  }

  // ── Form sheet (add / edit) ──────────────────────────────
  void _showUserFormSheet(Map<String, dynamic>? user, String type) {
    final isStudent = type == 'student';
    final isEdit    = user != null;
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.82,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(children: [
          // Handle
          Center(child: Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40, height: 4,
            decoration: BoxDecoration(color: const Color(0xFFE0D8F0), borderRadius: BorderRadius.circular(2)),
          )),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Row(children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: _kPrimary.withOpacity(0.10), shape: BoxShape.circle),
                child: const Icon(Icons.person_outlined, color: _kPrimary, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                isEdit ? 'Chỉnh sửa ${isStudent ? 'sinh viên' : 'giảng viên'}'
                       : 'Thêm ${isStudent ? 'sinh viên' : 'giảng viên'}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF212121)),
              ),
            ]),
          ),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
            _formFieldBox('Họ và tên', user?['name'] ?? ''),
            const SizedBox(height: 12),
            if (isStudent) ...[
              _formFieldBox('MSSV', user?['mssv'] ?? ''),
              const SizedBox(height: 12),
              _formFieldBox('Lớp học', user?['class'] ?? ''),
              const SizedBox(height: 12),
              _formFieldBox('Chuyên ngành', user?['major'] ?? ''),
            ] else ...[
              _formFieldBox('Mã giảng viên', user?['code'] ?? ''),
              const SizedBox(height: 12),
              _formFieldBox('Khoa / Bộ môn', user?['department'] ?? ''),
              const SizedBox(height: 12),
              _formFieldBox('Học vị', user?['degree'] ?? ''),
              const SizedBox(height: 12),
              _formFieldBox('Chức danh', user?['rank'] ?? ''),
            ],
            const SizedBox(height: 12),
            _formFieldBox('Email', user?['email'] ?? ''),
            const SizedBox(height: 12),
            _formFieldBox('Số điện thoại', user?['phone'] ?? ''),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.pop(ctx),
              child: Container(
                width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF0D1B6E), _kPrimary]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text(
                  isEdit ? 'Lưu thay đổi' : 'Tạo tài khoản',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                )),
              ),
            ),
          ]))),
        ]),
      ),
    );
  }

  Widget _detailInfoRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 120, child: Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF9E9E9E)))),
      Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF212121)))),
    ]),
  );

  Widget _formFieldBox(String label, String hint) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF616161))),
      const SizedBox(height: 4),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: hint.isEmpty ? Colors.white : const Color(0xFFF9F9FF),
          border: Border.all(color: const Color(0xFFE0D8F0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          hint.isEmpty ? 'Nhập $label...' : hint,
          style: TextStyle(fontSize: 13, color: hint.isEmpty ? const Color(0xFFBDBDBD) : const Color(0xFF212121)),
        ),
      ),
    ],
  );

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: _kPrimary, behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 2)),
  );
}