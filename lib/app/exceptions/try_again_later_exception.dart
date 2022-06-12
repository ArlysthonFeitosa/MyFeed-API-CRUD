import 'package:myfeed/app/interfaces/exceptions/handled_exception_interface.dart';

class TryAgainLaterException implements HandledException {
  @override
  String toString() {
    return 'Try again later';
  }
}
