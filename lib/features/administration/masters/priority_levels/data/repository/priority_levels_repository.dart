import 'package:flutter/material.dart';

import '../model/priority_level.dart';

class PriorityLevelsRepository {
  Future<List<PriorityLevel>> getPriorityLevels() async {
    return <PriorityLevel>[
      PriorityLevel(
        priorityLevel: 'Low',
        colorAssociated: Color(0xff3a7eb5),
        priorityType: 'Corrective',
        isActive: true,
      ),
      PriorityLevel(
        priorityLevel: 'Medium',
        colorAssociated: Color(0xfff5ce42),
        priorityType: 'Corrective',
        isActive: true,
      ),
      PriorityLevel(
        priorityLevel: 'High',
        colorAssociated: Color(0xffe8588f),
        priorityType: 'Corrective',
        isActive: false,
      ),
      PriorityLevel(
        priorityLevel: 'Positive',
        colorAssociated: Color(0xfff5e3df),
        priorityType: 'Positive',
        isActive: true,
      ),
    ];
  }
}
