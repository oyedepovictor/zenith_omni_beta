import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenith_omni/controller/bmi_calculator_brain.dart';
import 'package:zenith_omni/view/reusable_widgets/bmi_sliders_container.dart';
import '../../../routing/app_routes.dart';
import '../../reusable_widgets/bmi_container.dart';

enum Gender { male, female }

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  Gender? selectedGender;
  int height = 180; // Moved to state level
  int weight = 70;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 40),
                child: Row(
                  children: [
                    Hero(
                      tag: 'BMI',
                      child: SvgPicture.asset(
                        'assets/app_icons/icon_bmi_calculator.svg',
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'BMI Calculator',
                      style: GoogleFonts.poppins(
                        textStyle: textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: BMIContainer(
                        title: 'Male',
                        icon: const Icon(Icons.male_outlined),
                        isSelected: selectedGender == Gender.male,
                        onTap: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: BMIContainer(
                        title: 'Female',
                        icon: const Icon(Icons.female_outlined),
                        isSelected: selectedGender == Gender.female,
                        onTap: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BmiSlidersContainer(
                      onChanged: (newValue) {
                        setState(() {
                          height =
                              newValue; // Now your main screen "knows" the height changed!
                        });
                      },
                      title: 'Height',
                      subtitle: 'cm',
                      initialValue: height,
                      min: 120,
                      max: 230,
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BmiSlidersContainer(
                      onChanged: (newValue) {
                        setState(() {
                          weight =
                              newValue; // Now your main screen "knows" the weight changed!
                        });
                      },
                      title: 'Weight',
                      subtitle: 'kg',
                      initialValue: weight,
                      min: 20,
                      max: 250,
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BmiSlidersContainer(
                      onChanged: (newValue) {
                        setState(() {
                          age =
                              newValue; // Now your main screen "knows" the age changed!
                        });
                      },
                      title: 'Age',
                      subtitle: 'yrs',
                      initialValue: age,
                      min: 2,
                      max: 100,
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    BmiCalculatorBrain calc = BmiCalculatorBrain(
                      height: height,
                      weight: weight,
                      age: age,
                    );

                    context.pushNamed(
                      AppRoutes.resultPage.name,
                      extra: {
                        'bmiResult': calc.calculateBMI(),
                        'resultText': calc.getResult(),
                        'interpretation': calc.getInterpretation(),
                        'height': height.toString(),
                        'weight': weight.toString(),
                        'age': age.toString(),
                      },
                    );
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            'Calculate',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: scheme.surface,
                            fontWeight: FontWeight.w900,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
