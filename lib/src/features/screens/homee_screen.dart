import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:social_app/src/features/screens/join_screen.dart';
import 'package:social_app/src/models/meeting_detail.dart';
import 'package:social_app/src/resources/remote/meeting_response.dart';
import 'package:social_app/src/routes/app_pages.dart';

class HomeeScreen extends StatefulWidget {
  const HomeeScreen({super.key});

  @override
  State<HomeeScreen> createState() => _HomeeScreenState();
}

class _HomeeScreenState extends State<HomeeScreen> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String meetingId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('d'),
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
            const Text(
              "wi=lcon",
            ),
            const SizedBox(height: 20),
            FormHelper.inputFieldWidget(
              context,
              "meetingId",
              "Enter your meeting Id",
              (val) {
                if (val.isEmpty) {
                  return "meeting id can't by null";
                }
                return null;
              },
              (onSaved) {
                meetingId = onSaved;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: FormHelper.submitButton(
                    "join meeting",
                    () {
                      if (validateAndSave()) {
                        validateMeeting(meetingId);
                      }
                    },
                  ),
                ),
                Flexible(
                  child: FormHelper.submitButton(
                    "start meeting",
                    () async {
                      var meetId = await startMeeting();
                      validateMeeting(meetId);
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

  void validateMeeting(String meetingId) async {
    try {
      MeetingDetail meetingDetails = await joinMeeting(meetingId);
      goToJoinScreen(meetingDetails);
    } catch (e) {
      FormHelper.showSimpleAlertDialog(
        context,
        "Meeting App",
        "Invalid Meeting Id",
        "ok",
        () {
          AppNavigator.pop();
        },
      );
    }
  }

  goToJoinScreen(MeetingDetail meetingDetail) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => JoinScreen(
          meetingDetail: meetingDetail,
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
