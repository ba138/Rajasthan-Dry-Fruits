class AppException implements Exception {
  final _mesg;
  final _prefix;
  AppException([this._mesg, this._prefix]);

  String toString() {
    return '$_mesg$_prefix';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? mesg])
      : super(mesg, 'Error during communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? mesg]) : super(mesg, 'Invalid request');
}

class UnAuthorizeException extends AppException {
  UnAuthorizeException([String? mesg]) : super(mesg, 'Unauthorize request');
}
