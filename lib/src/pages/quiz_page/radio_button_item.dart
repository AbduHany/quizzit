import 'package:flutter/material.dart';

class RadioButtonItem extends StatelessWidget {
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const RadioButtonItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: groupValue == value ? Colors.blue : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                value,
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.clip,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8.0),
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
