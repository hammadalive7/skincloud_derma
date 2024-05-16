// ignore_for_file: unused_import
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';
import '../../main.dart';
import '../../service/firebase_firestore_service.dart';
import '../../service/firebase_storage_service.dart';
import '../../service/media_service.dart';
import '../../service/notification_service.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  Uint8List? file;
  static final notifications = NotificationsService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () async {
                  final pickedImage =
                      await MediaService.pickImage();
                  setState(() => file = pickedImage!);
                },
                child: file != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: MemoryImage(file!),
                      )
                    : const CircleAvatar(
                        radius: 50,
                        backgroundColor: mainColor,
                        child: Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 40),
              TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && email.isEmpty
                        ? 'Name cannot be empty.'
                        : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                validator: (email) => email != null &&
                        !EmailValidator.validate(email)
                    ? 'Enter a valid email'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value != null && value.length < 6
                        ? 'Enter min. 6 characters'
                        : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: confirmPasswordController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    passwordController.text !=
                            confirmPasswordController.text
                        ? 'Passwords do not match'
                        : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.arrow_forward,
                      size: 32),
                  label: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: signUp),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black, fontSize: 20),
                  text: 'Already have an account?  ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: 'Log In',
                      style: TextStyle(
                        decoration:
                            TextDecoration.underline,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    if (file == null) {
      const snackBar = SnackBar(
          content: Text('Please select a profile picture'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          const Center(child: CircularProgressIndicator()),
    );

    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final image =
          await FirebaseStorageService.uploadImage(
              file!, 'image/profile/${user.user!.uid}');

      await FirebaseFirestoreService.createUser(
        image: image,
        email: user.user!.email!,
        uid: user.user!.uid,
        name: nameController.text,
        isDoctor: true,
      );

      await notifications.requestPermission();
      await notifications.getToken();
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text(e.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    navigatorKey.currentState!
        .popUntil(((route) => route.isFirst));
  }
}
