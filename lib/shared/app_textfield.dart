part of 'shared.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscure;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? radius;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputAction? textInputAction;
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.suffixIcon,
    this.prefixIcon,
    this.radius,
    this.onSubmitted,
    this.onChanged,
    this.textInputFormatter,
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final ValueNotifier<bool> showPass = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: showPass,
      builder: (_, __, ___) => TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscure ? showPass.value : false,
        inputFormatters: widget.textInputFormatter,
        textInputAction: widget.textInputAction,
        style: const TextStyle(
          fontSize: 12,
          color: AppColor.white,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 0),
            borderSide: const BorderSide(
              color: AppColor.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 0),
            borderSide: const BorderSide(
              color: AppColor.white,
            ),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon ??
              (widget.obscure == false
                  ? null
                  : InkWell(
                      onTap: () => showPass.value = !showPass.value,
                      child: showPass.value
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.visibility_outlined),
                    )),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 12,
            color: AppColor.white,
          ),
        ),
        onSubmitted: widget.onSubmitted,
        onChanged: widget.onChanged,
      ),
    );
  }
}
