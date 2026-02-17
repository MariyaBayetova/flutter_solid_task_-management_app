import 'package:injectable/injectable.dart';

@singleton
class NotificationService {
  void notify(String message) {
    print("NOTIFICATION: $message");
  }
}
