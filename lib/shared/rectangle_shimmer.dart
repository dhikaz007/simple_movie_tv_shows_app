part of 'shared.dart';

class RectangleShimmer extends StatelessWidget {
  final double w;
  final double h;
  final double? r;
  const RectangleShimmer({
    super.key,
    this.w = 160,
    this.h = 32,
    this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Colors.grey.withAlpha(150),
          AppColor.white.withAlpha(100),
          Colors.grey..withAlpha(150),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(r ?? 8)),
        width: w,
        height: h,
      ),
    );
  }
}
