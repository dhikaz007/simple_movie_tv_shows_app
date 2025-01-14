part of 'widgets.dart';

class MenuList extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const MenuList({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      leading: const Icon(
        Icons.list,
        color: AppColor.white,
      ),
      title: AppText(
        text: title,
        size: FontAppSize.font_14,
        color: AppColor.white,
        weight: FontAppWeight.medium,
      ),
      trailing: Transform.flip(
        flipX: true,
        child: const BackButton(
          color: AppColor.white,
          onPressed: null,
        ),
      ),
      onTap: onTap,
    );
  }
}
