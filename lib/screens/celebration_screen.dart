import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CelebrationScreen extends StatelessWidget {
  final String title;
  final String company;
  final bool isResilience;

  const CelebrationScreen({
    super.key,
    required this.title,
    required this.company,
    required this.isResilience,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kSpace32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isResilience ? '🔥' : '🎉',
                style: const TextStyle(fontSize: 72),
              ),
              const SizedBox(height: kSpace24),
              Text(
                isResilience
                    ? 'You applied again after a rejection.\nThat\'s resilience.'
                    : 'Application sent!\nYou\'re officially in the game.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: kFontHeading,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: kSpace16),
              Text(
                isResilience
                    ? 'It takes 20–40 applications on average. '
                        'You\'re building momentum.'
                    : 'Applied to: $title at $company',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: kFontBody,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: kSpace32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRadiusButton)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Keep going →'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
