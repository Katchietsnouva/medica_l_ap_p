// components/steps/beno_form_stepper.dart
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/components/ui/beno_ui_components.dart';
import 'package:flutter/material.dart';

// const Color primaryColor = Color(0xFFD02030);

class BenoFormStepper extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const BenoFormStepper(
      {super.key, required this.currentStep, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(steps.length, (index) {
            final isActive = index + 1 <= currentStep;
            final isCompleted = index + 1 < currentStep;
            return Expanded(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: isActive ? primaryColor : Colors.grey[300],
                    // child: Text(
                    //   '${index + 1}',
                    //   style: TextStyle(
                    //       color: isActive ? Colors.white : Colors.black),
                    // ),
                    child: isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : Text('${index + 1}',
                            style: TextStyle(
                                color: isActive ? Colors.white : Colors.black)),
                  ),
                  const SizedBox(height: 8),
                  // Text(
                  //   steps[index],
                  //   style: TextStyle(
                  //     color: isActive ? Colors.blue : Colors.grey,
                  //     fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  //   ),
                  // ),
                  Text(steps[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: isActive
                              ? (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              : Colors.grey,
                          fontWeight:
                              isActive ? FontWeight.bold : FontWeight.normal)),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
