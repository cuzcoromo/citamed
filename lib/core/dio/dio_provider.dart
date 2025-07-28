// ← (opcional) provider Riverpod

import 'package:citamed/core/dio/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) => createDioClient());
