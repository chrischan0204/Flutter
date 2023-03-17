import '../model/awareness_category.dart';

class AwarenessCategoriesRepository {
  Future<List<AwarenessCategory>> getAwarenessCategories() async {
    return <AwarenessCategory>[
      AwarenessCategory(
        awarenessCategory: 'Electrical',
        isActive: true,
      ),
      AwarenessCategory(
        awarenessCategory: 'Environmental',
        isActive: true,
      ),
      AwarenessCategory(
        awarenessCategory: 'Equipment / Vehicle Use',
        isActive: true,
      ),
      AwarenessCategory(
        awarenessCategory: 'Excavation',
        isActive: true,
      ),
      AwarenessCategory(
        awarenessCategory: 'Fall Protection',
        isActive: false,
      ),
      AwarenessCategory(
        awarenessCategory: 'Fire prevention',
        isActive: true,
      ),
      AwarenessCategory(
        awarenessCategory: 'Health Hazards',
        isActive: true,
      ),
      AwarenessCategory(
        awarenessCategory: 'Housekeeping',
        isActive: true,
      ),
      AwarenessCategory(
        awarenessCategory: 'Manual Lifting',
        isActive: true,
      ),

    ];
  }
}
