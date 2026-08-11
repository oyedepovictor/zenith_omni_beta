import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routing/app_routes.dart';
import '../reusable_widgets/password_input.dart';
import '../reusable_widgets/text_input.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: Stack(
        children: [
          const SizedBox.expand(),
          Container(
            color: scheme.primary,
            height: 240,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/zenith_logo_mark (1).svg',
                    height: 60,
                  ),
                ),
                Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                    textStyle: text.headlineMedium?.copyWith(
                      color: scheme.surface,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Let\'s get you all set up',
                  style: GoogleFonts.poppins(
                    textStyle: text.bodySmall?.copyWith(color: scheme.surface),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 210,
            bottom: 0,
            left: 5,
            right: 5,
            child: Padding(
              // keeps the card from touching the left/right sides
              padding: const EdgeInsets.symmetric(horizontal: 15),
              // Pulls the card UP to overlap the green
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Full Name',
                            style: GoogleFonts.poppins(
                              textStyle: text.bodyLarge?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: 10,
                        ),
                        child: TextInput(
                          keyboardType: TextInputType.name,
                          hintText: 'John Doe',
                          prefixIcon: Icons.person_outline,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Email',
                            style: GoogleFonts.poppins(
                              textStyle: text.bodyLarge?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: 10,
                        ),
                        child: TextInput(
                          keyboardType: TextInputType.emailAddress,
                          hintText: '123abc@email.com',
                          prefixIcon: Icons.email_outlined,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Password',
                            style: GoogleFonts.poppins(
                              textStyle: text.bodyLarge?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: 10,
                        ),
                        child: PasswordInput(),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          onPressed: () {
                            context.goNamed(AppRoutes.homeScreen.name);
                            // Register logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: scheme.primary,
                            foregroundColor: scheme.surface,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Register',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: text.bodySmall,
                            ),
                            const SizedBox(width: 5),
                            TextButton(
                              onPressed: () {
                                context.pushNamed(AppRoutes.loginScreen.name);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: scheme.primary,
                                padding: EdgeInsets.zero,
                                //to remove the internal space around it
                                minimumSize: Size.zero,
                                // this is for making the text button small
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                // this is for removing margin set by flutter
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
