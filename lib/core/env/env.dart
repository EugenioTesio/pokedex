import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final firebaseApiKey = dotenv.get('FIREBASE_API_KEY', fallback: '');
}
