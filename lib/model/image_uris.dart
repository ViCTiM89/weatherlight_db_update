class ImageUris {
  final String normal;
  final String large;
  final String artCrop;

  ImageUris({
    required this.normal,
    required this.large,
    required this.artCrop,
  });

  factory ImageUris.fromMap(Map<String, dynamic> e){
    return ImageUris(
      normal: e['normal'],
      large: e['large'],
      artCrop: e['art_crop'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'normal': normal,
      'large': large,
      'art_crop': artCrop,
    };
  }
}