
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color shadowColor;
  final double width;
  final double height;

  CustomButton({
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.shadowColor,
    double? height,
    double? width,
  })  : height = height ?? 6.h,
        width = width ?? 80.w;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _onClickBool = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _onClickBool = true);
      },
      onTapCancel: () {
        setState(() => _onClickBool = false);
      },
      onTap: () {
        setState(() => _onClickBool = true);
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() => _onClickBool = false);
          widget.onPressed();
        });
      },
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        height: widget.height + 5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(color: widget.shadowColor, borderRadius: BorderRadius.circular(180)),
              ),
            ),
            AnimatedPositioned(
              child: Container(
                alignment: Alignment.center,
                height: widget.height,
                width: widget.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(180)),
                child: widget.child,
              ),
              duration: Duration(milliseconds: 100),
              bottom: _onClickBool ? 0 : 5,
            ),
          ],
        ),
      ),
    );
  }
}
