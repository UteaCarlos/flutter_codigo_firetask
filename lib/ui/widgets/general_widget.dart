

import 'package:flutter/material.dart';
import 'package:tasks/ui/general/colors.dart';

Widget divider3() => const SizedBox(
      height: 3,
    );
Widget divider6() => const SizedBox(
      height: 6,
    );
Widget divider10() => const SizedBox(
      height: 10,
    );
Widget divider20() => const SizedBox(
      height: 20,
    );
Widget divider30() => const SizedBox(
      height: 30,
    );
Widget divider40() => const SizedBox(
      height: 40,
    );

Widget divider3w() => const SizedBox(
      width: 3,
    );
Widget divider6w() => const SizedBox(
      width: 6,
    );
Widget divider10w() => const SizedBox(
      width: 10,
    );
Widget divider20w() => const SizedBox(
      width: 20,
    );

Widget loadingWidget() => Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: kBrandPrymaryColor,
          strokeWidth: 2.2,
        ),
      ),
    );

showSnackBarSuccess(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      backgroundColor: Colors.cyan,
      content: Row(
        children: [
          const Icon(Icons.check_box, color: Colors.white),
          divider10w(),
          Text(text),
        ],
      ),
    ),
  );
}

showSnackBarError(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      backgroundColor: Colors.redAccent,
      content: Row(
        children: [
          const Icon(Icons.warning_amber, color: Colors.white),
          divider10w(),
          Text(text),

        ],
      ),
    ),
  );
}