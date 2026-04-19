import 'package:flutter/material.dart';

// ─────────────────────────── DATA MODEL ───────────────────────────

enum AttendanceStatus { chuaDiemDanh, daDiemDanh, vang }

class AttendanceItem {
  final String subjectName;
  final String tiet;
  final String lop;
  final String phong;
  AttendanceStatus status;

  AttendanceItem({
    required this.subjectName,
    required this.tiet,
    required this.lop,
    required this.phong,
    this.status = AttendanceStatus.chuaDiemDanh,
  });
}

// ═══════════════════════════════════════════════════════════════════
//  ATTENDANCE LIST SCREEN
// ═══════════════════════════════════════════════════════════════════

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int _bottomIndex = 2;

  final List<AttendanceItem> _items = [
    AttendanceItem(
      subjectName: 'Thực hành quản trị hệ thống mạng',
      tiet: '1→6',
      lop: '14DHTH05',
      phong: 'A205 - Phòng máy tính - 140 Lê Trọng Tấn',
    ),
    AttendanceItem(
      subjectName: 'Lập trình di động',
      tiet: '7→11',
      lop: '14DHTH10',
      phong: 'A104 - Phòng máy tính - 140 Lê Trọng Tấn',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: _items.isEmpty
                ? _buildEmpty()
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (_, i) => _buildCard(_items[i]),
                  ),
          ),
        ],
      ),
      
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: const Color(0xFF1565C0),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: 14,
      ),
      child: const Center(
        child: Text(
          'Điểm danh',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildCard(AttendanceItem item) {
    Color statusColor;
    String statusText;
    switch (item.status) {
      case AttendanceStatus.chuaDiemDanh:
        statusColor = const Color(0xFFE65100);
        statusText = 'Chưa điểm danh';
        break;
      case AttendanceStatus.daDiemDanh:
        statusColor = const Color(0xFF2E7D32);
        statusText = 'Đã điểm danh';
        break;
      case AttendanceStatus.vang:
        statusColor = const Color(0xFFC62828);
        statusText = 'Vắng';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.subjectName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 10),
          _infoRow('Tiết :', item.tiet),
          const SizedBox(height: 5),
          _infoRow('Lớp :', item.lop),
          const SizedBox(height: 5),
          _infoRow('Phòng :', item.phong),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (item.status == AttendanceStatus.chuaDiemDanh)
                ElevatedButton(
                  onPressed: () => _openAttendanceSheet(item),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Điểm danh',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                )
              else
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.status == AttendanceStatus.daDiemDanh
                        ? '✓ Hoàn thành'
                        : '✗ Vắng',
                    style: TextStyle(
                        color: statusColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(label,
              style:
                  const TextStyle(fontSize: 13, color: Color(0xFF757575))),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121)),
          ),
        ),
      ],
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Text(
        'Không có môn học cần điểm danh',
        style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
      ),
    );
  }

  // ── Open bottom sheet ─────────────────────────────────────────
  void _openAttendanceSheet(AttendanceItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AttendanceMethodSheet(
        item: item,
        onSuccess: () {
          setState(() => item.status = AttendanceStatus.daDiemDanh);
        },
      ),
    );
  }

}

// ═══════════════════════════════════════════════════════════════════
//  ATTENDANCE METHOD BOTTOM SHEET  (Quét QR / Nhập mã)
// ═══════════════════════════════════════════════════════════════════

class AttendanceMethodSheet extends StatefulWidget {
  final AttendanceItem item;
  final VoidCallback onSuccess;

  const AttendanceMethodSheet({
    super.key,
    required this.item,
    required this.onSuccess,
  });

  @override
  State<AttendanceMethodSheet> createState() => _AttendanceMethodSheetState();
}

class _AttendanceMethodSheetState extends State<AttendanceMethodSheet> {
  // 0 = QR, 1 = Nhập mã
  int _mode = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: Color(0xFF1565C0),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 0,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.white, size: 24),
                ),
                const Expanded(
                  child: Text(
                    'Nhập mã',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // White content area
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: _mode == 0 ? _buildQRView() : _buildCodeView(),
            ),
          ),
          const SizedBox(height: 16),

          // Bottom tabs: Quét QR / Nhập mã
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).padding.bottom + 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _mode = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: _mode == 0
                            ? Colors.white
                            : Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_scanner,
                              color: _mode == 0
                                  ? const Color(0xFF1565C0)
                                  : Colors.white,
                              size: 20),
                          const SizedBox(width: 6),
                          Text(
                            'Quét QR',
                            style: TextStyle(
                              color: _mode == 0
                                  ? const Color(0xFF1565C0)
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _mode = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: _mode == 1
                            ? Colors.white
                            : Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.keyboard_alt_outlined,
                              color: _mode == 1
                                  ? const Color(0xFF1565C0)
                                  : Colors.white,
                              size: 20),
                          const SizedBox(width: 6),
                          Text(
                            'Nhập mã',
                            style: TextStyle(
                              color: _mode == 1
                                  ? const Color(0xFF1565C0)
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── QR View ──────────────────────────────────────────────────
  Widget _buildQRView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // QR illustration
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // QR corners decoration
              CustomPaint(
                size: const Size(200, 200),
                painter: _QRCornerPainter(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_2_rounded,
                      size: 100, color: const Color(0xFF1565C0).withOpacity(0.3)),
                  const SizedBox(height: 8),
                  const Text(
                    'Hướng camera vào mã QR',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Đưa mã QR vào khung hình để quét',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF616161),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {
            // Simulate QR scan success
            _handleSuccess();
          },
          icon: const Icon(Icons.qr_code_scanner),
          label: const Text('Mở Camera'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1565C0),
            foregroundColor: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  // ── Code Entry View ──────────────────────────────────────────
  Widget _buildCodeView() {
    return _CodeEntryForm(
      onSubmit: (code) {
        if (code.isNotEmpty) _handleSuccess();
      },
    );
  }

  void _handleSuccess() {
    Navigator.pop(context);
    widget.onSuccess();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Điểm danh thành công!'),
          ],
        ),
        backgroundColor: const Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}

// ── Code Entry Form (stateful for controller) ─────────────────────

class _CodeEntryForm extends StatefulWidget {
  final void Function(String code) onSubmit;
  const _CodeEntryForm({required this.onSubmit});

  @override
  State<_CodeEntryForm> createState() => _CodeEntryFormState();
}

class _CodeEntryFormState extends State<_CodeEntryForm> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Illustration
          SizedBox(
            height: 180,
            child: CustomPaint(
              painter: _SecurityIllustrationPainter(),
              size: const Size(200, 180),
            ),
          ),
          const SizedBox(height: 32),
          // Input field
          TextField(
            controller: _ctrl,
            keyboardType: TextInputType.number,
            maxLength: 6,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Nhập mã',
              hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
              counterText: '',
              suffixIcon: const Icon(Icons.volume_up_outlined,
                  color: Color(0xFF9E9E9E)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color(0xFF1565C0), width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
            ),
          ),
          const SizedBox(height: 16),
          // Submit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _ctrl.text.isNotEmpty
                  ? () => widget.onSubmit(_ctrl.text)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                disabledBackgroundColor: const Color(0xFFBBDEFB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Gửi mã',
                style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── CUSTOM PAINTERS ───────────────────────────

class _QRCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1565C0)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const corner = 20.0;
    const offset = 10.0;

    // Top-left
    canvas.drawPath(
        Path()
          ..moveTo(offset, offset + corner)
          ..lineTo(offset, offset)
          ..lineTo(offset + corner, offset),
        paint);
    // Top-right
    canvas.drawPath(
        Path()
          ..moveTo(size.width - offset - corner, offset)
          ..lineTo(size.width - offset, offset)
          ..lineTo(size.width - offset, offset + corner),
        paint);
    // Bottom-left
    canvas.drawPath(
        Path()
          ..moveTo(offset, size.height - offset - corner)
          ..lineTo(offset, size.height - offset)
          ..lineTo(offset + corner, size.height - offset),
        paint);
    // Bottom-right
    canvas.drawPath(
        Path()
          ..moveTo(size.width - offset - corner, size.height - offset)
          ..lineTo(size.width - offset, size.height - offset)
          ..lineTo(size.width - offset, size.height - offset - corner),
        paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _SecurityIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final cx = size.width / 2;

    // Phone body
    paint.color = const Color(0xFFBBDEFB);
    final phone = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx - 20, size.height * 0.5),
          width: 90, height: 130),
      const Radius.circular(12),
    );
    canvas.drawRRect(phone, paint);

    // Phone screen
    paint.color = const Color(0xFF90CAF9);
    final screen = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx - 20, size.height * 0.5),
          width: 74, height: 110),
      const Radius.circular(8),
    );
    canvas.drawRRect(screen, paint);

    // Shield
    paint.color = const Color(0xFF1565C0);
    final shieldPath = Path();
    final sx = cx + 10.0;
    final sy = size.height * 0.12;
    shieldPath.moveTo(sx, sy);
    shieldPath.lineTo(sx + 22, sy + 8);
    shieldPath.lineTo(sx + 22, sy + 26);
    shieldPath.quadraticBezierTo(sx + 22, sy + 38, sx, sy + 44);
    shieldPath.quadraticBezierTo(sx - 22, sy + 38, sx - 22, sy + 26);
    shieldPath.lineTo(sx - 22, sy + 8);
    shieldPath.close();
    canvas.drawPath(shieldPath, paint);

    // Check on shield
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;
    paint.strokeCap = StrokeCap.round;
    final checkPath = Path();
    checkPath.moveTo(sx - 10, sy + 22);
    checkPath.lineTo(sx - 2, sy + 30);
    checkPath.lineTo(sx + 12, sy + 16);
    canvas.drawPath(checkPath, paint);

    // Stars (asterisks placeholder)
    paint.style = PaintingStyle.fill;
    paint.color = const Color(0xFF1565C0).withOpacity(0.7);
    for (int i = 0; i < 4; i++) {
      canvas.drawCircle(
          Offset(cx - 30 + i * 16.0, size.height * 0.42), 5, paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}