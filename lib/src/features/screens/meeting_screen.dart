import 'package:flutter/material.dart';
import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';
import 'package:social_app/src/config/application.dart';
import 'package:social_app/src/features/screens/homee_screen.dart';
import 'package:social_app/src/features/screens/widgets/controller_panel.dart';
import 'package:social_app/src/features/screens/widgets/remote_connection.dart';

import 'package:social_app/src/models/meeting_detail.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:social_app/src/resources/remote/meeting_response.dart';

class MeetingScreen extends StatefulWidget {
  final String? meetingId;
  final String? name;
  final MeetingDetail meetingDetail;
  const MeetingScreen({
    Key? key,
    this.meetingId,
    this.name,
    required this.meetingDetail,
  }) : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  final _localRenderer = RTCVideoRenderer();
  final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      }
    };
  bool isConnectionFailed = false;
  WebRTCMeetingHelper? meetingHelper;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: _buildMeetingRoom(),
      bottomNavigationBar: ControlPanel(
        onAudioToggle: onAudioToggle,
        onVideoToggle: onVideoToggle,
        voidEnabled: isVideoEnabled(),
        audioEnabled: isAudioEnabled(),
        isConnectionFailed: isConnectionFailed,
        onReconnect: handleReconnect,
        onMeetingEnd: onMeetingEnd,
      ),
    );
  }

  void startMeeting() async {
    final String userId = await loadUserId();
    meetingHelper = WebRTCMeetingHelper(
      url: Application.baseUrl,
      meetingId: widget.meetingDetail.id,
      userId: userId,
      name: widget.name,
    );
    MediaStream _localStream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
        print('local stream');

    _localRenderer.srcObject = _localStream;
    meetingHelper!.stream = _localStream;

    meetingHelper!.on(
      "open",
      context,
      (ev, context) {
        setState(() {
          isConnectionFailed = false;
        });
      },
    );

    meetingHelper!.on(
      "connection",
      context,
      (ev, context) {
        setState(() {
          isConnectionFailed = false;
        });
      },
    );

    meetingHelper!.on(
      "user-left",
      context,
      (ev, context) {
        setState(() {
          isConnectionFailed = false;
        });
      },
    );

    meetingHelper!.on(
      "video-toggle",
      context,
      (ev, context) {
        setState(() {});
      },
    );

    meetingHelper!.on(
      "audio-toggle",
      context,
      (ev, context) {
        setState(() {});
      },
    );

    meetingHelper!.on(
      "meeting-ended",
      context,
      (ev, context) {
        onMeetingEnd();
      },
    );

    meetingHelper!.on(
      "connection-setting-changed",
      context,
      (ev, context) {
        setState(() {
          isConnectionFailed = false;
        });
      },
    );

    meetingHelper!.on(
      "stream-changed",
      context,
      (ev, context) {
        setState(() {
          isConnectionFailed = false;
        });
      },
    );

    setState(() {});
  }

  initRenderers() async {
    await _localRenderer.initialize();
  }

  @override
  void initState() {
    super.initState();
    initRenderers();
    startMeeting();
  }

  @override
  void deactivate() {
    super.deactivate();
    _localRenderer.dispose();
    if (meetingHelper != null) {
      meetingHelper!.destroy();
      meetingHelper = null;
    }
  }

  void onMeetingEnd() {
    if (meetingHelper != null) {
      meetingHelper!.endMeeting();
      meetingHelper = null;
      goToHomeeScreen();
    }
  }

  _buildMeetingRoom() {
    return Stack(
      children: [
        meetingHelper != null && meetingHelper!.connections.isNotEmpty
            ? GridView.count(
                crossAxisCount: meetingHelper!.connections.length < 3 ? 1 : 2,
                children:
                    List.generate(meetingHelper!.connections.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(1),
                    child: RemoteConnection(
                      renderer: meetingHelper!.connections[index].renderer,
                      connection: meetingHelper!.connections[index],
                    ),
                  );
                }),
              )
            : const Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Waiting for participants to join the meeting',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
        Positioned(
          bottom: 10,
          right: 0,
          child: SizedBox(
            width: 150,
            height: 200,
            child: RTCVideoView(
              _localRenderer,
            ),
          ),
        )
      ],
    );
  }

  void onAudioToggle() {
    if (meetingHelper != null) {
      setState(() {
        meetingHelper!.toggleAudio();
      });
    }
  }

  void onVideoToggle() {
    if (meetingHelper != null) {
      setState(() {
        meetingHelper!.toggleVideo();
      });
    }
  }

  void handleReconnect() {
    if (meetingHelper != null) {
      meetingHelper!.reconnect();
    }
  }

  bool isAudioEnabled() {
    return meetingHelper != null ? meetingHelper!.audioEnabled! : false;
  }

  bool isVideoEnabled() {
    return meetingHelper != null ? meetingHelper!.videoEnabled! : false;
  }

  void goToHomeeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeeScreen(),
      ),
    );
  }
}
