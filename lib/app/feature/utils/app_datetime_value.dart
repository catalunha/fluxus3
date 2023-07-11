import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateTimeValue extends StatelessWidget {
  final String title;
  final DateTime? value;
  final String format;
  final bool inColumn;
  const AppDateTimeValue({
    Key? key,
    required this.title,
    required this.value,
    this.inColumn = false,
    this.format = 'dd/MM/y HH:mm',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat(format);

    if (inColumn) {
      return Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.blueGrey),
          ),
          Center(
            child: Text(
              // value ?? '...',
              value != null ? dateFormat.format(value!) : '...',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else {
      // return Row(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     Text(
      //       title,
      //       style: const TextStyle(color: Colors.blueGrey),
      //     ),
      //     Text(
      //       // value ?? '...',
      //       value != null && value!.isNotEmpty ? value! : '...',
      //       style: const TextStyle(color: Colors.white),
      //       textAlign: TextAlign.center,
      //       softWrap: true,
      //     ),
      //   ],
      // );

      return RichText(
        text: TextSpan(
          text: title,
          style: const TextStyle(color: Colors.blueGrey),
          children: <InlineSpan>[
            TextSpan(
                text: value != null ? dateFormat.format(value!) : '...',
                style: const TextStyle(color: Colors.white))
          ],
        ),
      );
    }
  }
}
