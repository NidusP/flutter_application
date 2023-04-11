import 'package:flutter/material.dart';
import 'package:flutter_application/common/entities/entities.dart';
import 'package:flutter_application/common/utils/security.dart';
import 'package:flutter_application/common/values/values.dart';

import '../../common/apis/apis.dart';
import '../../common/utils/utils.dart';
import '../../common/widgets/widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  Widget _buildLoago() {
    return Container(
      width: duSetWidth(110),
      margin: EdgeInsets.only(top: duSetHeight(40 + 44.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: duSetWidth(76),
            height: duSetHeight(76),
            margin: EdgeInsets.symmetric(horizontal: duSetWidth(15)), // 水平方向
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: duSetHeight(76),
                      decoration: BoxDecoration(
                          color: AppColors.secondaryElement,
                          boxShadow: const [Shadows.primaryShadow],
                          borderRadius: BorderRadius.all(
                              Radius.circular(duSetWidth(76 * 0.5)))),
                      child: Image.asset("assets/images/logo.png"),
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: const Text(
              'SECTOR',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: AppFonts.primaryFamily,
                  fontWeight: FontWeight.w600,
                  // duSetFontSize(size)
                  fontSize: 24,
                  height: 1),
            ),
          ),
          const Text('news',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: AppFonts.secondaryFamily,
                  fontWeight: FontWeight.w400,
                  // duSetFontSize(size)
                  fontSize: 16,
                  height: 1))
        ],
      ),
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();

  _handleSignin() {
    if (!duIsEmail(_emailController.text)) {
      _emailFocusNode.requestFocus();
      toastInfo(msg: '请输入正确的邮箱！');
      return;
    }
    if (!duCheckStringLength(_passwordController.text, 9)) {
      toastInfo(msg: '请输入正确的密码长度！');
      return;
    }

  UserRequestEntity params = UserRequestEntity(email: 'email', password: duSHA256(_passwordController.text));
    UserAPI.login(
            params: params)
        .then((value) { 
      toastInfo(msg: value.toString());
    }).catchError((onError) {
      toastInfo(msg: onError.toString());
    });
  }

  _handleSignup() {
    Navigator.pushNamed(context, '/sign-up');
  }

  /// 登录注册
  Widget _buildInputForm() {
    return Container(
      width: duSetWidth(295),
      margin: EdgeInsets.only(top: duSetHeight(50)),
      child: Column(
        children: [
          inputTextEdit(
              focusNode: _emailFocusNode,
              controller: _emailController,
              hintText: 'Email',
              marginTop: 0,
              keyboardType: TextInputType.emailAddress),
          inputTextEdit(
              controller: _passwordController,
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              isPassword: true),
          Container(
            height: duSetHeight(44),
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: Row(
              children: [
                btnFlatButtonWidget(
                    onPressed: _handleSignup,
                    gbColor: AppColors.thirdElement,
                    title: 'Sign up'),
                const Spacer(),
                btnFlatButtonWidget(
                    onPressed: _handleSignin,
                    gbColor: AppColors.primaryElement,
                    title: 'Sign in')
              ],
            ),
          ),
          Container(
            height: duSetHeight(22),
            margin: EdgeInsets.only(top: duSetHeight(20)),
            child: MaterialButton(
              onPressed: () {},
              child: Text(
                'Fogot password?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.thirdElement,
                  fontFamily: AppFonts.secondaryFamily,
                  fontWeight: FontWeight.w400,
                  fontSize: duSetFontSize(16),
                  // height: 1
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 第三方登录
  Widget _buildThirdPartyLogin() {
    return Container(
      width: duSetWidth(295),
      margin: EdgeInsets.only(bottom: duSetHeight(40)),
      child: Column(
        children: [
          Text(
            'Or sign in width social networks',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppFonts.secondaryFamily,
                fontWeight: FontWeight.w400,
                fontSize: duSetFontSize(16)),
          ),
          Padding(
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
              ))
        ],
      ),
    );
  }

  /// 注册按钮
  Widget _buildSignupButton() {
    return Container(
      margin: EdgeInsets.only(bottom: duSetHeight(20)),
      child: btnFlatButtonWidget(
          onPressed: () {
            _handleSignup();
          },
          width: 294,
          gbColor: AppColors.secondaryElement,
          fontColor: AppColors.primaryText,
          title: 'sign up',
          fontWeight: FontWeight.w500,
          fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            _buildLoago(),
            _buildInputForm(),
            const Spacer(),
            _buildThirdPartyLogin(),
            _buildSignupButton()
          ],
        ),
      ),
    );
  }
}
