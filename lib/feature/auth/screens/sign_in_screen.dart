part of 'screens.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String password = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void featureDisabled() {
    AppDialog.dialogCustom(
      context,
      AlertDialog(
        backgroundColor: AppColor.white,
        title: const Center(
          child: AppText(
            text: 'Feature not available yet',
            size: FontAppSize.font_16,
            weight: FontAppWeight.medium,
            color: AppColor.primary,
          ),
        ),
        actions: [
          ButtonPrimary(
            label: 'Close',
            onPressed: () {
              Modular.to.pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: 'Email',
          size: FontAppSize.font_16,
          weight: FontAppWeight.medium,
          color: AppColor.white,
        ),
        const Gap(8),
        AppTextField(
          controller: emailController,
          radius: 20,
          hintText: 'Enter Email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const Gap(20),
        const AppText(
          text: 'Password',
          size: FontAppSize.font_16,
          weight: FontAppWeight.medium,
          color: AppColor.white,
        ),
        const Gap(8),
        AppTextField(
          controller: passwordController,
          radius: 20,
          obscure: true,
          hintText: 'Enter Password',
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
        ),
        const Gap(16),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            print(state);
            if (state is AuthLoading) {
              CustomLoading.showLoad(context);
            }
            if (state is! AuthLoading) {
              CustomLoading.hideLoad(context);
            }
            if (state is AuthLogOut) {
              print('LOGOUT SUCCESS');
            }
            if (state is AuthError) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: state.err,
              );
            }
          },
          child: GestureDetector(
            onTap: () {
              // context.read<AuthCubit>().logout();
            },
            child: const Align(
              alignment: Alignment.centerRight,
              child: AppText(
                text: 'Forgot Password',
                size: FontAppSize.font_16,
                weight: FontAppWeight.medium,
                color: AppColor.white,
              ),
            ),
          ),
        ),
        const Gap(24),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            print(state);
            if (state is AuthLoading) {
              CustomLoading.showLoad(context);
            }
            if (state is! AuthLoading) {
              CustomLoading.hideLoad(context);
            }
            if (state is AuthAuthenticated) {
              Modular.to.navigate('/home/');
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
            label: 'Sign In',
            width: double.maxFinite,
            height: 44,
            radius: 20,
            onPressed: () {
              context.read<AuthCubit>().login(
                  username: emailController.text,
                  password: passwordController.text);
            },
          ),
        ),
        const Gap(20),
        const Center(
          child: AppText(
            text: 'Or sign in with',
            size: FontAppSize.font_16,
            weight: FontAppWeight.medium,
            color: AppColor.white,
          ),
        ),
        const Gap(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                featureDisabled();
              },
              child: Transform.scale(
                scale: 1.5,
                child: SvgPicture.asset(AppIcons.icFacebook),
              ),
            ),
            InkWell(
              onTap: () {
                featureDisabled();
              },
              child: Transform.scale(
                scale: 1.5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(AppIcons.icGoogle),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                featureDisabled();
              },
              child: Transform.scale(
                scale: 1.5,
                child: SvgPicture.asset(AppIcons.icApple),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
