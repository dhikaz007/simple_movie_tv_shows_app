part of 'shared.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width = double.maxFinite,
    this.height = double.maxFinite,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      width: width,
      height: height,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      placeholder: (context, url) => RectangleShimmer(w: width, h: height),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: AppColor.white.withOpacity(.2),
        child: const Icon(
          Icons.error,
          color: AppColor.red,
        ),
      ),
    );
  }
}
