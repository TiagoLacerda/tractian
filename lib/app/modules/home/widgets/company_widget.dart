import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_icons.dart';
import '../models/company.dart';

class CompanyWidget extends StatelessWidget {
  final Company company;
  final void Function(BuildContext)? onPressed;

  const CompanyWidget({
    super.key,
    required this.company,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed == null ? null : () => onPressed!.call(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 32.0,
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.company,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              '${company.name} Unit',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
