import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/app_localizations.dart';

/// A reusable PIN entry pad with dots and a numeric keypad.
///
/// Calls [onSubmit] once [length] digits are entered; if it resolves to false
/// the entry is cleared and an error state is shown.
class PinPad extends StatefulWidget {
  const PinPad({
    super.key,
    this.length = 4,
    required this.title,
    this.subtitle,
    required this.onSubmit,
    this.onBiometric,
  });

  final int length;
  final String title;
  final String? subtitle;
  final Future<bool> Function(String pin) onSubmit;
  final VoidCallback? onBiometric;

  @override
  State<PinPad> createState() => _PinPadState();
}

class _PinPadState extends State<PinPad> {
  String _value = '';
  bool _error = false;
  bool _busy = false;

  Future<void> _add(String digit) async {
    if (_busy || _value.length >= widget.length) return;
    HapticFeedback.selectionClick();
    setState(() {
      _error = false;
      _value += digit;
    });
    if (_value.length == widget.length) {
      _busy = true;
      final ok = await widget.onSubmit(_value);
      if (!mounted) return;
      setState(() {
        _error = !ok;
        _value = '';
        _busy = false;
      });
      if (!ok) HapticFeedback.heavyImpact();
    }
  }

  void _backspace() {
    if (_value.isEmpty) return;
    setState(() => _value = _value.substring(0, _value.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.title, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          _error
              ? AppLocalizations.of(context).incorrectPin
              : (widget.subtitle ?? ''),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: _error ? theme.colorScheme.error : null,
          ),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < widget.length; i++)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < _value.length
                      ? (_error ? theme.colorScheme.error : theme.colorScheme.primary)
                      : Colors.transparent,
                  border: Border.all(
                    color: _error
                        ? theme.colorScheme.error
                        : theme.colorScheme.outline,
                    width: 2,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 36),
        _Keypad(
          onDigit: _add,
          onBackspace: _backspace,
          onBiometric: widget.onBiometric,
        ),
      ],
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({
    required this.onDigit,
    required this.onBackspace,
    this.onBiometric,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;
  final VoidCallback? onBiometric;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.3,
        children: [
          for (var n = 1; n <= 9; n++)
            _Key(label: '$n', onTap: () => onDigit('$n')),
          onBiometric != null
              ? _Key(icon: Icons.fingerprint, onTap: onBiometric!)
              : const SizedBox.shrink(),
          _Key(label: '0', onTap: () => onDigit('0')),
          _Key(icon: Icons.backspace_outlined, onTap: onBackspace),
        ],
      ),
    );
  }
}

class _Key extends StatelessWidget {
  const _Key({this.label, this.icon, required this.onTap});

  final String? label;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surfaceContainerHighest,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Center(
          child: icon != null
              ? Icon(icon, size: 26)
              : Text(
                  label!,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
        ),
      ),
    );
  }
}
