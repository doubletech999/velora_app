
import 'package:latlong2/latlong.dart';

import '../models/path_model.dart';
import '../services/api_service.dart';

class PathsRepository {
  final ApiService _apiService = ApiService();
  
  Future<List<PathModel>> getAllPaths() async {
    // TODO: Replace with actual API call
    // Dummy data for now
    return [
      PathModel(
        id: '1',
        name: 'Upper Galilee Trail',
        nameAr: 'مسار الجليل الأعلى',
        description: 'A beautiful trail through the Upper Galilee...',
        descriptionAr: 'مسار جميل عبر الجليل الأعلى...',
        location: 'Upper Galilee, Northern Palestine',
        locationAr: 'الجليل الأعلى، شمال فلسطين',
        images: [
          'https://example.com/image1.jpg',
          'https://example.com/image2.jpg',
        ],
        length: 12.5,
        estimatedDuration: const Duration(hours: 4),
        difficulty: DifficultyLevel.medium,
        activities: [
          ActivityType.hiking,
          ActivityType.nature,
          ActivityType.camping,
        ],
        coordinates: [
          LatLng(33.0479, 35.3923),
          LatLng(33.0485, 35.3930),
          // Add more coordinates
        ],
        rating: 4.7,
        reviewCount: 128,
        warnings: [
          'Bring plenty of water',
          'Start early in summer',
        ],
        warningsAr: [
          'احرص على أخذ كمية كافية من الماء',
          'يُنصح بالبدء في الصباح الباكر في فصل الصيف',
        ],
      ),
      // Add more paths...
    ];
  }
  
  Future<List<PathModel>> getFeaturedPaths() async {
    final allPaths = await getAllPaths();
    // Return the top 5 paths by rating
    allPaths.sort((a, b) => b.rating.compareTo(a.rating));
    return allPaths.take(5).toList();
  }
}