import 'package:flutter/material.dart';

class PersonCounter extends StatelessWidget {
  const PersonCounter({
    super.key,
    required this.theme,
    required int personCounter,
    required this.onIncrement,
    required this.onDecrement,
  }) : _personCounter = personCounter;

  final ThemeData theme;
  final int _personCounter;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Split', style: theme.textTheme.titleMedium),
        Row(
          children: [
            IconButton(
              color: theme.colorScheme.primary,
              onPressed: onDecrement,
              icon: Icon(Icons.remove),
            ),
            Text(_personCounter.toString(), style: theme.textTheme.titleMedium),
            IconButton(
              color: theme.colorScheme.primary,
              onPressed: onIncrement,
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
