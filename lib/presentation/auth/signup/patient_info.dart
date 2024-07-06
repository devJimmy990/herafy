import 'package:flutter/material.dart';
import 'package:herafy/core/widgets/buttons.dart';
import 'package:herafy/presentation/auth/widgets/additional_info.dart';

class PatientAdditionalInfo extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;

  const PatientAdditionalInfo({
    super.key,
    required this.onPrevious,
    required this.onSubmit,
  });

  @override
  State<PatientAdditionalInfo> createState() => _PatientAdditionalInfoState();
}

class _PatientAdditionalInfoState extends State<PatientAdditionalInfo> {
  String diet = 'Select Choice';
  String smoke = 'Select Choice';
  String sleep = 'Select Choice';
  String stress = 'Select Choice';
  String disease = 'Select Choice';
  String exercise = 'Select Choice';
  String hydration = 'Select Choice';
  String blood = 'Select Choice';
  String medication = 'Select Choice';
  String mentalHealth = 'Select Choice';
  List<String> diseaseList = [];
  List<String> medicationList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  additionalInfo(
                    value: blood,
                    title: "Blood",
                    list: [],
                    onChanged: (newVal) => setState(() => blood = newVal!),
                  ),
                  additionalInfo(
                    value: smoke,
                    title: "Smoking",
                    list: [],
                    onChanged: (newVal) => setState(() => smoke = newVal!),
                  ),
                  additionalInfo(
                    value: exercise,
                    title: "Exercise",
                    list: [],
                    onChanged: (newVal) => setState(() => exercise = newVal!),
                  ),
                  additionalInfo(
                    value: diet,
                    title: "Diet",
                    list: [],
                    onChanged: (newVal) => setState(() => diet = newVal!),
                  ),
                  additionalInfo(
                    value: sleep,
                    title: "Sleep",
                    list: [],
                    onChanged: (newVal) => setState(() => sleep = newVal!),
                  ),
                  additionalInfo(
                    value: hydration,
                    title: "Hydration",
                    list: [],
                    onChanged: (newVal) => setState(() => hydration = newVal!),
                  ),
                  additionalInfo(
                    value: stress,
                    title: "Stress",
                    list: [],
                    onChanged: (newVal) => setState(() => stress = newVal!),
                  ),
                  additionalInfo(
                    value: mentalHealth,
                    title: "Mental Health",
                    list: [],
                    onChanged: (newVal) =>
                        setState(() => mentalHealth = newVal!),
                  ),
                  customAdditionaInfo(
                    value: disease,
                    title: "Disease",
                    selectedlist: diseaseList,
                    list: [],
                    onRemove: (val) => setState(() => diseaseList.remove(val)),
                    onChanged: (newVal) {
                      setState(() {
                        disease = newVal!;
                        diseaseList.add(disease);
                      });
                    },
                  ),
                  customAdditionaInfo(
                    value: medication,
                    title: "Medication",
                    selectedlist: medicationList,
                    list: [],
                    onRemove: (val) =>
                        setState(() => medicationList.remove(val)),
                    onChanged: (newVal) {
                      setState(() {
                        medication = newVal!;
                        medicationList.add(medication);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: buildSubmitButton(
                      widthFactor: .7,
                      label: "Previous",
                      onPressed: widget.onPrevious,
                    ),
                  ),
                  const SizedBox(width: 10), // Spacer between buttons
                  Expanded(
                    child: buildSubmitButton(
                      widthFactor: .7,
                      label: "Submit",
                      onPressed: () {
                        // context.read<SignupCubit>().savePatientAdditionalData(
                        //       data: Patient.additional(
                        //         diet: diet,
                        //         smoke: smoke,
                        //         sleep: sleep,
                        //         stress: stress,
                        //         exercise: exercise,
                        //         blood: blood,
                        //         hydration: hydration,
                        //         diseases: diseaseList,
                        //         mentalHealth: mentalHealth,
                        //         medications: medicationList,
                        //       ),
                        //     );
                        // widget.onSubmit();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
