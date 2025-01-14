part of 'widgets.dart';

class SeachShimmer extends StatelessWidget {
  const SeachShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(8),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: 120,
            height: 160,
            decoration: BoxDecoration(
              // color: AppColor.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const AppShimmer(),
          ),
          const Gap(12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppShimmer(h: 20),
                const Gap(4),
                const AppShimmer(h: 20),
                const Gap(4),
                const AppShimmer(h: 20),
                const Gap(4),
                const AppShimmer(h: 20),
                const Gap(8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(
                    iconAlignment: IconAlignment.end,
                    onPressed: () {},
                    style:
                        const ButtonStyle(visualDensity: VisualDensity.compact),
                    icon: const CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColor.white,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: AppColor.black,
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColor.white,
                          size: 14,
                        ),
                      ),
                    ),
                    label: const AppText(
                      text: 'See Detail',
                      size: FontAppSize.font_12,
                      color: AppColor.white,
                      weight: FontAppWeight.medium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
