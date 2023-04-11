import 'package:flutter/material.dart';
import 'package:flutter_application/common/utils/utils.dart';
import 'package:flutter_application/common/values/colors.dart';
import 'package:flutter_application/common/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignInState();
}

class _SignInState extends State<SignUpPage> {
  final TextEditingController _fullnameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  _handleNavPop() {
    Navigator.pop(context);
  }

  _handleSignup() {
    if (!duIsEmail(_emailController.text)) {
      toastInfo(msg: '请输入正确的邮箱！');
      return;
    }
    if (!duCheckStringLength(_fullnameController.text, 6)) {
      toastInfo(msg: '请输入正确的用户长度！需大于6位');
      return;
    }
    if (!duCheckStringLength(_passController.text, 9)) {
      toastInfo(msg: '请输入正确的密码长度！需大于9位');
      return;
    }
  }

  /// logo
  Widget _buildLoago() {
    return Container(
      margin: EdgeInsets.only(top: duSetHeight(50)),
      child: Text(
        'Sign Up',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: AppFonts.primaryFamily,
          fontWeight: FontWeight.w600,
          fontSize: duSetFontSize(24),
          // height: 1
        ),
      ),
    );
  }

  /// 注册表单
  Widget _buildInputForm() {
    return Container(
      width: duSetWidth(295),
      margin: EdgeInsets.only(top: duSetHeight(50)),
      child: Column(
        children: [
          inputTextEdit(
              controller: _fullnameController,
              hintText: 'Full Name',
              keyboardType: TextInputType.text),
          inputTextEdit(
              controller: _fullnameController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress),
          inputTextEdit(
              controller: _fullnameController,
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              isPassword: true),
          Container(
            height: duSetHeight(45),
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: btnFlatButtonWidget(
                onPressed: _handleSignup,
                width: duSetWidth(295),
                fontWeight: FontWeight.w600,
                title: 'Create an account'),
          ),
          Container(
            height: duSetHeight(45),
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: const Text('asdasd'),
          )
        ],
      ),
    );
  }

  /// 注册 第三方
  _buildThirdPartyLogin() {
    return Container(
        width: duSetWidth(295),
        margin: EdgeInsets.only(bottom: duSetHeight(40)),
        child: Padding(
            padding: EdgeInsets.only(top: duSetHeight(20)),
            child: Row(
              children: [
                btnFlatButtonBorderOnlyWidget(
                    onPressed: () {}, iconFileName: 'twitter'),
                const Spacer(),
                btnFlatButtonBorderOnlyWidget(
                    onPressed: () {}, iconFileName: 'google'),
                const Spacer(),
                btnFlatButtonBorderOnlyWidget(
                    onPressed: () {}, iconFileName: 'facebook'),
              ],
            )));
  }

  /// 已存在用户
  _buildHaveAccountButton() {
    return Container(
      margin: EdgeInsets.only(bottom: duSetHeight(25)),
      child: btnFlatButtonWidget(
          title: 'I have an account',
          fontSize: duSetFontSize(16),
          width: 280,
          fontWeight: FontWeight.w500,
          onPressed: _handleNavPop,
          gbColor: AppColors.secondaryElement,
          fontColor: AppColors.secondaryElementText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppBar(context: context, actions: [
        IconButton(
            onPressed: () {
              toastInfo(msg: '这是注册界面！');
            },
            icon: const Icon(Icons.info_outline))
      ]),
      body: Center(
        child: Column(
          children: [
            const Divider(height: 1),
            _buildLoago(),
            _buildInputForm(),
            _buildThirdPartyLogin(),
            const Spacer(),
            _buildHaveAccountButton()
          ],
        ),
      ),
    );
  }
}
