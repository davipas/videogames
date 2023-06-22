import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String currentsApiKey =
      dotenv.env['CURRENTS_API_KEY'] ?? 'No hay una api key';
}
