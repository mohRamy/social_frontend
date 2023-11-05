class UserNotification {
  final String imageUrl;
  final String content;
  final String time;

  UserNotification({
    required this.imageUrl,
    required this.content,
    required this.time,
  });
}

List<UserNotification> notifications = [
  UserNotification(
      imageUrl: 'assets/goalcast.png',
      content: 'Goalcast posted a video',
      time: '3 hours ago'),
  UserNotification(
      imageUrl: 'assets/playstation.jpg',
      content: 'Playstation posted a video',
      time: '8 hours ago'),
  UserNotification(
      imageUrl: 'assets/xbox.jpeg',
      content: 'Xbox posted a video',
      time: '9 hours ago'),
  UserNotification(
      imageUrl: 'assets/reddit.png',
      content: 'Reddit posted a video',
      time: '22 hours ago'),
  UserNotification(
      imageUrl: 'assets/linkedIn.jpg',
      content: 'Linkedin posted a video',
      time: '1 day ago'),
  UserNotification(
      imageUrl: 'assets/goalcast.png',
      content: 'Goalcast posted a video',
      time: '4 days ago'),
  UserNotification(
      imageUrl: 'assets/reddit.png',
      content: 'Reddit posted a video',
      time: '6 days ago'),
  UserNotification(
      imageUrl: 'assets/xbox.jpeg',
      content: 'Xbox posted a video',
      time: '1 week ago'),
  UserNotification(
      imageUrl: 'assets/linkedIn.jpg',
      content: 'Linkedin posted a video',
      time: '3 weeks ago'),
  UserNotification(
      imageUrl: 'assets/playstation.jpg',
      content: 'Playstation posted a video',
      time: '1 month ago')
];
