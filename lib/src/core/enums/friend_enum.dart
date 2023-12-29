enum UserCaseEnum {
  userRequest('userRequest'),
  myRequest('myfRequest'), 
  friend('friend'),
  notrequestAndFriend('notrequestAndFriend');

  final String type;
  const UserCaseEnum(this.type);
}

extension ConvertFriend on String {
  UserCaseEnum toEnum() {
    switch (this) {
      case 'userRequest':
      return UserCaseEnum.userRequest;
      case 'myfRequest':
      return UserCaseEnum.myRequest;
      case 'friend':
      return UserCaseEnum.friend;
      case 'notrequestAndFriend':
      return UserCaseEnum.notrequestAndFriend;
        
      default:
      return UserCaseEnum.notrequestAndFriend;
    }
  }
}
