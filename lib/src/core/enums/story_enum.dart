enum StoryEnum {
  image('image'),
  video('video');

  final String type;
  const StoryEnum(this.type);
}

extension ConvertMessage on String {
  StoryEnum toEnum() {
    switch (this) {
      case 'image':
      return StoryEnum.image;
      case 'video':
      return StoryEnum.video;
      default:
      return StoryEnum.image;
    }
  }
}
