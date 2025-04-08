class RMUrls {
  RMUrls._();
  static const String baseUrl = "https://rickandmortyapi.com/api/";

  static String constructUrl({int? pageIndex, required String feature}) {
    if (pageIndex != null) {
      return '$baseUrl$feature/?page=$pageIndex';
    } else {
      return '$baseUrl$feature';
    }
  }
}
