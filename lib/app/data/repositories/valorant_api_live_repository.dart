// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../domain/repositories/valorant_live_repository.dart';
import '../datasource/valorant_api_live_datasource.dart';

class ValorantApiLiveRepository extends ValorantLiveRepository {
  final ValorantApiLiveDatasource datasource;
  ValorantApiLiveRepository(this.datasource);
}
