part of 'screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: DefaultBackground(
        child: SafeArea(
          child: NestedScrollView(
            physics: const ClampingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverAppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: AppText(
                  text: 'Profile',
                  size: FontAppSize.font_18,
                  color: AppColor.white,
                  weight: FontAppWeight.medium,
                ),
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  print(state);
                  if (state is ProfileLoaded) {
                    return SliverToBoxAdapter(
                      child: AvatarText(
                        name: state.profile.username ?? '-',
                        size: 100,
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(
                      child: AppShimmer(
                    shape: BoxShape.circle,
                    w: 100,
                    h: 100,
                  ));
                },
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  MenuList(
                    title: 'Profile',
                    onTap: () {},
                  ),
                  const Divider(color: AppColor.white),
                  MenuList(
                    title: 'My List',
                    onTap: () {
                      Modular.to.pushNamed('/profile/lists');
                    },
                  ),
                  const Divider(color: AppColor.white),
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoading) {
                        CustomLoading.showLoad(context);
                      }
                      if (state is! AuthLoading) {
                        CustomLoading.hideLoad(context);
                      }
                      if (state is AuthLogOut) {
                        Modular.to.navigate('/');
                      }
                      if (state is AuthError) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: state.err,
                        );
                      }
                    },
                    child: MenuList(
                      title: 'Log Out',
                      onTap: () {
                        context.read<AuthCubit>().logout();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
