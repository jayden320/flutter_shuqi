
// 小说章节
class Chapter {
  int id;
  String title;
  int index;

  Chapter.fromJson(Map data) {
    id = data['id'];
    title = data['title'];
    index = data['index'];
  }
}
