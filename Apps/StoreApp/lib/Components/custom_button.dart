import 'package:flutter/material.dart';
import 'package:vendor/Locale/locales.dart';
class CustomButton extends StatefulWidget {
  final String label;
  final Widget onPress;
  final double width;
  final Widget prefixIcon;
  final double iconGap;
  final double height;
  final Function onTap;
  final Color color;

  CustomButton({
    this.label,
    this.onPress,
    this.width,
    this.prefixIcon,
    this.iconGap,
    this.height,
    this.onTap,
    this.color,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: widget.onTap ??
          () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => widget.onPress));
          },
      child: Container(
        width: widget.width,
        height: widget.height,
        color: widget.color ?? Theme.of(context).primaryColor,
        padding: EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.prefixIcon != null ? widget.prefixIcon : SizedBox.shrink(),
            SizedBox(width: widget.iconGap),
            Text(
              widget.label ?? locale.continueText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
