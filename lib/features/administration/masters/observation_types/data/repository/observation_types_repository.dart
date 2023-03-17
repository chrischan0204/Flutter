import '../model/observation_type.dart';

class ObservationTypesRepository {
  Future<List<ObservationType>> getObservationTypes() async {
    return <ObservationType>[
      ObservationType(
        observationType: 'Good Catch',
        severity: 'Good Catch',
        visibility: 'Everywhere	',
        isActive: true,
      ),
      ObservationType(
        observationType: 'Near Miss',
        severity: 'Near Miss',
        visibility: 'Everywhere	',
        isActive: true,
      ),
      ObservationType(
        observationType: 'Near Miss',
        severity: 'Unsafe',
        visibility: 'Everywhere	',
        isActive: false,
      ),
      ObservationType(
        observationType: 'Near Miss',
        severity: 'Unsafe',
        visibility: 'Everywhere	',
        isActive: true,
      ),
    ];
  }
}
