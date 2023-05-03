import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/home/home_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildEmailField(),
            const SizedBox(height: 16),
            _buildPasswordField(),
            const SizedBox(height: 24),
            _buildLoginButton(context),
            const SizedBox(height: 16),
            const Divider(
              thickness: 1,
              indent: 32,
              endIndent: 32,
            ),
            const Text(
              "OR",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _buildSocialLoginButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return const SizedBox(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(color: Color(0xFF0C9869)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0C9869))),

          // focusedBorder: BoxDecoration(color: Colors.green)
          // border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return const SizedBox(
      width: 300,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Color(0xFF0C9869)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0C9869)),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 60,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0C9869)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
        child: const Text(
          'Login',
        ),
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialLoginButton(
          onPressed: () {},
          logoPath: 'assets/images/google_logo.svg',
        ),
        const SizedBox(width: 16),
        _buildSocialLoginButton(
          onPressed: () {},
          logoPath: 'assets/images/facebook_logo.svg',
        ),
      ],
    );
  }

  Widget _buildSocialLoginButton({
    required VoidCallback onPressed,
    required String logoPath,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(12),
      ),
      child: SvgPicture.asset(
        logoPath,
        width: 40,
        height: 40,
      ),
    );
  }
}
