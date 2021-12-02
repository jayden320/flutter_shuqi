class NovelComment {
  late String nickname;
  late String avatar;
  late String content;

  NovelComment.fromJson(Map data) {
    nickname = data['nickName'];
    avatar = data['userPhoto'];
    content = data['text'];
  }
}
