enum NotificationEnum {
  post('post'), 
  story('story'),
  message('message'),
  comment('comment'),
  like('like');

  final String type;
  const NotificationEnum(this.type);
}

extension ConvertNotification on String {
  NotificationEnum toEnum() {
    switch (this) {
      case 'post':
      return NotificationEnum.post;
      case 'story':
      return NotificationEnum.story;
      case 'message':
      return NotificationEnum.message;
      case 'comment':
      return NotificationEnum.comment;
      case 'like':
      return NotificationEnum.like;
        
      default:
      return NotificationEnum.message;
    }
  }
}
