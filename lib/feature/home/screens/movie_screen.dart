part of 'screens.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderTitle(
          label: 'Genres',
          onTap: () {},
        ),
        const Gap(16),
        SizedBox(
          width: double.maxFinite,
          height: 100,
          child: ListView.separated(
            itemCount: 8,
            separatorBuilder: (context, index) => const Gap(16),
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColor.grey2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('Index ${index + 1}'),
            ),
          ),
        ),
      ],
    );
  }
}
