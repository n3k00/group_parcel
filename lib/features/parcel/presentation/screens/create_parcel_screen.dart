import 'package:flutter/material.dart';

import '../../../../core/constants/parcel_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../widgets/parcel_form_view.dart';
import '../widgets/parcel_next_action_button.dart';

class CreateParcelScreen extends StatelessWidget {
  const CreateParcelScreen({super.key});

  static const routeName = '/parcel/create';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: ParcelStrings.homeTitle,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const ParcelNextActionButton(),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: const [ParcelFormView()],
      ),
    );
  }
}
