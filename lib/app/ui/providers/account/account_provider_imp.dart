import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insane_bolt/app/data/datasource/valorant_api_auth_datasource.dart';
import 'package:insane_bolt/app/data/repositories/valorant_api_auth_repository.dart';

final accountProviderImp = Provider(
    (ref) => ValorantApiAuthRepositoryImp(ValorantApiAuthDatasource()));
