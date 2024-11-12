part of 'shared.dart';

enum SnackBarStatus { success, failure, warning }

class AppDialog {
  static void showSnackbar(
    BuildContext context,
    String message,
    SnackBarStatus? type, {
    bool dismissable = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: type == SnackBarStatus.success
            ? Colors.green.withOpacity(.9)
            : type == SnackBarStatus.failure
                ? Colors.red.withOpacity(.9)
                : type == SnackBarStatus.warning
                    ? Colors.yellowAccent.withOpacity(.9)
                    : null,
        action: dismissable
            ? SnackBarAction(
                label: 'Dismiss',
                onPressed: () => Modular.to.pop(),
                textColor: type == null ? AppColor.black : AppColor.white,
              )
            : null,
        margin: const EdgeInsets.only(
          bottom: 20,
          right: 20,
          left: 20,
        ),
        dismissDirection: DismissDirection.none,
        content: AppText(
          text: message,
          size: FontAppSize.font_16,
          weight: FontAppWeight.normal,
          color: AppColor.white,
          maxLines: 2,
        ),
      ),
    );
  }

  static void dialogCustom(BuildContext context, Widget child) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (context, anim, anim2) => child,
      transitionBuilder: (context, anim, anim2, child) => ScaleTransition(
        scale: anim,
        child: child,
      ),
    );
  }
}
