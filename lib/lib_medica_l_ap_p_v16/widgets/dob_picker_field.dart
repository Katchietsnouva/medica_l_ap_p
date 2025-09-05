// lib/widgets/dob_picker_field.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';

class DobPickerField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DobPickerField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
  });

  Future<void> _selectDate_(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final primaryColor = AppTheme.primaryColor; // or any color you want
    final theme = Theme.of(context);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // colorScheme: ColorScheme.light(primary: primaryColor),
            colorScheme: theme.colorScheme,
            textButtonTheme: TextButtonThemeData(
              // style: TextButton.styleFrom(foregroundColor: primaryColor),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
              ),
              // style: theme.colorScheme.primary,),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          // labelStyle: const TextStyle(color: AppTheme.subtleTextColor),
          labelStyle:
              TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6)),
          filled: true,
          fillColor: theme.inputDecorationTheme.fillColor,
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(12),
          //   // borderSide: BorderSide(color: Colors.grey.shade300),
          // ),
          border: theme.inputDecorationTheme.border,
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(12),
          // borderSide: BorderSide(color: Colors.grey.shade300),
          // ),
          enabledBorder: theme.inputDecorationTheme.enabledBorder,
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(12),
          //   borderSide:
          //       const BorderSide(color: AppTheme.primaryColor, width: 2),
          // ),
          focusedBorder: theme.inputDecorationTheme.focusedBorder,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? 'Select Date'
                  : DateFormat('dd MMM, yyyy').format(selectedDate!),
              style: TextStyle(
                color: selectedDate == null
                    ? theme.colorScheme.onSurface.withOpacity(0.6)
                    : theme.colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
            const Icon(Icons.calendar_today, color: AppTheme.subtleTextColor),
          ],
        ),
      ),
    );
  }
}
