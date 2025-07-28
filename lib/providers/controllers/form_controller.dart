import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageProvider = StateProvider<String?>((ref) => null);
final isLoadingProvider = StateProvider<bool>((ref) => false);

//   proveedor de dio
