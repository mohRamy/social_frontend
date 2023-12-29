// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';

import 'package:social_app/src/core/error/handle_error_loading.dart';
import 'package:social_app/src/features/screens/view_story/domain/usecases/change_story_like.dart';

class VoiceCallController extends GetxController with HandleLoading {
  final ChangeStoryLikeUsecase changeStoryLikeUsecase;
  VoiceCallController(
    this.changeStoryLikeUsecase,
  );

  RxBool isJoined = false.obs;
  RxBool openMicrophone = true.obs;
  RxBool enableSpeaker = true.obs;
  RxString callTime = "00.00".obs;
  RxString callStatus = "not connected".obs;

  var to_taken = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var doc_id = "".obs;
  var call_role = "".obs;

  final player = AudioPlayer();
  final appId = "b3d21edbf49b4aababe10abb7a7879c9";
  // late final RtcEngine engine;

  // Future<void> initEngine() async {
  //   await player.setAsset("assets/Sound_Horizon.mp3");
  //   engine = createAgoraRtcEngine();
  //   await engine.initialize(RtcEngineContext(
  //     appId: appId,
  //   ));
  // }
}
