import '../../../../../../common_libraries.dart';

class ResponseScalesRepository extends BaseRepository {
  ResponseScalesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/audits');
}
