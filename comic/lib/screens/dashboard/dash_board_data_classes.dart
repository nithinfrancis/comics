class Comic {
  Comic({
    required this.month,
    required this.num,
    required this.link,
    required this.year,
    required this.news,
    required this.safeTitle,
    required this.transcript,
    required this.alt,
    required this.img,
    required this.title,
    required this.day,
  });
  late final String month;
  late final int num;
  late final String link;
  late final String year;
  late final String news;
  late final String safeTitle;
  late final String transcript;
  late final String alt;
  late final String img;
  late final String title;
  late final String day;

  Comic.fromJson(Map<String, dynamic> json){
    month = json['month'];
    num = json['num'];
    link = json['link'];
    year = json['year'];
    news = json['news'];
    safeTitle = json['safe_title'];
    transcript = json['transcript'];
    alt = json['alt'];
    img = json['img'];
    title = json['title'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['month'] = month;
    _data['num'] = num;
    _data['link'] = link;
    _data['year'] = year;
    _data['news'] = news;
    _data['safe_title'] = safeTitle;
    _data['transcript'] = transcript;
    _data['alt'] = alt;
    _data['img'] = img;
    _data['title'] = title;
    _data['day'] = day;
    return _data;
  }
}