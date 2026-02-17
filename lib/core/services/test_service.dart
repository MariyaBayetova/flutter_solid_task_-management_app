import 'package:injectable/injectable.dart';

@singleton
class TestService {
  void hello() => print("Works");
}
