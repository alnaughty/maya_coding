import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maya_coding_test/core/services/data_cacher.dart';
import 'package:maya_coding_test/firebase_options.dart';
import 'package:maya_coding_test/maya_coding_test.dart';

void main() async {
  final DataCacher _cacher = DataCacher.instance;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _cacher.initialize();
  runApp(
    ProviderScope(child: const MayaCodingTest()),
  );
}
