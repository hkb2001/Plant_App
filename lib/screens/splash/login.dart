import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/home/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

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
    return SizedBox(
      width: 300,
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(color: Color(0xFF0C9869)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0C9869)),
          ),
        ),
        validator: (value) {
          if (!value!.isEmpty) {
            return 'Please enter your email address';
          }
          if (!value!.contains('@')) {
            return 'Please enter a valid email address';
          }
          if (RegExp(r'\d').hasMatch(value)) {
            return 'Email should not contain numbers';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return SizedBox(
      width: 300,
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Color(0xFF0C9869)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0C9869)),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password';
          }
          if (!RegExp(r'[!@#\$%\^&\*(),.?":{}|<>]').hasMatch(value)) {
            return 'Password should contain at least one special character';
          }
          return null;
        },
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
          onPressed: () async {
            // Sign in with Google and retrieve the UserCredential
            final UserCredential userCredential = await _signInWithGoogle();

            // Get the user details
            final user = userCredential.user;

            // Display a welcome message with the user's name
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Welcome ${user!.displayName}!'),
              ),
            );
          },
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

class FirebaseInitializer {
  static Future<FirebaseApp> initialize() async {
    final FirebaseApp app = await Firebase.initializeApp();
    return app;
  }
}
