import 'package:flutter/material.dart';

class LecturerScheduleScreen extends StatefulWidget {
  const LecturerScheduleScreen({super.key});

  @override
  State<LecturerScheduleScreen> createState() => _LecturerScheduleScreenState();
}

class _LecturerScheduleScreenState extends State<LecturerScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _weekOffset = 0;

  final List<String> _weekDays = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
  final List<String> _weekDates = [
    '20/04', '21/04', '22/04', '23/04', '24/04', '25/04', '26/04'
  ];

  // Weekly schedule data: day index (0=Mon) → list of classes
  final Map<int, List<Map<String, dynamic>>> _weekSchedule = {
    0: [
      {
        'subject': 'Kiến trúc máy tính (LT)',
        'code': '16DHTH10',
        'room': 'A401 - 140 LTT',
        'session': 'Tiết 1–3',
        'type': 'theory',
      },
      {
        'subject': 'TH Quản trị HTMM (TH)',
        'code': '14DHTH40',
        'room': 'A107 - Phòng máy',
        'session': 'Tiết 13–15',
        'type': 'practice',
      },
    ],
    1: [
      {
        'subject': 'Kiến trúc máy tính (LT)',
        'code': '16DHTH08',
        'room': 'B407 - 140 LTT',
        'session': 'Tiết 7–9',
        'type': 'theory',
      },
      {
        'subject': 'TH Quản trị HTMM (TH)',
        'code': '14DHTH41',
        'room': 'A107 - Phòng máy',
        'session': 'Tiết 13–15',
        'type': 'practice',
      },
    ],
    3: [
      {
        'subject': 'Quản trị HTMM (LT)',
        'code': '14DHTH04',
        'room': 'A202 - 140 LTT',
        'session': 'Tiết 7–9',
        'type': 'theory',
      },
      {
        'subject': 'Quản trị HTMM (LT)',
        'code': '14DHTH03',
        'room': 'A301 - 140 LTT',
        'session': 'Tiết 10–12',
        'type': 'theory',
      },
      {
        'subject': 'TH Quản trị HTMM (TH)',
        'code': '14DHTH42',
        'room': 'A108 - Phòng máy',
        'session': 'Tiết 13–15',
        'type': 'practice',
      },
    ],
    4: [
      {
        'subject': 'Các vấn đề ATTT (LT)',
        'code': '09CUICMITUE02',
        'room': 'DP01 - Công ty CP Tin học Đại Phát',
        'session': 'Tiết 2–6',
        'type': 'online',
      },
      {
        'subject': 'TH Quản trị HTMM (TH)',
        'code': '14DHTH43',
        'room': 'A108 - Phòng máy',
        'session': 'Tiết 13–15',
        'type': 'practice',
      },
    ],
  };

  // Progress data
  final List<Map<String, dynamic>> _progressList = [
    {
      'subject': 'Kiến trúc máy tính (LT)',
      'code': '010100228915 - 16DHTH10',
      'total': 45,
      'done': 29,
      'status': 'Đang dạy',
      'statusColor': 0xFF4CAF50,
      'chapters': [
        {'label': 'Chương 1', 'done': true, 'pct': 1.0},
        {'label': 'Chương 2', 'done': true, 'pct': 1.0},
        {'label': 'Chương 3', 'done': true, 'pct': 1.0},
        {'label': 'Chương 4', 'done': false, 'pct': 0.6},
        {'label': 'Chương 5', 'done': false, 'pct': 0.0},
      ],
    },
    {
      'subject': 'Quản trị hệ thống mạng (LT)',
      'code': '010110197304 - 14DHTH04',
      'total': 60,
      'done': 24,
      'status': 'Đang dạy',
      'statusColor': 0xFF2196F3,
      'chapters': [],
    },
    {
      'subject': 'TH Quản trị hệ thống mạng (TH)',
      'code': '010110192400 - 14DHTH40',
      'total': 30,
      'done': 24,
      'status': 'Gần hoàn thành',
      'statusColor': 0xFFE65100,
      'chapters': [],
    },
    {
      'subject': 'Các vấn đề biên đại ATTT (LT)',
      'code': '932210293002 - 09CUICMITUE02',
      'total': 30,
      'done': 30,
      'status': 'Hoàn thành',
      'statusColor': 0xFF6B4FA0,
      'chapters': [],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                _buildWeeklyTab(),
                _buildProgressTab(),
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
          Icon(Icons.calendar_today_rounded, color: Colors.white, size: 22),
          SizedBox(width: 10),
          Text(
            'Lịch giảng dạy',
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

  // ─── Tab bar ─────────────────────────────────────────────────
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
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        tabs: const [
          Tab(text: 'Lịch theo tuần'),
          Tab(text: 'Tiến độ giảng dạy'),
        ],
      ),
    );
  }

  // ─── Weekly tab ──────────────────────────────────────────────
  Widget _buildWeeklyTab() {
    return Column(
      children: [
        _buildWeekNavigator(),
        _buildLegend(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: List.generate(7, (dayIndex) {
                final classes = _weekSchedule[dayIndex] ?? [];
                return _buildDayRow(dayIndex, classes);
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekNavigator() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => setState(() => _weekOffset--),
            icon: const Icon(Icons.chevron_left, color: Color(0xFF6B4FA0)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Expanded(
            child: Text(
              'Tuần ${20 + _weekOffset}/04 – ${26 + _weekOffset}/04/2026',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF212121),
              ),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _weekOffset++),
            icon: const Icon(Icons.chevron_right, color: Color(0xFF6B4FA0)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => setState(() => _weekOffset = 0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF6B4FA0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Hôm nay',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    final items = [
      {'color': const Color(0xFF4CAF50), 'label': 'Lý thuyết'},
      {'color': const Color(0xFF5C6BC0), 'label': 'Thực hành'},
      {'color': const Color(0xFFE65100), 'label': 'Trực tuyến'},
    ];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: Row(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: item['color'] as Color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  item['label'] as String,
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF616161)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDayRow(int dayIndex, List<Map<String, dynamic>> classes) {
    final isToday = dayIndex == 0; // Monday = today (demo)
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isToday
            ? Border.all(color: const Color(0xFF6B4FA0), width: 1.5)
            : null,
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
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isToday
                  ? const Color(0xFF6B4FA0).withOpacity(0.08)
                  : const Color(0xFFF9F7FF),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Text(
                  _weekDays[dayIndex],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isToday
                        ? const Color(0xFF6B4FA0)
                        : const Color(0xFF424242),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _weekDates[dayIndex],
                  style: TextStyle(
                    fontSize: 12,
                    color: isToday
                        ? const Color(0xFF6B4FA0)
                        : Colors.grey[500],
                  ),
                ),
                if (isToday) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B4FA0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Hôm nay',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
                const Spacer(),
                Text(
                  '${classes.length} buổi',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          if (classes.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'Không có lịch dạy',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[400],
                    fontStyle: FontStyle.italic),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: classes
                    .map((cls) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _buildScheduleChip(cls),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScheduleChip(Map<String, dynamic> cls) {
    Color color;
    Color bgColor;
    switch (cls['type']) {
      case 'practice':
        color = const Color(0xFF5C6BC0);
        bgColor = const Color(0xFFE8EAF6);
        break;
      case 'online':
        color = const Color(0xFFE65100);
        bgColor = const Color(0xFFFFF3E0);
        break;
      default:
        color = const Color(0xFF2E7D32);
        bgColor = const Color(0xFFE8F5E9);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cls['subject'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  cls['code'],
                  style: TextStyle(fontSize: 11, color: color.withOpacity(0.8)),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 11, color: color),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        cls['room'],
                        style: TextStyle(
                            fontSize: 11, color: color.withOpacity(0.9)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              cls['session'],
              style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Progress tab ────────────────────────────────────────────
  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProgressFilter(),
          const SizedBox(height: 16),
          ..._progressList.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildProgressCard(item),
              )),
        ],
      ),
    );
  }

  Widget _buildProgressFilter() {
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0D8F0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('HK2 - 2025-2026',
                      style:
                          TextStyle(fontSize: 13, color: Color(0xFF424242))),
                  Icon(Icons.keyboard_arrow_down,
                      color: Color(0xFF6B4FA0), size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Xem tiến độ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(Map<String, dynamic> item) {
    final pct = item['done'] / item['total'];
    final chapters = List<Map<String, dynamic>>.from(item['chapters']);
    final statusColor = Color(item['statusColor'] as int);

    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['subject'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF212121),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item['code'],
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item['status'],
                  style: TextStyle(
                    fontSize: 11,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: pct,
                    backgroundColor: const Color(0xFFE0D8F0),
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(pct * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Đã dạy: ${item['done']}/${item['total']} tiết  ·  Còn lại: ${item['total'] - item['done']} tiết',
            style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
          ),
          if (chapters.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: chapters.map((ch) {
                Color chipColor;
                Color bgColor;
                if (ch['done'] == true) {
                  chipColor = const Color(0xFF6B4FA0);
                  bgColor = const Color(0xFFEDE7F6);
                } else if ((ch['pct'] as double) > 0) {
                  chipColor = const Color(0xFFE65100);
                  bgColor = const Color(0xFFFFF3E0);
                } else {
                  chipColor = Colors.grey;
                  bgColor = const Color(0xFFF5F5F5);
                }
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ch['done'] == true
                        ? '${ch['label']}: ✓'
                        : (ch['pct'] as double) > 0
                            ? '${ch['label']}: ${((ch['pct'] as double) * 100).toInt()}%'
                            : '${ch['label']}: Chưa',
                    style: TextStyle(
                        fontSize: 11,
                        color: chipColor,
                        fontWeight: FontWeight.w500),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}