import 'package:flutter/material.dart';
import 'package:driver/Locale/locales.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final Widget onPress;
  final double width;
  final Widget prefixIcon;
  final double iconGap;
  final double height;
  final Function onTap;
  final Color color;
  final double border;
  final Color textColor;

  CustomButton({
    this.label,
    this.onPress,
    this.width,
    this.prefixIcon,
    this.iconGap,
    this.height,
    this.onTap,
    this.color,
    this.border,
    this.textColor,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height ?? 56,
        decoration: BoxDecoration(
          color: widget.color ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(widget.border ?? 0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.prefixIcon ?? SizedBox.shrink(),
            SizedBox(width: widget.iconGap),
            Center(
              child: Text(
                widget.label ?? locale.continueText.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: widget.textColor ??
                        Theme.of(context).scaffoldBackgroundColor,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
