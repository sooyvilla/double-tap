import 'package:double_tap/app/data/datasource/valorant_api_live_datasource.dart';
import 'package:double_tap/app/data/repositories/valorant_api_live_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final liveProviderImp =
    Provider((ref) => ValorantApiLiveRepository(ValorantApiLiveDatasource()));
