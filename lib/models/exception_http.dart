class ExceptionHttp implements Exception {
  final String messege;
  ExceptionHttp(this.messege);
  @override
  String toString() {
    return messege;
  }
}
