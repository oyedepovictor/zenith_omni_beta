import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenith_omni/view/reusable_widgets/password_input.dart';
import 'package:zenith_omni/view/reusable_widgets/text_input.dart';
import '../../routing/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    height: 50,
                  ),
                ),
                Text(
                  'Welcome',
                  style: GoogleFonts.poppins(
                    textStyle: text.headlineMedium?.copyWith(
                      color: scheme.surface,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Login to continue your journey',
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
                      blurRadius: 10,
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: const Offset(0, -2), // Shadow pushed upwards
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
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: scheme.primary,
                            foregroundColor: scheme.surface,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Next',
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
                              "Don't have an account?",
                              style: GoogleFonts.poppins(
                                textStyle: text.bodySmall,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(width: 5),
                            TextButton(
                              onPressed: () {
                                context.pushNamed(
                                  AppRoutes.registerScreen.name,
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: scheme.primary,
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Register',
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
          ), // 2. THE FLOATING WHITE CARD (Your provided code)
        ],
      ),
    );
  }
}
