part of 'shared.dart';

class PaginationFAB extends StatelessWidget {
  final ValueNotifier<bool> showFab;
  final Function()? onPressed;
  const PaginationFAB({
    super.key,
    required this.showFab,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showFab,
      builder: (context, value, _) => AnimatedCrossFade(
        firstChild: FloatingActionButton(
          backgroundColor: AppColor.white,
          mini: true,
          onPressed: onPressed,
          child: const Icon(
            Icons.arrow_upward,
            color: AppColor.red,
          ),
        ),
        secondChild: const SizedBox.shrink(),
        crossFadeState:
            value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}
