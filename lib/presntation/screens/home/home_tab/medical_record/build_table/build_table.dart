import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/utils/color_manager.dart';

class CustomDataTable extends StatelessWidget {
  final List<List<String>> rows;

  const CustomDataTable({Key? key, required this.rows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return SizedBox.shrink();

    // أول صف هو العناوين
    final headers = rows.first;
    final dataRows = rows.sublist(1);

    Widget _textRow(String text, {bool isHeader = false}) {
      return Container(
        color: isHeader ? ColorsManager.lightBlue2 : Colors.transparent,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: isHeader ? 14 : 12,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
              color: isHeader
                  ? ColorsManager.blue2
                  : Theme.of(context).colorScheme.primaryFixed,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: true,
          ),
        ),
      );
    }

    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10.h, horizontal: 1),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(flex: 2, child: _textRow(headers[0], isHeader: true)),
              Expanded(flex: 4, child: _textRow(headers[1], isHeader: true)),
              Expanded(flex: 2, child: _textRow(headers[2], isHeader: true)),
            ],
          ),
          SizedBox(height: 8.h),
          ...dataRows.map((row) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(flex: 2, child: _textRow(row[0])),
                    Expanded(flex: 4, child: _textRow(row[1])),
                    Expanded(flex: 2, child: _textRow(row[2])),
                  ],
                ),
                SizedBox(height: 8.h),
                Divider(
                    color: ColorsManager.hint, thickness: 0.8.w, height: 0.2.h),
                SizedBox(height: 8.h),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
