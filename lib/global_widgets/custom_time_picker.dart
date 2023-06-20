import 'package:intl/intl.dart';
import 'package:safety_eta/common_libraries.dart';

class CustomTimePicker extends StatefulWidget {
  final DateTime? initialValue;
  final ValueChanged<DateTime> onChange;
  final double height;
  const CustomTimePicker({
    super.key,
    required this.onChange,
    this.initialValue,
    this.height = 36,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TextEditingController timeinput = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: CustomTextField(
        controller: timeinput,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            initialTime: widget.initialValue != null
                ? TimeOfDay(
                    hour: widget.initialValue!.hour,
                    minute: widget.initialValue!.minute)
                : TimeOfDay.now(),
            context: context,
          );

          if (pickedTime != null) {
            print(pickedTime.format(context)); //output 10:51 PM
            DateTime parsedTime =
                DateFormat.jm().parse(pickedTime.format(context).toString());
            //converting to DateTime so that we can further format on different pattern.
            print(parsedTime); //output 1970-01-01 22:53:00.000
            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
            print(formattedTime); //output 14:59:00
            //DateFormat() is from intl package, you can format the time on any pattern you need.

            setState(() {
              timeinput.text =
                  pickedTime.format(context); //set the value of text field.
            });

            widget.onChange(parsedTime);
          } else {
            print("Time is not selected");
          }
        },
      ),
    );
  }
}
