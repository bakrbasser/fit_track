import 'package:fit_track/core/presentation/resources/assets_manager.dart';
import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/core/presentation/utils/snack_bar_helper.dart';
import 'package:fit_track/presentation/widgets/cards.dart';
import 'package:flutter/material.dart';

Future<int?> showDaysDialog(BuildContext context) async {
  final TextEditingController controller = TextEditingController();
  return showDialog<int>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('How many days in your plan'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'e.g. 3'),
          style: FontsManager.lexendRegular(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancel
            child: Text('Cancel', style: FontsManager.lexendRegular(size: 16)),
          ),
          TextButton(
            onPressed: () {
              final input = int.tryParse(controller.text);
              if (input == null) {
                SnackBarHelper.showMessage(
                  context,
                  'You entered invalid number of days',
                );
              }
              Navigator.of(context).pop(input); // Return input
            },
            child: Text('OK', style: FontsManager.lexendRegular(size: 16)),
          ),
        ],
      );
    },
  );
}

Future<String?> showIconsDialog(BuildContext context) async {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: ColorsManager.black,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: IconsManager.allIcons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
            ),
            itemBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlanIcon(icon: IconsManager.allIcons[index]),
                ),
          ),
        ),
      );
    },
  );
}
