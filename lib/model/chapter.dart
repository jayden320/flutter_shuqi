class Chapter {
  late int id;
  late String title;
  late int index;

  Chapter.fromJson(Map data) {
    id = data['id'];
    title = data['title'];
    index = data['index'] ?? 0;
  }
}
