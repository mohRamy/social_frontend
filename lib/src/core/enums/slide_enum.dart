enum SlideEnum {
  left('left'), 
  top('top'),
  bot('bot'),
  right('right');


  final String type;
  const SlideEnum(this.type);
}

extension ConvertSlide on String {
  SlideEnum toEnum() {
    switch (this) {
      case 'left':
      return SlideEnum.left;
      case 'top':
      return SlideEnum.top;
      case 'bot':
      return SlideEnum.bot;
      case 'right':
      return SlideEnum.right;
        
      default:
      return SlideEnum.left;
    }
  }
}
