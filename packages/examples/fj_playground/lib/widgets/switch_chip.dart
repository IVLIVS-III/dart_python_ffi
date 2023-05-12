import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class SwitchChip extends StatelessWidget {
  const SwitchChip({
    Key? key,
    required this.value,
    this.onChanged,
    required this.label,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String label;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onChanged?.call(!value),
        child: Chip(
          label: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(label),
          ),
          backgroundColor: value
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          side: value
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                )
              : BorderSide(color: Theme.of(context).dividerColor),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>("value", value))
      ..add(ObjectFlagProperty<ValueChanged<bool>?>.has("onChanged", onChanged))
      ..add(StringProperty("label", label));
  }
}
