import 'package:http/http.dart' as http;
import '../../../../core/utils/app_strings.dart';

import '../../../../data/api/api_client.dart';

class SearchRepo {
  final ApiClient apiClient;
  SearchRepo({
    required this.apiClient,
  });
  Future<http.Response> fetchSearchUser({
    required String searchQuery,
  }) async {
    return await apiClient.getData(
      '${AppString.BASE_URL}/api/users/search/$searchQuery',
    );
  }
}
