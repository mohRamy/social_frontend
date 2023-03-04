class ApiConstance {
  // base
  static const String baseUrl = "http://192.168.47.79:8000";
  // auth
  static const String signUp = "$baseUrl/api/signup";
  static const String signIn = "$baseUrl/api/signin";
  static const String addChat = "$baseUrl/add-chat";
  static const String isTokenValid = "$baseUrl/tokenIsValid";
  // get user data
  static const String getMyData = "$baseUrl/get-my-data";
  static const String getUserData = "$baseUrl/user-by-id";
  // post
  static const String getPost = "$baseUrl/post/";
  static const String addPost = "$baseUrl/post/add-post";
  static const String updatePost = "$baseUrl/post/update-post";
  static const String deletePost = "$baseUrl/post/delete-post";
  static const String addLikePost = "$baseUrl/post/add-like";
  static const String getCommentPost = "$baseUrl/post/get-comment";
  static const String addCommentPost = "$baseUrl/post/add-comment";
  static const String addLikeCommentPost = "$baseUrl/post/like-comment";
  // story
  static const String getStory = "$baseUrl/story/";
  static const String addStory = "$baseUrl/story/add-story";
  static const String updateStory = "$baseUrl/story/update-story";
  static const String deleteStory = "$baseUrl/story/delete-story";
  static const String addLikeStory = "$baseUrl/story/add-like";
  static const String getCommentStory = "$baseUrl/story/get-comment";
  static const String addCommentStory = "$baseUrl/story/add-comment";
  static const String addLikeCommentStory = "$baseUrl/story/like-comment";
  // profile
  static const String followUser = "$baseUrl/api/user/follow";
  static const String getUserPost = "$baseUrl/api/user/get-userpost";
  static const String modifyMyInfo = "$baseUrl/api/user/modify-data";
  static const String private = "$baseUrl/api/user/private";
  static const String changePassword = "$baseUrl/api/user/change-password";
  // search
  static const String searchUser = "$baseUrl/api/users/search";
  // message
  static const String addMessage = "$baseUrl/message/add-message";
  static const String getMyChat = "$baseUrl/chat/";
  static const String seenMessage = "$baseUrl/message/seen-message";
  static const String messageToken = "$baseUrl/send-notification";
}
