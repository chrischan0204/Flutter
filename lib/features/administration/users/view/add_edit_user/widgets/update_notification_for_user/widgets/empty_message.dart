import 'package:safety_eta/common_libraries.dart';

class EmptyMessageView extends StatelessWidget {
  const EmptyMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: insetx20,
          child: const Text(
            'This user has no sites assigned to it yet.',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const CustomDivider(),
        Padding(
          padding: insetx20,
          child: const Text(
            'Sites can be assigned by editing the user and going to the sites tab to select from available users',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const CustomDivider(),
      ],
    );
  }
}
