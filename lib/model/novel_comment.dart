class NovelComment {
  String nickname;
  String avatar;
  String content;

  NovelComment.fromJson(Map data) {
    nickname = data['nickName'];
    avatar = data['userPhoto'];
    content = data['text'];
  }
}
