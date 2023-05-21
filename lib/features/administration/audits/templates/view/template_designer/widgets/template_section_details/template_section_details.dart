import '/common_libraries.dart';
import 'widgets/widgets.dart';

class TemplateSectionDetails extends StatelessWidget {
  const TemplateSectionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    // return SingleChildScrollView(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       const Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 8),
    //         child: Text(
    //           'Template section details',
    //           style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.w600,
    //           ),
    //         ),
    //       ),
    //       const CustomDivider(height: 30),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           const Text(
    //             'Visual Wiring Inspection',
    //             style: TextStyle(fontSize: 22),
    //           ),
    //           ElevatedButton(
    //             style: ElevatedButton.styleFrom(
    //               backgroundColor: Colors.blue,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(5),
    //               ),
    //             ),
    //             onPressed: () {},
    //             child: const Padding(
    //               padding: EdgeInsets.symmetric(
    //                 horizontal: 20,
    //                 vertical: 10,
    //               ),
    //               child: Text(
    //                 'New Question',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       const SizedBox(height: 50),
    //       const Question(
    //           question: 'Are there any loose hanging wires from the ceiling?'),
    //       const Question(
    //           question: 'Is there any signs of any damage to circuit box?'),
    //       const Question(
    //           question: 'Are there any outlets that seem to be damaged?'),
    //     ],
    //   ),
    // );
  }
}
