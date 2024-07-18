import 'package:double_tap/app/data/datasource/valorant_api_auth_datasource.dart';
import 'package:double_tap/app/data/repositories/valorant_api_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProviderImp =
    Provider((ref) => ValorantApiAuthRepository(ValorantApiAuthDatasource()));
