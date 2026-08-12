import 'package:flutter/material.dart';

class EffortBanner extends StatelessWidget {
  const EffortBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Color(0xFFE8F3EE), // soft green tint
      child: Padding(
        padding:  EdgeInsets.all(16),
        child: Text(
          "7 applications sent 💪 Most people land a role within 20–40 applications — you're building momentum.",
        ),
      ),
    );
  }
}
