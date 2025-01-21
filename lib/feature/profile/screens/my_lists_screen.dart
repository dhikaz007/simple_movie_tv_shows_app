part of 'screens.dart';

class MyListsScreen extends StatefulWidget {
  const MyListsScreen({super.key});

  @override
  State<MyListsScreen> createState() => _MyListsScreenState();
}

class _MyListsScreenState extends State<MyListsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ListsCubit>().getLists(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: DefaultBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: kToolbarHeight),
                  child: NavigationToolbar(
                    leading: BackButton(
                      color: AppColor.white,
                      onPressed: () {
                        Modular.to.pop();
                      },
                    ),
                    middle: const AppText(
                      text: 'My Lists',
                      size: FontAppSize.font_18,
                      color: AppColor.white,
                      weight: FontAppWeight.medium,
                    ),
                  ),
                ),
              ),
              const Gap(16),
              BlocBuilder<ListsCubit, ListsState>(
                builder: (context, state) {
                  if (state.status == ListsStatus.loading) {
                    return Center(
                      child: const CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation(AppColor.red),
                      ),
                    );
                  }
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.listData.results.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: AppColor.grey,
                      ),
                      itemBuilder: (context, index) {
                        final lists = state.listData.results[index];
                        return MyListsWidget(listsModel: lists);
                      },
                    ),
                  );
                },
              ),
              const Gap(12),
              SizedBox(
                height: 50,
                width: double.maxFinite,
                child: BlocSelector<ListsCubit, ListsState, List<int>>(
                  selector: (state) {
                    return [
                      state.listData.page,
                      state.listData.totalPages,
                    ];
                  },
                  builder: (context, state) {
                    return state[1] <= 1
                        ? const SizedBox.shrink()
                        : PaginationWeb(
                            currentPage: state[0],
                            totalPage: state[1],
                            onTap: (x) {
                              context.read<ListsCubit>().getLists(page: x);
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
