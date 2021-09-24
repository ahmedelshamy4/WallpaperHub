class WallPaperModel {
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  SrcModel? src;
  WallPaperModel({
    this.src,
    this.photographerUrl,
    this.photographerId,
    this.photographer,
  });
  factory WallPaperModel.formMap(Map<String, dynamic> jsonData) {
    return WallPaperModel(
      src: SrcModel.formMap(jsonData['src']),
      photographer: jsonData['photographer'],
      photographerUrl: jsonData['photographer_url'],
      photographerId: jsonData[' photographer_id'],
    );
  }
}

class SrcModel {
  String original;
  String small;
  String portrait;
  SrcModel(
      {required this.original, required this.small, required this.portrait});
  factory SrcModel.formMap(Map<String, dynamic> srcJson) {
    return SrcModel(
      portrait: srcJson['portrait'],
      small: srcJson['medium'],
      original: srcJson['landscape'],
    );
  }
}
