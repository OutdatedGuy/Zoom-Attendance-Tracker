// Flutter Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Returns a [CupertinoDialogAction] for apple platforms, and a [TextButton]
/// for other platforms.
///
/// The [child] and [onPressed] are passed as parameters for above mentioned
/// widgets.
///
/// The [isDestructive] parameter displays the widget in a destructive style.
class AdaptiveAction extends StatelessWidget {
  /// Creates an [AdaptiveAction] widget.
  const AdaptiveAction({
    super.key,
    required this.onPressed,
    required this.child,
    this.isDestructive = false,
  });

  /// The callback to be called when the action is pressed.
  final VoidCallback? onPressed;

  /// The child widget to be displayed inside the action button.
  final Widget child;

  /// A flag to indicate if the action is destructive.
  ///
  /// Defaults to `false`.
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS || TargetPlatform.macOS:
        return CupertinoDialogAction(
          onPressed: onPressed,
          isDestructiveAction: isDestructive,
          child: child,
        );
      default:
        final destructiveColor = Theme.of(context).colorScheme.error;
        return TextButton(
          onPressed: onPressed,
          style: isDestructive
              ? TextButton.styleFrom(
                  foregroundColor: destructiveColor,
                  disabledForegroundColor: destructiveColor.withValues(
                    alpha: 0.5,
                  ),
                )
              : null,
          child: child,
        );
    }
  }
}
