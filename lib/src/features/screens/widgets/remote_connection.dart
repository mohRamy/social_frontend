import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';
import 'package:social_app/src/themes/app_colors.dart';

class RemoteConnection extends StatefulWidget {
  final RTCVideoRenderer renderer;
  final Connection connection;
  const RemoteConnection({
    Key? key,
    required this.renderer,
    required this.connection,
  }) : super(key: key);

  @override
  State<RemoteConnection> createState() => _RemoteConnectionState();
}

class _RemoteConnectionState extends State<RemoteConnection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: RTCVideoView(
            widget.renderer,
            mirror: false,
            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          ),
        ),
        Container(
          color: widget.connection.videoEnabled!
              ? Colors.transparent
              : Colors.blueGrey[900],
          child: Center(
            child: Text(
              widget.connection.videoEnabled! ? "" : widget.connection.name!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.all(5),
            color: colorBlack,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.connection.name!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  widget.connection.audioEnabled!
                  ? Icons.mic
                  : Icons.mic_off,
                  color: mCL,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
