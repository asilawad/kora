import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import 'services_dimensions.dart';

final class ServicesSearchField extends StatefulWidget {
  const ServicesSearchField({
    required this.onChanged,
    this.autofocus = false,
    super.key,
  });

  final ValueChanged<String> onChanged;
  final bool autofocus;

  @override
  State<ServicesSearchField> createState() => _ServicesSearchFieldState();
}

final class _ServicesSearchFieldState extends State<ServicesSearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: ServicesDimensions.searchHeight,
    child: TextField(
      controller: _controller,
      autofocus: widget.autofocus,
      onChanged: (value) {
        widget.onChanged(value);
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.searchHint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                onPressed: _clear,
                icon: const Icon(Icons.clear),
              ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: ServicesDimensions.sectionSpacing,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ServicesDimensions.searchRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ServicesDimensions.searchRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      ),
    ),
  );
}
