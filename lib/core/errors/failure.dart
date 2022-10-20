class Failure {
  const Failure(this.errorMessage);
  final String errorMessage;
  @override
  String toString() {
    return errorMessage;
  }
}
