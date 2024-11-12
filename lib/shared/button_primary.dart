part of 'shared.dart';

class ButtonPrimary extends StatelessWidget {
  final String label;
  final Widget? child;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final double? radius;
  final double? elevation;
  const ButtonPrimary({
    super.key,
    required this.label,
    this.child,
    this.onPressed,
    this.width,
    this.height,
    this.radius,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: AppColor.orange.withOpacity(.5),
        backgroundColor: AppColor.orange,
        fixedSize: Size(width ?? double.maxFinite, height ?? 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 20),
        ),
        elevation: elevation ?? 0,
      ),
      onPressed: onPressed,
      child: child ??
          AppText(
            text: label,
            size: FontAppSize.font_16,
            weight: FontAppWeight.medium,
            color: AppColor.black,
          ),
    );
  }
}
