part of 'widgets.dart';

class HeaderTitle extends StatelessWidget {
  final String label;
  final GestureTapCallback? onTap;
  const HeaderTitle({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: label,
          size: FontAppSize.font_14,
          weight: FontAppWeight.bold,
          color: AppColor.white,
        ),
        InkWell(
          onTap: onTap,
          child: const AppText(
            text: 'See all',
            size: FontAppSize.font_14,
            weight: FontAppWeight.normal,
            color: AppColor.orange,
          ),
        ),
      ],
    );
  }
}
