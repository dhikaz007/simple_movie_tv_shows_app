part of 'shared.dart';

class PaginationFAB extends StatelessWidget {
  final ValueNotifier<bool> showFab;
  final Function()? onPressed;
  const PaginationFAB({
    super.key,
    required this.showFab,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showFab,
      builder: (context, value, child) => child!,
      child: AnimatedCrossFade(
        firstChild: FloatingActionButton(
          backgroundColor: AppColor.white,
          mini: true,
          onPressed: onPressed,
          child: const Icon(
            Icons.arrow_upward,
            color: AppColor.primary,
          ),
        ),
        secondChild: const SizedBox.shrink(),
        crossFadeState: showFab.value
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}
