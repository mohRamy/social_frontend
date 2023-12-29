import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:social_app/src/features/screens/meeting_screen.dart';

import 'package:social_app/src/models/meeting_detail.dart';

class JoinScreen extends StatefulWidget {
  final MeetingDetail? meetingDetail;
  const JoinScreen({
    Key? key,
    required this.meetingDetail,
  }) : super(key: key);

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String userName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('join meeting'),
      ),
      body: Form(
        key: globalKey,
        child: formUi(),
      ),
    );
  }

  formUi() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            FormHelper.inputFieldWidget(
              context,
              "userId",
              "Enter your Name",
              (val) {
                if (val.isEmpty) {
                  return "Name can't by null";
                }
                return null;
              },
              (onSaved) {
                userName = onSaved;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: FormHelper.submitButton(
                    "join",
                    () {
                      if (validateAndSave()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MeetingScreen(
                                meetingId: widget.meetingDetail!.id,
                                name: userName,
                                meetingDetail: widget.meetingDetail!,
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
