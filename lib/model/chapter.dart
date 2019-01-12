
class Chapter {
  String id;
  String name;

  Chapter.fromJson(Map data) {
    id = data['chapterId'];
    name = data['chapterName'];
  }
}
