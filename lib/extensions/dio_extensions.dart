part of 'extensions.dart';

extension DioExtensions on DioException {
  String msgDioErr() {
    if (response == null) {
      return "$error";
    }

    int? statusCode = response?.statusCode;
    String msg;

    if (statusCode == 404) {
      msg = "Not Found";
    } else if (statusCode == 422 || statusCode == 400) {
      if (response?.data['results'] == null) {
        msg = response?.data['message'];
      } else {
        msg = response?.data.entries.first.value[0] ?? "Kesalahan Request Data";
      }
    } else if (statusCode.toString().startsWith("5")) {
      msg = "Terjadi Kesalahan. (KODE ERR: 5xx)";
    } else {
      msg = "Terjadi Kesalahan.";
    }
    return msg;
  }
}
