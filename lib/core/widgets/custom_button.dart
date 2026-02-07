import 'package:flutter/material.dart';

enum ButtonMyStyle { primary, secondary, danger, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonMyStyle style;
  final bool loading;
  final bool disabled;
  final double? width;
  final double? height;
  final double borderRadius;
  final IconData? icon;
  final bool iconAfterText;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style = ButtonMyStyle.primary,
    this.loading = false,
    this.disabled = false,
    this.width,
    this.height = 35,
    this.borderRadius = 12,
    this.icon,
    this.iconAfterText = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.fontSize,
    this.fontWeight,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnPressed = (disabled || loading) ? null : onPressed;

    // 👇 تحديد الخصائص حسب النمط (style)
    Color bgColor = _getBackgroundColor(theme);
    Color txtColor = _getTextColor(theme);
    Color brdColor = _getBorderColor(theme);
    final double elevation = style == ButtonMyStyle.text ? 0 : 2;

    return SizedBox(
      width: width,
      // width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: effectiveOnPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled ? bgColor.withValues(alpha: 0.4) : bgColor,
          foregroundColor: txtColor,
          side: style == ButtonMyStyle.outline || style == ButtonMyStyle.text
              ? BorderSide(color: brdColor, width: 1.5)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: loading ? 0 : elevation,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
          disabledBackgroundColor: bgColor.withValues(alpha: 0.3), // للوضوح عند التعطيل
        ),
        child: loading
            ? CircularProgressIndicator(
                strokeWidth: 2,
                padding: EdgeInsets.symmetric(vertical: 4),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              )
            : _buildContent(txtColor),
      ),
    );
  }

  Color _getBackgroundColor(ThemeData theme) {
    if (backgroundColor != null) return backgroundColor!;

    switch (style) {
      case ButtonMyStyle.primary:
        return theme.colorScheme.primary;
      case ButtonMyStyle.secondary:
        return theme.colorScheme.secondaryContainer;
      case ButtonMyStyle.danger:
        return Colors.red;
      case ButtonMyStyle.outline:
      case ButtonMyStyle.text:
        return Colors.transparent;
    }
  }

  Color _getTextColor(ThemeData theme) {
    if (textColor != null) return textColor!;

    switch (style) {
      case ButtonMyStyle.primary:
        return theme.colorScheme.onPrimary;
      case ButtonMyStyle.secondary:
        return theme.colorScheme.onSecondaryContainer;
      case ButtonMyStyle.danger:
        return Colors.white;
      case ButtonMyStyle.outline:
        return theme.colorScheme.primary;
      case ButtonMyStyle.text:
        return theme.colorScheme.primary;
    }
  }

  Color _getBorderColor(ThemeData theme) {
    if (borderColor != null) return borderColor!;

    switch (style) {
      case ButtonMyStyle.primary:
      case ButtonMyStyle.secondary:
      case ButtonMyStyle.danger:
        return Colors.transparent;
      case ButtonMyStyle.outline:
        return theme.colorScheme.primary;
      case ButtonMyStyle.text:
        return Colors.transparent;
    }
  }

  Widget _buildContent(Color textColor) {
    final iconWidget = icon != null ? Icon(icon, color: textColor, size: 20) : null;

    final textWidget = Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );

    if (iconWidget == null) return textWidget;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: iconAfterText
          ? [textWidget, const SizedBox(width: 8), iconWidget]
          : [iconWidget, const SizedBox(width: 8), textWidget],
    );
  }
}
