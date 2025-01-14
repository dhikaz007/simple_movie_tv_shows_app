part of 'shared.dart';

class AvatarText extends StatelessWidget {
  final String name;
  final double size;
  const AvatarText({
    super.key,
    required this.name,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    String formatName = name.split(' ').map((e) {
      if (e.isEmpty) {
        print('CONTAINS STRING ON LAST TEXT');
        return '';
      }
      return e[0];
    }).join();

    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: AppColor.white,
        shape: BoxShape.circle,
      ),
      child: AppText(
        text: formatName,
        size: FontAppSize.font_28,
        color: AppColor.black,
        weight: FontAppWeight.medium,
      ),
    );
  }
}
