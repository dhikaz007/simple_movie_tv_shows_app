part of 'screens.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  String password = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: 'Full Name',
          size: FontAppSize.font_16,
          weight: FontAppWeight.medium,
          color: AppColor.white,
        ),
        const Gap(8),
        AppTextField(
          controller: fullNameController,
          radius: 20,
          hintText: 'Enter Full Name',
          textInputAction: TextInputAction.next,
        ),
        const Gap(20),
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
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
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
        const Gap(20),
        Theme(
          data: ThemeData(
            listTileTheme: const ListTileThemeData(
              horizontalTitleGap: 8,
            ),
          ),
          child: CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColor.red,
            checkColor: AppColor.white,
            visualDensity: VisualDensity.compact,
            title: RichText(
              text: const TextSpan(
                text: 'I agree with the ',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.grey,
                ),
                children: [
                  TextSpan(
                    text: 'Terms of Use ',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.red,
                    ),
                  ),
                  TextSpan(
                    text: 'and ',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.grey,
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy ',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.red,
                    ),
                  ),
                ],
              ),
            ),
            value: isChecked,
            onChanged: (value) => setState(() => isChecked = value ?? false),
          ),
        ),
        const Gap(12),
        ButtonPrimary(
          label: 'Sign Up',
          width: double.maxFinite,
          height: 44,
          radius: 20,
          onPressed: isChecked == false
              ? null
              : () {
                  if (password.isEmpty) {
                    null;
                  } else {
                    Modular.to.navigate('/home/');
                  }
                },
        ),
      ],
    );
  }
}
