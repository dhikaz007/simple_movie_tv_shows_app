part of 'shared.dart';

class DefaultBackground extends StatelessWidget {
  final Widget? child;
  const DefaultBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightForFinite(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.primary,
            AppColor.primary.withAlpha(205),
          ],
        ),
      ),
      child: child,
    );
  }
}
