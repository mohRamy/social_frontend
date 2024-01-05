enum TypeEnum {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('gif');

  final String type;
  const TypeEnum(this.type);
}

extension ConvertMessage on String {
  TypeEnum toEnum() {
    switch (this) {
      case 'audio':
        return TypeEnum.audio;
      case 'image':
        return TypeEnum.image;
      case 'text':
        return TypeEnum.text;
      case 'gif':
        return TypeEnum.gif;
      case 'video':
        return TypeEnum.video;

      default:
        return TypeEnum.text;
    }
  }
}
