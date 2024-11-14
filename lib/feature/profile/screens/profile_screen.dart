part of 'screens.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: BlocListener<AuthCubit, AuthState>(
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
          child: ButtonPrimary(
            label: 'Logout',
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
          ),
        ),
      ),
    );
  }
}
