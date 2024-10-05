
import 'package:logger/logger.dart';


final logger = Logger(
  filter: null,
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart
  ),
  output: null
);