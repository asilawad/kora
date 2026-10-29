import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../home/domain/entities/intake_field_entity.dart';
import '../booking_dimensions.dart';

final class IntakeFieldsForm extends StatefulWidget {
  const IntakeFieldsForm({
    required this.fields,
    required this.onAnswersChanged,
    super.key,
  });

  final List<IntakeFieldEntity> fields;
  final ValueChanged<Map<String, dynamic>> onAnswersChanged;

  @override
  State<IntakeFieldsForm> createState() => _IntakeFieldsFormState();
}

final class _IntakeFieldsFormState extends State<IntakeFieldsForm> {
  final Map<String, String> _values = {};

  void _emitAnswers(IntakeFieldEntity field, String value) {
    _values[field.key] = value.trim();
    final answers = <String, dynamic>{};
    for (final field in widget.fields) {
      final answer = _values[field.key];
      if (answer == null || answer.isEmpty) continue;
      answers[field.key] =
          field.type == 'number' ? int.parse(answer) : answer;
    }
    widget.onAnswersChanged(answers);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return Column(
      children: [
        for (final field in widget.fields)
          Padding(
            padding: const EdgeInsets.only(
              bottom: BookingDimensions.itemSpacing,
            ),
            child: _IntakeFieldInput(
              field: field,
              label: locale == 'ar' ? field.labelAr : field.labelEn,
              onChanged: (value) => _emitAnswers(field, value),
            ),
          ),
      ],
    );
  }
}

final class _IntakeFieldInput extends StatelessWidget {
  const _IntakeFieldInput({
    required this.field,
    required this.label,
    required this.onChanged,
  });

  final IntakeFieldEntity field;
  final String label;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => TextField(
    onChanged: onChanged,
    keyboardType: field.type == 'number'
        ? TextInputType.number
        : TextInputType.text,
    inputFormatters: field.type == 'number'
        ? [FilteringTextInputFormatter.digitsOnly]
        : null,
    decoration: InputDecoration(
      labelText: label,
      suffixText: field.unit,
    ),
  );
}
