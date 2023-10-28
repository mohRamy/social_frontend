class SocketGateway {
  static const ping = 'ping';
  static const pong = 'pong';

  // Get All Posts
  static const getAllPosts = 'get-all-posts';
  static const goneAllPosts = 'gone-all-posts';
  static const getAllPostsError = 'get-all-posts-error';

  // Change Like Post
  static const changeLikePost = 'change-like-post';
  static const changedlikePost = 'changed-like-post';
  static const changeLikePostError = 'change-like-post-error';

  // Comment Post
  static const addCommentPost = 'add-comment-post';
  static const addedCommentPost = 'added-comment-post';
  static const addCommentPostError = 'add-comment-post-error';

  // Change Like Comment Post
  static const changeLikeCommentPost = 'change-like-comment-post';
  static const changedLikeCommentPost = 'changed-like-comment-post';
  static const changeLikeCommentPostError = 'change-like-comment-post-error';

  // Change Following User
  static const changeFollowingUser = 'change-following-user';
  static const changedFollowingUser = 'changed-following-user';
  static const changeFollowingUserError = 'change-following-user-error';

  // Add Message
  static const addMessage = 'add-message';
  static const addedMessage = 'added-message';
  static const addMessageError = 'add-message-error';
}