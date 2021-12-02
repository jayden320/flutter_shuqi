class Article {
  late int id;
  late int novelId;
  late String title;
  late String content;
  late int price;
  late int index;
  late int nextArticleId;
  late int preArticleId;

  late List<Map<String, int>> pageOffsets;

  Article.fromJson(Map data) {
    id = data['id'];
    novelId = data['novel_id'];
    title = data['title'];
    content = data['content'];
    content = '　　' + content;
    content = content.replaceAll('\n', '\n　　');
    price = data['welth'] ?? 0;
    index = data['index'];
    nextArticleId = data['next_id'];
    preArticleId = data['prev_id'];
  }

  String stringAtPageIndex(int index) {
    var offset = pageOffsets[index];
    return this.content.substring(offset['start']!, offset['end']);
  }

  int get pageCount {
    return pageOffsets.length;
  }
}
