
class WallpaperData {
  List<String>? all;
  List<String>? popular;
  List<String>? mangaAnime;

  WallpaperData({this.all, this.popular, this.mangaAnime});

  WallpaperData.fromJson(Map<String, dynamic> json) {
    all = json['all'].cast<String>();
    popular = json['popular'].cast<String>();
    mangaAnime = json['manga_anime'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    data['popular'] = this.popular;
    data['manga_anime'] = this.mangaAnime;
    return data;
  }
}
