import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:social_app/src/themes/app_colors.dart';

class ControlPanel extends StatelessWidget {
  final bool? voidEnabled;
  final bool? audioEnabled;
  final bool? isConnectionFailed;
  final VoidCallback? onVideoToggle;
  final VoidCallback? onAudioToggle;
  final VoidCallback? onReconnect;
  final VoidCallback? onMeetingEnd;
  const ControlPanel({
    Key? key,
    required this.voidEnabled,
    required this.audioEnabled,
    required this.isConnectionFailed,
    required this.onVideoToggle,
    required this.onAudioToggle,
    required this.onReconnect,
    required this.onMeetingEnd,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buildControls(),
      ),
    );
  }

  List<Widget> buildControls() {
    if (!isConnectionFailed!) {
      return <Widget>[
        IconButton(
          onPressed: onVideoToggle,
          icon: Icon(
            voidEnabled! ? Icons.videocam : Icons.videocam_off,
          ),
        ),
        IconButton(
          onPressed: onAudioToggle,
          icon: Icon(
            audioEnabled! ? Icons.mic : Icons.mic_off,
          ),
        ),
        const SizedBox(width: 25),
        Container(
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          child: IconButton(
            onPressed: onMeetingEnd!,
            icon: Icon(
              Icons.call_end,
              color: mCL,
            ),
          ),
        ),
      ];
    } else {
      return <Widget>[
        FormHelper.submitButton(
          "Reconnect",
          onReconnect!,
          btnColor: Colors.red,
          borderRadius: 10,
          width: 200,
          height: 40,
        ),
      ];
    }
  }
}
