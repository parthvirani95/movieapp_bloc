import 'package:movieapp_bloc/presentation/app_localizations.dart';

extension StringExtension on String {
  //2
  String intelliTrim() {
    //3
    return this.length > 15 ? '${this.substring(0, 15)}...' : this;
  }

  String? t(context) {
    return AppLocalizations.of(context)!.translate(this);
  }
}
