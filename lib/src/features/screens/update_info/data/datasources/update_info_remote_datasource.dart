import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/screens/auth/data/models/auth_model.dart';
import 'package:social_app/src/services/socket/socket_emit.dart';

import '../../../../../resources/base_repository.dart';

abstract class UpdateInfoRemoteDataSource {
  Future<Unit> updateInfo(AuthModel userInfo);
}

class UpdateInfoRemoteDataSourceImpl extends UpdateInfoRemoteDataSource {
  final BaseRepository baseRepository;
  UpdateInfoRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> updateInfo(AuthModel userInfo) async {
    SocketEmit().updateUserInfo(userInfo);
    // var body = {
    //   "name": userInfo.name,
    //   "bio": userInfo.bio,
    //   "email": userInfo.email,
    //   "address": userInfo.address,
    //   "phone": userInfo.phone,
    //   "photo": userInfo.photo,
    //   "backgroundImage": userInfo.backgroundImage,
    // };

    // diox.Response response = await baseRepository.postRoute(
    //   ApiGateway.updateUserInfo,
    //   body,
    // );

    // AppConstants().handleApi(
    //   response: response,
    //   onSuccess: () {},
    // );

    return Future.value(unit);
  }
}
