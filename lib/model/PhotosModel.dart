class Photosmodel {
  String imgSrc;
  String photogrphName;
  Photosmodel({
    required this.imgSrc,
    required this.photogrphName,
  });

  static Photosmodel fromApi2App(Map<String, dynamic> photoMap){
    return Photosmodel(
        imgSrc: (photoMap["src"]["portrait"]),
        photogrphName: photoMap["photographer"]); 
  }
}
