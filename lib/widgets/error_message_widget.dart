import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/config/themes/colors.dart';
import 'package:ricky_and_martie_app/widgets/retry_button.dart';

class ErrorMessageWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final VoidCallback? onRetry;
  final String? retryButtonText;

  const ErrorMessageWidget({
    required this.icon,
    required this.title,
    super.key,
    this.message,
    this.onRetry,
    this.retryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: MyColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 60,
                color: MyColors.error,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MyColors.lightGray,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null && _shouldShowMessage(message!)) ...[
              const SizedBox(height: 12),
              Text(
                message!,
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.lightGray,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              RetryButton(
                onPressed: onRetry!,
                text: retryButtonText ?? 'Tentar Novamente',
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Verifica se deve mostrar a mensagem de erro (filtra mensagens técnicas)
  bool _shouldShowMessage(String message) {
    final technicalTerms = [
      'exception',
      'status code',
      'requestoptions',
      'validateStatus',
      'dioexception',
      'developer.mozilla.org',
      'mozilla developer network'
    ];

    final lowerMessage = message.toLowerCase();
    return !technicalTerms.any((term) => lowerMessage.contains(term));
  }
}
