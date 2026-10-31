import 'package:flutter/material.dart';
import 'package:weather_application/constants/app_colors.dart';
import 'package:weather_application/constants/text_styles.dart';

class ErrorAction {
  const ErrorAction({
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
}

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.message,
    required this.actions,
    this.compact = false,
  });

  factory ErrorView.retry({
    Key? key,
    required String message,
    required VoidCallback onRetry,
    bool compact = false,
  }) {
    return ErrorView(
      key: key,
      message: message,
      compact: compact,
      actions: [ErrorAction(label: 'Retry', onPressed: onRetry)],
    );
  }

  final String message;
  final List<ErrorAction> actions;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyles.subtitleText,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            IconButton(
              onPressed: actions.first.onPressed,
              icon: const Icon(Icons.refresh, color: AppColors.white),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: AppColors.grey, size: 48),
          const SizedBox(height: 16),
          Text(message, style: TextStyles.h2, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          for (final action in actions)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: 220,
                height: 48,
                child: FilledButton(
                  onPressed: action.onPressed,
                  style: FilledButton.styleFrom(
                    backgroundColor: action.isPrimary
                        ? AppColors.lightBlue
                        : AppColors.accentBlue,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(action.label),
                ),
              ),
            ),
        ],
      ),
    );
  }
}