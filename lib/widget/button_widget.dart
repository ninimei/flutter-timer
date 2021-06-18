import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 100),
          primary: Colors.white,
          shape: CircleBorder(side: BorderSide(color: Colors.white)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.more_time,
              size: 28,
              color: Colors.black,
            ),
            const SizedBox(width: 4),
            Text(
              'Start',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
        onPressed: onClicked,
      );
}
