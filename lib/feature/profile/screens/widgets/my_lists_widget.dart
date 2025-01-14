part of 'widgets.dart';

class MyListsWidget extends StatelessWidget {
  final ListsModel listsModel;
  final Function()? onTap;
  const MyListsWidget({super.key, required this.listsModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColor.white,
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.grey)),
              child: CachedImage(imageUrl: listsModel.posterPath),
            ),
            const Gap(16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: '${listsModel.name}',
                    size: FontAppSize.font_14,
                    color: AppColor.black,
                    weight: FontAppWeight.medium,
                    maxLines: 2,
                  ),
                  const Gap(8),
                  AppText(
                    text: 'Type: ${listsModel.listType}',
                    size: FontAppSize.font_12,
                    color: AppColor.black,
                  ),
                  const Gap(12),
                  AppText(
                    text: 'Description: ${listsModel.description}',
                    size: FontAppSize.font_12,
                    color: AppColor.grey,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(12),
                  AppText(
                    text: 'Item: ${listsModel.itemCount}',
                    size: FontAppSize.font_12,
                    color: AppColor.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
