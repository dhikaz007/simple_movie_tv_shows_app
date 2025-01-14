part of 'shared.dart';

class AppShimmer extends StatelessWidget {
  final double w;
  final double h;
  final double r;
  final BoxShape shape;
  const AppShimmer({
    super.key,
    this.w = 160,
    this.h = 32,
    this.r = 8,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          AppColor.grey.withAlpha(150),
          AppColor.white.withAlpha(100),
          AppColor.grey..withAlpha(150),
        ],
      ),
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius:
              shape == BoxShape.rectangle ? BorderRadius.circular(r) : null,
          shape: shape,
        ),
      ),
    );
  }
}
