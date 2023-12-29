import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/meeting_detail.dart';
import '../../public/constants.dart';
import '../base_repository.dart';
import 'package:dio/dio.dart' as diox;

// var client = http.Client();

@override
Future<String> startMeeting() async {
  var userId = await loadUserId();

  var body = {
    'hostId': userId,
    'hostName': '',
  };

  diox.Response response = await BaseRepository().postRoute(
    "api/meeting/start",
    body,
  );

  String meetId = "";

  AppConstants().handleApi(
    response: response,
    onSuccess: () {
      meetId = response.data['data'];
    },
  );

  return meetId;
}

@override
Future<MeetingDetail> joinMeeting(String meetingId) async {

  diox.Response response = await BaseRepository().getRoute(
    "api/meeting/join?meetingId=$meetingId",
  );

  late MeetingDetail meetingDetail;

  AppConstants().handleApi(
    response: response,
    onSuccess: () {
      meetingDetail = MeetingDetail.formJson(response.data['data']);
    },
  );

  return meetingDetail;
}

var uuid = const Uuid();

Future<String> loadUserId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var userId;
  if (preferences.containsKey("userId")) {
    userId = preferences.getString("userId");
  } else {
    userId = uuid.v4();
    preferences.setString("userId", userId);
  }
  return userId;
}
