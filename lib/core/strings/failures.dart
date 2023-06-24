
import 'package:projectclean/core/error/failures.dart';
import 'package:projectclean/core/strings/messages.dart';

class ToMessages {


  static String mapFailureToMessages(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailure;
      case OffLineFailure:
        return offlineFailure;
      case EmptyCacheFailure:
        return empty;
      default:
        return 'unexpected Error,Please try again Later';
    }
  }
}