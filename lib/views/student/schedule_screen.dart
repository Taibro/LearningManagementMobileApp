import 'package:flutter/material.dart';
import 'package:learning_management_app/enum/ScheduleType.dart';
import 'package:learning_management_app/models/Schedule.dart';


const Color _kPrimary   = Color(0xFF1565C0);
const Color _kGreen     = Color(0xFF43A047);
const Color _kYellow    = Color(0xFFFFC107);
const Color _kRed       = Color(0xFFE53935);
const Color _kOrange    = Color(0xFFFFA726);
const Color _kBg        = Color(0xFFF0F4FF);
const Color _kCardBg    = Colors.white;
const Color _kTextMain  = Color(0xFF212121);
const Color _kTextGrey  = Color(0xFF757575);

final DateTime _kToday = DateTime(2026, 4, 19);

const List<String> _kMonthNames = [
  'Tháng 1', 'Tháng 2', 'Tháng 3',  'Tháng 4',
  'Tháng 5', 'Tháng 6', 'Tháng 7',  'Tháng 8',
  'Tháng 9', 'Tháng 10','Tháng 11', 'Tháng 12',
];

enum ViewMode { day, week, month }


// ════════════════════════════════════════════════════════════════════
//  Du lieu demo
// ════════════════════════════════════════════════════════════════════

final Map<String, List<Schedule>> _kData = {
  '2026-04-01': [
    const Schedule(
      subjectName: 'Thực hành phân tích thiết kế hệ thống',
      tiet: '7 - 11',
      phong: 'A110 - Phòng máy tính - 140 Lê Trọng Tấn',
      giangVien: 'Đặng Đức Trung',
    ),
  ],
  '2026-04-02': [
    const Schedule(
      subjectName: 'Khai phá dữ liệu',
      tiet: '1 - 3',
      phong: 'A301 - 140 Lê Trọng Tấn',
      giangVien: 'Nguyễn Minh Tuấn',
      type: ScheduleType.lichTrucTuyen,
    ),
    const Schedule(
      subjectName: 'Lập trình Web nâng cao',
      tiet: '4 - 6',
      phong: 'B102 - 140 Lê Trọng Tấn',
      giangVien: 'Trần Thị Mai',
    ),
  ],
  '2026-04-06': [
    const Schedule(
      subjectName: 'Công nghệ Java',
      tiet: '1 - 3',
      phong: 'A202 - Phòng máy tính - 140 Lê Trọng Tấn',
      giangVien: 'Nguyễn Văn An',
    ),
  ],
  '2026-04-07': [
    const Schedule(
      subjectName: 'Mạng máy tính',
      tiet: '4 - 6',
      phong: 'B301 - 140 Lê Trọng Tấn',
      giangVien: 'Lê Văn Bình',
    ),
  ],
  '2026-04-08': [
    const Schedule(
      subjectName: 'Cơ sở dữ liệu',
      tiet: '1 - 4',
      phong: 'A101 - 140 Lê Trọng Tấn',
      giangVien: 'Trần Văn Cường',
    ),
  ],
  '2026-04-09': [
    const Schedule(
      subjectName: 'Hệ điều hành',
      tiet: '7 - 9',
      phong: 'A202 - 140 Lê Trọng Tấn',
      giangVien: 'Phạm Thị Dung',
    ),
  ],
  '2026-04-10': [
    const Schedule(
      subjectName: 'Trí tuệ nhân tạo',
      tiet: '10 - 12',
      phong: 'B101 - 140 Lê Trọng Tấn',
      giangVien: 'Hoàng Văn Em',
    ),
  ],
  '2026-04-13': [
    const Schedule(
      subjectName: 'Thực hành quản trị hệ thống mạng',
      tiet: '1 - 6',
      phong: 'A205 - Phòng máy tính - 140 Lê Trọng Tấn',
      giangVien: 'Đinh Huy Hoàng',
    ),
    const Schedule(
      subjectName: 'Lập trình di động',
      tiet: '7 - 11',
      phong: 'A104 - Phòng máy tính - 140 Lê Trọng Tấn',
      giangVien: 'Nguyễn Quang Huy',
    ),
  ],
  '2026-04-14': [
    const Schedule(
      subjectName: 'Công Nghệ Java',
      tiet: '2 - 6',
      phong: 'A202 - Phòng máy tính - 140 Lê Trọng Tấn',
      giangVien: 'Nguyễn Văn Lê',
    ),
  ],
  '2026-04-15': [
    const Schedule(
      subjectName: 'Kiểm thử phần mềm',
      tiet: '7 - 9',
      phong: 'B201 - 140 Lê Trọng Tấn',
      giangVien: 'Lê Thị Phương',
    ),
  ],
  '2026-04-16': [
    const Schedule(
      subjectName: 'Quản trị hệ thống mạng',
      tiet: '7 - 9',
      phong: 'A302 - 140 Lê Trọng Tấn',
      giangVien: 'Dương Bảo Ninh',
    ),
    const Schedule(
      subjectName: 'Phân tích thiết kế hệ thống',
      tiet: '10 - 12',
      phong: 'B201 - 140 Lê Trọng Tấn',
      giangVien: 'Nguyễn Văn Lê',
    ),
  ],
  '2026-04-17': [
    const Schedule(
      subjectName: 'An toàn thông tin',
      tiet: '1 - 3',
      phong: 'A301 - 140 Lê Trọng Tấn',
      giangVien: 'Trần Minh Quân',
    ),
  ],
  '2026-04-20': [
    const Schedule(
      subjectName: 'Đồ án tốt nghiệp',
      tiet: '1 - 6',
      phong: 'A301 - 140 Lê Trọng Tấn',
      giangVien: 'Nguyễn Văn Hùng',
    ),
  ],
  '2026-04-21': [
    const Schedule(
      subjectName: 'Lập trình C++',
      tiet: '7 - 9',
      phong: 'B102 - 140 Lê Trọng Tấn',
      giangVien: 'Phạm Văn Inh',
    ),
  ],
  '2026-04-22': [
    const Schedule(
      subjectName: 'Phương pháp nghiên cứu khoa học',
      tiet: '10 - 12',
      phong: 'A201 - 140 Lê Trọng Tấn',
      giangVien: 'Lê Thị Kim',
    ),
  ],
  '2026-04-23': [
    const Schedule(
      subjectName: 'Thực hành lập trình web',
      tiet: '1 - 6',
      phong: 'A105 - Phòng máy tính - 140 Lê Trọng Tấn',
      giangVien: 'Nguyễn Thị Lan',
    ),
  ],
  '2026-04-24': [
    const Schedule(
      subjectName: 'Kiến trúc máy tính',
      tiet: '7 - 9',
      phong: 'B201 - 140 Lê Trọng Tấn',
      giangVien: 'Trần Văn Minh',
    ),
  ],
};

// ════════════════════════════════════════════════════════════════════
//  UTILITIES
// ════════════════════════════════════════════════════════════════════

String _dateKey(DateTime d) =>
    '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Chuyen tu Mon=1…Sun=7 sang 'Th 2'…'Th 7'/'CN'
String _wdShort(int wd) => wd == 7 ? 'CN' : 'Th ${wd + 1}';

String _ddMM(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';

String _ddMMYYYY(DateTime d) => '${_ddMM(d)}/${d.year}';

/// Th 5, 16/04/2026
String _dayDateLong(DateTime d) => '${_wdShort(d.weekday)}, ${_ddMMYYYY(d)}';

/// Th 5, 16/04
String _dayDateShort(DateTime d) => '${_wdShort(d.weekday)}, ${_ddMM(d)}';

/// Week-of-year counted from the first Monday of the year.
int _weekOfYear(DateTime d) {
  DateTime firstMon = DateTime(d.year, 1, 1);
  while (firstMon.weekday != DateTime.monday) {
    firstMon = firstMon.add(const Duration(days: 1));
  }
  if (d.isBefore(firstMon)) return 1;
  return d.difference(firstMon).inDays ~/ 7 + 2;
}

/// Monday of the week containing [d].
DateTime _weekStart(DateTime d) =>
    DateTime(d.year, d.month, d.day).subtract(Duration(days: d.weekday - 1));

Color _typeColor(ScheduleType t) {
  switch (t) {
    case ScheduleType.lichHoc:        return _kGreen;
    case ScheduleType.lichThi:        return _kYellow;
    case ScheduleType.lichTrucTuyen:  return _kPrimary;
    case ScheduleType.tamNgung:       return _kRed;
  }
}

bool _hasItems(DateTime d) => (_kData[_dateKey(d)] ?? []).isNotEmpty;
List<Schedule> _itemsFor(DateTime d) => _kData[_dateKey(d)] ?? [];

//---------------------------------------------------------------
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selected = DateTime(2026, 4, 16);
  ViewMode _mode = ViewMode.day;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          _appBar(),
          _dateBar(),
          if (_mode == ViewMode.week) _weekStrip(),
          Expanded(child: _body()),
          _legend(),
        ],
      ),
      
    );
  }

  Widget _appBar() {
    return Container(
      color: _kPrimary,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
        bottom: 14,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Lịch học/ lịch thi',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(Icons.menu, color: Colors.white, size: 22),
        ],
      ),
    );
  }

  
  Widget _dateBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          _dateSelectorForMode(),
          const Spacer(),
          _viewModeTabs(),
        ],
      ),
    );
  }

  Widget _dateSelectorForMode() {
    switch (_mode) {
      case ViewMode.day:
        return _dropBtn(
          label: _dayDateLong(_selected),
          onTap: _showDayPicker,
        );

      case ViewMode.week:
        return Row(
          children: [
            _dropBtn(
              label: '${_selected.year}',
              onTap: _showYearPicker,
            ),
            const SizedBox(width: 10),
            _dropBtn(
              label: 'Tuần ${_weekOfYear(_selected)}',
              onTap: _showWeekPicker,
            ),
          ],
        );

      case ViewMode.month:
        return _dropBtn(
          label:
              'tháng ${_selected.month}, ${_selected.year}',
          onTap: _showMonthYearPicker,
        );
    }
  }

  Widget _dropBtn({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: _kTextMain,
            ),
          ),
          const Icon(Icons.arrow_drop_down,
              size: 20, color: _kTextMain),
        ],
      ),
    );
  }

  Widget _viewModeTabs() {
    const labels = ['Ngày', 'Tuần', 'Tháng'];
    const modes = ViewMode.values;
    return Container(
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          final selected = _mode == modes[i];
          return GestureDetector(
            onTap: () => setState(() => _mode = modes[i]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? _kPrimary : Colors.transparent,
                borderRadius: BorderRadius.horizontal(
                  left:  i == 0 ? const Radius.circular(7) : Radius.zero,
                  right: i == 2 ? const Radius.circular(7) : Radius.zero,
                ),
              ),
              child: Text(
                labels[i],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : const Color(0xFF616161),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Week Strip ────────────────────────────────────────────────────

  Widget _weekStrip() {
    final monday = _weekStart(_selected);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 10),
      child: Row(
        children: List.generate(7, (i) {
          final day    = monday.add(Duration(days: i));
          final isSel  = _sameDay(day, _selected);
          final isWEnd = day.weekday >= 6; 
          final hasDot = _hasItems(day);

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selected = day),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Weekday label
                  Text(
                    _wdShort(day.weekday),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isSel
                          ? _kPrimary
                          : isWEnd
                              ? _kRed
                              : const Color(0xFF9E9E9E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color:
                          isSel ? _kPrimary : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isSel
                            ? Colors.white
                            : isWEnd
                                ? _kRed
                                : _kTextMain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Event dot
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color:
                          hasDot ? _kOrange : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Body dispatcher ───────────────────────────────────────────────

  Widget _body() {
    switch (_mode) {
      case ViewMode.day:   return _dayView();
      case ViewMode.week:  return _weekView();
      case ViewMode.month: return _monthView();
    }
  }

  // ── Day View ──────────────────────────────────────────────────────

  Widget _dayView() {
    final items = _itemsFor(_selected);
    if (items.isEmpty) return _emptyState(_selected);
    return ListView.separated(
      padding: const EdgeInsets.all(14),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _card(items[i]),
    );
  }

  // ── Week View ─────────────────────────────────────────────────────

  Widget _weekView() {
    final monday = _weekStart(_selected);
    final groups = <(DateTime, List<Schedule>)>[];
    for (int i = 0; i < 7; i++) {
      final d = monday.add(Duration(days: i));
      final it = _itemsFor(d);
      if (it.isNotEmpty) groups.add((d, it));
    }
    if (groups.isEmpty) return _emptyState(_selected);

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      itemCount: groups.length,
      itemBuilder: (_, gi) {
        final (date, items) = groups[gi];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (gi > 0) const SizedBox(height: 14),
            _groupHeader(date),
            const SizedBox(height: 8),
            ...items.map((it) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _card(it),
                )),
          ],
        );
      },
    );
  }

  
  Widget _monthView() {
    final y = _selected.year;
    final m = _selected.month;
    final daysInMonth = DateTime(y, m + 1, 0).day;

    final groups = <(DateTime, List<Schedule>)>[];
    for (int d = 1; d <= daysInMonth; d++) {
      final date = DateTime(y, m, d);
      final it = _itemsFor(date);
      if (it.isNotEmpty) groups.add((date, it));
    }

    return CustomScrollView(
      slivers: [
        // ── Calendar card ─────────────────────────────────────────
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(14),
            child: _calendarGrid(y, m),
          ),
        ),
        
        if (groups.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: _emptyState(_selected),
            ),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, gi) {
                final (date, items) = groups[gi];
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      14, gi == 0 ? 14 : 0, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _groupHeader(date),
                      const SizedBox(height: 8),
                      ...items.map((it) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _card(it),
                          )),
                    ],
                  ),
                );
              },
              childCount: groups.length,
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 14)),
      ],
    );
  }

  /// Calendar grid widget
  Widget _calendarGrid(int year, int month) {
    final firstDay    = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final startOffset = firstDay.weekday - 1; 

    const wdLabels = ['Th 2','Th 3','Th 4','Th 5','Th 6','Th 7','CN'];

    return Column(
      children: [
        // Day-of-week headers
        Row(
          children: List.generate(7, (i) {
            final isWEnd = i >= 5;
            return Expanded(
              child: Center(
                child: Text(
                  wdLabels[i],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isWEnd ? _kRed : const Color(0xFF9E9E9E),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        // Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.0,
          ),
          itemCount: startOffset + daysInMonth,
          itemBuilder: (_, idx) {
            if (idx < startOffset) return const SizedBox();
            final day   = idx - startOffset + 1;
            final date  = DateTime(year, month, day);
            final isSel = _sameDay(date, _selected);
            final isTod = _sameDay(date, _kToday);
            final isWEnd = date.weekday >= 6;
            final hasDot = _hasItems(date);

            return GestureDetector(
              onTap: () => setState(() => _selected = date),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: isSel ? _kPrimary : Colors.transparent,
                      shape: BoxShape.circle,
                      border: isTod && !isSel
                          ? Border.all(color: _kPrimary, width: 1.5)
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$day',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isSel
                            ? Colors.white
                            : isWEnd
                                ? _kRed
                                : _kTextMain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color:
                          hasDot ? _kOrange : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }


  Widget _groupHeader(DateTime date) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: _kPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _dayDateShort(date),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ── Schedule Card ─────────────────────────────────────────────────

  Widget _card(Schedule item) {
    final color = _typeColor(item.type);
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Colored left accent
            Container(width: 4, color: color),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.subjectName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: _kTextMain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _infoRow('Tiết :', item.tiet),
                    const SizedBox(height: 4),
                    _infoRow('Phòng :', item.phong),
                    const SizedBox(height: 4),
                    _infoRow('Giảng viên :', item.giangVien),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(label,
              style: const TextStyle(
                  fontSize: 13, color: _kTextGrey)),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _kTextMain,
            ),
          ),
        ),
      ],
    );
  }

  // ── Empty State ───────────────────────────────────────────────────

  Widget _emptyState(DateTime date) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 160,
            child: CustomPaint(painter: _FolderPainter()),
          ),
          const SizedBox(height: 20),
          Text(
            'Không có dữ liệu vào ${_dayDateLong(date)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, color: _kTextGrey),
          ),
        ],
      ),
    );
  }

  // ── Legend ────────────────────────────────────────────────────────

  Widget _legend() {
    const items = [
      (_kGreen,   'Lịch học'),
      (_kYellow,  'Lịch thi'),
      (_kPrimary, 'Lịch trực tuyến'),
      (_kRed,     'Tạm ngưng'),
    ];
    return Container(
      color: Colors.white,
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Wrap(
        spacing: 16,
        runSpacing: 6,
        children: items.map((e) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                    color: e.$1, shape: BoxShape.circle),
              ),
              const SizedBox(width: 4),
              Text(e.$2,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF424242))),
            ],
          );
        }).toList(),
      ),
    );
  }

  
//--------------------------------------------------------------------
  void _showDayPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(23)),
      ),
      builder: (_) => _CalendarPickerSheet(
        initialDate: _selected,
        today: _kToday,
        onDateSelected: (d) => setState(() => _selected = d),
      ),
    );
  }

  void _showYearPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(23)),
      ),
      builder: (_) => _YearPickerSheet(
        initialYear: _selected.year,
        onYearSelected: (y) => setState(() {
          final day = _selected.day
              .clamp(1, DateTime(y, _selected.month + 1, 0).day);
          _selected = DateTime(y, _selected.month, day);
        }),
      ),
    );
  }

  void _showWeekPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _WeekPickerSheet(
        initialDate: _selected,
        onWeekSelected: (monday) =>
            setState(() => _selected = monday),
      ),
    );
  }

  void _showMonthYearPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _MonthYearPickerSheet(
        initialYear: _selected.year,
        initialMonth: _selected.month,
        onSelected: (y, m) {
          final day = _selected.day
              .clamp(1, DateTime(y, m + 1, 0).day);
          setState(() => _selected = DateTime(y, m, day));
        },
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
//  CALENDAR PICKER SHEET  (Image 2)
// ════════════════════════════════════════════════════════════════════

class _CalendarPickerSheet extends StatefulWidget {
  final DateTime initialDate;
  final DateTime today;
  final void Function(DateTime) onDateSelected;

  const _CalendarPickerSheet({
    required this.initialDate,
    required this.today,
    required this.onDateSelected,
  });

  @override
  State<_CalendarPickerSheet> createState() =>
      _CalendarPickerSheetState();
}

class _CalendarPickerSheetState
    extends State<_CalendarPickerSheet> {
  late DateTime _viewMonth;
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    _viewMonth =
        DateTime(widget.initialDate.year, widget.initialDate.month);
    _selected = widget.initialDate;
  }

  void _prev() => setState(() =>
      _viewMonth = DateTime(_viewMonth.year, _viewMonth.month - 1));
  void _next() => setState(() =>
      _viewMonth = DateTime(_viewMonth.year, _viewMonth.month + 1));

  @override
  Widget build(BuildContext context) {
    final y = _viewMonth.year;
    final m = _viewMonth.month;
    final firstDay    = DateTime(y, m, 1);
    final daysInMonth = DateTime(y, m + 1, 0).day;
    final startOffset = firstDay.weekday - 1; // Mon=0

    const wdLabels = ['Th 2','Th 3','Th 4','Th 5','Th 6','Th 7','CN'];

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ──────────────────────────────────────────
            Row(
              children: [
                Text(
                  '${_kMonthNames[m - 1]} $y',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kTextMain,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _prev,
                  child: const Icon(Icons.chevron_left,
                      size: 28, color: _kTextMain),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: _next,
                  child: const Icon(Icons.chevron_right,
                      size: 28, color: _kTextMain),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // ── Day-of-week headers ──────────────────────────────
            Row(
              children: List.generate(7, (i) {
                final isWEnd = i >= 5;
                return Expanded(
                  child: Center(
                    child: Text(
                      wdLabels[i],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isWEnd
                            ? _kRed
                            : const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            // ── Calendar Grid ─────────────────────────────────────
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.05,
              ),
              itemCount: startOffset + daysInMonth,
              itemBuilder: (_, idx) {
                if (idx < startOffset) return const SizedBox();
                final day  = idx - startOffset + 1;
                final date = DateTime(y, m, day);
                final isSel = _sameDay(date, _selected);
                final isTod = _sameDay(date, widget.today);
                final isWEnd = date.weekday >= 6;

                return GestureDetector(
                  onTap: () {
                    setState(() => _selected = date);
                    widget.onDateSelected(date);
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isSel ? _kPrimary : Colors.transparent,
                        shape: BoxShape.circle,
                        border: isTod && !isSel
                            ? Border.all(
                                color: _kPrimary, width: 1.5)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSel
                              ? Colors.white
                              : isWEnd
                                  ? _kRed
                                  : _kTextMain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------

class _YearPickerSheet extends StatelessWidget {
  final int initialYear;
  final void Function(int) onYearSelected;

  const _YearPickerSheet({
    required this.initialYear,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    const years = [2024, 2025, 2026, 2027, 2028];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(23)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Chọn năm',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...years.map((y) {
            final selected = y == initialYear;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                '$y',
                style: TextStyle(
                  color: selected ? _kPrimary : _kTextMain,
                  fontWeight:
                      selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: selected
                  ? const Icon(Icons.check, color: _kPrimary)
                  : null,
              onTap: () {
                onYearSelected(y);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════

class _WeekPickerSheet extends StatelessWidget {
  final DateTime initialDate;
  final void Function(DateTime monday) onWeekSelected;

  const _WeekPickerSheet({
    required this.initialDate,
    required this.onWeekSelected,
  });

  @override
  Widget build(BuildContext context) {
    final year = initialDate.year;

    DateTime firstMon = DateTime(year, 1, 1);
    while (firstMon.weekday != DateTime.monday) {
      firstMon = firstMon.add(const Duration(days: 1));
    }

    final weeks = <(int, DateTime, DateTime)>[];
    for (int w = 0; w < 53; w++) {
      final monday = firstMon.add(Duration(days: w * 7));
      if (monday.year > year) break;
      final sunday = monday.add(const Duration(days: 6));
      weeks.add((w + 2, monday, sunday));
    }

    final currentWeek = _weekOfYear(initialDate);

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.8,
      minChildSize: 0.3,
      expand: false,
      builder: (_, ctrl) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Chọn tuần',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                controller: ctrl,
                itemCount: weeks.length,
                itemBuilder: (_, i) {
                  final (wNum, mon, sun) = weeks[i];
                  final selected = wNum == currentWeek;
                  return ListTile(
                    title: Text(
                      'Tuần $wNum  (${_ddMM(mon)} - ${_ddMM(sun)})',
                      style: TextStyle(
                        fontSize: 13,
                        color: selected ? _kPrimary : _kTextMain,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    trailing: selected
                        ? const Icon(Icons.check,
                            color: _kPrimary)
                        : null,
                    onTap: () {
                      onWeekSelected(mon);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthYearPickerSheet extends StatefulWidget {
  final int initialYear;
  final int initialMonth;
  final void Function(int year, int month) onSelected;

  const _MonthYearPickerSheet({
    required this.initialYear,
    required this.initialMonth,
    required this.onSelected,
  });

  @override
  State<_MonthYearPickerSheet> createState() =>
      _MonthYearPickerSheetState();
}

class _MonthYearPickerSheetState
    extends State<_MonthYearPickerSheet> {
  late int _year;
  late int _month;

  @override
  void initState() {
    super.initState();
    _year  = widget.initialYear;
    _month = widget.initialMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Year selector row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => setState(() => _year--),
              ),
              Text('$_year',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => setState(() => _year++),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Month grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2.2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 12,
            itemBuilder: (_, i) {
              final m = i + 1;
              final sel = m == _month && _year == widget.initialYear;
              return GestureDetector(
                onTap: () {
                  widget.onSelected(_year, m);
                  Navigator.pop(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: m == _month
                        ? _kPrimary
                        : const Color(0xFFF0F4FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Th $m',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: m == _month
                          ? Colors.white
                          : const Color(0xFF424242),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//-------------------------------------------------------------------
class _FolderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p  = Paint()..style = PaintingStyle.fill;
    final cx = size.width / 2;
    final cy = size.height / 2;
    const grey      = Color(0xFFCFD8DC);
    const lightGrey = Color(0xFFECEFF1);

    // ── Folder back ─────────────────────────────────────────────
    p.color = grey;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(18, cy * 0.55, size.width - 36,
            size.height * 0.58),
        const Radius.circular(12),
      ),
      p,
    );

    // ── Folder tab ───────────────────────────────────────────────
    final tab = Path()
      ..moveTo(18, cy * 0.55)
      ..lineTo(18, cy * 0.3)
      ..quadraticBezierTo(18, cy * 0.22, 24, cy * 0.22)
      ..lineTo(cx * 0.85, cy * 0.22)
      ..quadraticBezierTo(cx * 0.94, cy * 0.22, cx * 0.97, cy * 0.36)
      ..lineTo(cx * 1.02, cy * 0.55)
      ..close();
    canvas.drawPath(tab, p);

    // ── Folder front ─────────────────────────────────────────────
    p.color = lightGrey;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(18, cy * 0.72, size.width - 36,
            size.height * 0.52),
        const Radius.circular(12),
      ),
      p,
    );

    // ── Lines inside folder ──────────────────────────────────────
    p
      ..color = grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 3; i++) {
      final y = cy * 0.92 + i * 13.0;
      canvas.drawLine(
          Offset(cx - 45, y), Offset(cx + 45, y), p);
    }

    // ── Sad face ─────────────────────────────────────────────────
    // Eyes
    p
      ..style = PaintingStyle.fill
      ..color = grey;
    canvas.drawCircle(Offset(cx - 12, cy * 0.88), 4.5, p);
    canvas.drawCircle(Offset(cx + 12, cy * 0.88), 4.5, p);

    // Mouth
    p
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = grey;
    final mouth = Path()
      ..moveTo(cx - 14, cy * 1.05)
      ..quadraticBezierTo(cx, cy * 0.98, cx + 14, cy * 1.05);
    canvas.drawPath(mouth, p);

    // ── Decorative dots ──────────────────────────────────────────
    p
      ..style = PaintingStyle.fill
      ..color = grey.withOpacity(0.45);
    for (final pos in [
      Offset(18.0,         cy * 0.42),
      Offset(size.width - 18, cy * 0.5),
      Offset(12.0,         cy * 0.85),
      Offset(size.width - 12, cy * 0.9),
      Offset(cx + 50,      cy * 0.32),
    ]) {
      canvas.drawCircle(pos, 4, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}