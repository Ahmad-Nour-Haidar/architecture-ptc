
import 'drop_base_items.dart';

class DropLanguages extends DropBaseItems {
  @override
  String get nameItems => 'اللغات';
  static final DropLanguages _instance = DropLanguages._internal();
  static DropLanguages get instance => _instance;
  DropLanguages._internal();
  factory DropLanguages() {
    return _instance;
  }


}
