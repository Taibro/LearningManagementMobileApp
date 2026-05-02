import 'package:flutter/material.dart';

class LecturerHomeScreen extends StatefulWidget {
  const LecturerHomeScreen({super.key});

  @override
  State<LecturerHomeScreen> createState() => _LecturerHomeScreenState();
}

class _LecturerHomeScreenState extends State<LecturerHomeScreen> {
  // ─── Sample data ────────────────────────────────────────────
  final List<Map<String, dynamic>> _todayClasses = [
    {
      'subject': 'Kiến trúc máy tính (LT)',
      'classCode': '010100228915 - 16DHTH10',
      'room': 'A401 - 140 Lê Trọng Tấn',
      'session': 'Tiết 1 – 3',
      'time': '07:00 – 09:30',
      'type': 'theory', // theory | practice | online
    },
    {
      'subject': 'TH Quản trị hệ thống mạng (TH)',
      'classCode': '010110192400 - 14DHTH40',
      'room': 'A107 - Phòng máy BM',
      'session': 'Tiết 13 – 15',
      'time': '18:00 – 20:30',
      'type': 'practice',
    },
  ];

  final List<Map<String, dynamic>> _notifications = [
    {
      'icon': Icons.check_circle_outline,
      'color': const Color(0xFF4CAF50),
      'title': 'Đề xuất dạy bù đã được duyệt',
      'time': '30 phút trước',
    },
    {
      'icon': Icons.info_outline,
      'color': const Color(0xFF6B4FA0),
      'title': 'Nhắc nhở: Nộp bảng điểm HK2 trước 20/05',
      'time': '2 giờ trước',
    },
    {
      'icon': Icons.warning_amber_outlined,
      'color': const Color(0xFFE85D75),
      'title': '3 sinh viên vắng trên 20% - 14DHTH04',
      'time': 'Hôm qua',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1F8),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsRow(),
                  const SizedBox(height: 20),
                  _buildTodayClasses(),
                  const SizedBox(height: 20),
                  _buildFunctionSection(),
                  const SizedBox(height: 20),
                  _buildNotifications(),
                  const SizedBox(height: 8),
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
        top: MediaQuery.of(context).padding.top + 12,
        left: 16,
        right: 16,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: Icon(Icons.person, size: 38, color: Colors.grey[400]),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Xin chào, Nguyễn Văn A',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Giảng viên · Khoa CNTT',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE85D75),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHeaderStat('HK2 2025-2026', 'Học kỳ'),
                _buildHeaderDivider(),
                _buildHeaderStat('5', 'Lớp phụ trách'),
                _buildHeaderDivider(),
                _buildHeaderStat('120', 'Tiết / học kỳ'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildHeaderDivider() {
    return Container(width: 1, height: 30, color: Colors.white30);
  }

  // ─── Stats row ──────────────────────────────────────────────
  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard('Hôm nay', '2 lớp', Icons.class_outlined,
            const Color(0xFF6B4FA0)),
        const SizedBox(width: 12),
        _buildStatCard('Tuần này', '8 buổi', Icons.calendar_view_week_outlined,
            const Color(0xFF4CAF50)),
        const SizedBox(width: 12),
        _buildStatCard('Chờ duyệt', '1 đề xuất', Icons.pending_outlined,
            const Color(0xFFE65100)),
      ],
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Today's classes ────────────────────────────────────────
  Widget _buildTodayClasses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Lịch dạy hôm nay',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            Text(
              'Thứ 2, 28/04/2026',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._todayClasses.map((cls) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildClassCard(cls),
            )),
      ],
    );
  }

  Widget _buildClassCard(Map<String, dynamic> cls) {
    Color accentColor;
    Color bgColor;
    IconData typeIcon;
    String typeLabel;

    switch (cls['type']) {
      case 'practice':
        accentColor = const Color(0xFF5C6BC0);
        bgColor = const Color(0xFFE8EAF6);
        typeIcon = Icons.computer_outlined;
        typeLabel = 'Thực hành';
        break;
      case 'online':
        accentColor = const Color(0xFFE65100);
        bgColor = const Color(0xFFFFF3E0);
        typeIcon = Icons.video_call_outlined;
        typeLabel = 'Trực tuyến';
        break;
      default:
        accentColor = const Color(0xFF2E7D32);
        bgColor = const Color(0xFFE8F5E9);
        typeIcon = Icons.menu_book_outlined;
        typeLabel = 'Lý thuyết';
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: accentColor, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(typeIcon, color: accentColor, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cls['subject'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  cls['classCode'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 13, color: accentColor),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        cls['room'],
                        style: TextStyle(
                          fontSize: 12,
                          color: accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  typeLabel,
                  style: TextStyle(
                    fontSize: 10,
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                cls['session'],
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                cls['time'],
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6B4FA0),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Functions ──────────────────────────────────────────────
  Widget _buildFunctionSection() {
    final features = [
      {
        'icon': Icons.how_to_reg_outlined,
        'label': 'Điểm danh',
        'color': const Color(0xFF6B4FA0)
      },
      {
        'icon': Icons.qr_code_2_rounded,
        'label': 'QR Code',
        'color': const Color(0xFF4CAF50)
      },
      {
        'icon': Icons.grade_rounded,
        'label': 'Kết quả\nhọc tập',
        'color': const Color(0xFF2196F3)
      },
      {
        'icon': Icons.bar_chart_rounded,
        'label': 'Thống kê\ngiảng dạy',
        'color': const Color(0xFFE65100)
      },
      {
        'icon': Icons.monetization_on_outlined,
        'label': 'Thông tin\nlương',
        'color': const Color(0xFF2E7D32)
      },
      {
        'icon': Icons.library_books_outlined,
        'label': 'Tài liệu\nbài giảng',
        'color': const Color(0xFF5C6BC0)
      },
      {
        'icon': Icons.pending_actions_outlined,
        'label': 'Đề xuất\nlịch dạy',
        'color': const Color(0xFFE85D75)
      },
      {
        'icon': Icons.grid_view_rounded,
        'label': 'Tất cả',
        'color': const Color(0xFF6B4FA0)
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Chức năng',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.tune, size: 16, color: Color(0xFF616161)),
              label: const Text(
                'Tuỳ chỉnh',
                style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final item = features[index];
              final color = item['color'] as Color;
              return GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item['icon'] as IconData,
                          color: color, size: 28),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['label'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF424242),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─── Notifications ──────────────────────────────────────────
  Widget _buildNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Thông báo gần đây',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Xem tất cả',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B4FA0),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: _notifications.asMap().entries.map((entry) {
              final i = entry.key;
              final n = entry.value;
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    leading: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: (n['color'] as Color).withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(n['icon'] as IconData,
                          color: n['color'] as Color, size: 20),
                    ),
                    title: Text(
                      n['title'],
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      n['time'],
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9E9E9E)),
                    ),
                    trailing: const Icon(Icons.chevron_right,
                        color: Color(0xFFBDBDBD), size: 20),
                  ),
                  if (i < _notifications.length - 1)
                    const Divider(height: 1, indent: 70, color: Color(0xFFF0F0F0)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}