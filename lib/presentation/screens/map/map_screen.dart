// lib/presentation/screens/map/map_screen.dart - إصلاح التضارب
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart' hide ActivityType; // إخفاء ActivityType من geolocator

import '../../../core/constants/app_colors.dart';
import '../../../core/services/maps_service.dart';
import '../../../data/models/path_model.dart'; // ActivityType من هنا
import '../../providers/paths_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import 'widgets/map_control_button.dart';
import 'widgets/path_info_bottom_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  bool _isLoading = true;
  bool _showPathsFilter = false;
  String? _selectedPathId;
  
  // الموقع الحالي
  LatLng _currentLocation = MapsService.palestineCenter;
  Position? _userPosition;
  
  // Markers و Polylines
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  
  // فلترة المسارات
  DifficultyLevel? _selectedDifficulty;
  ActivityType? _selectedActivity; // هذا من path_model.dart
  
  @override
  void initState() {
    super.initState();
    _initializeMap();
  }
  
  Future<void> _initializeMap() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // الحصول على الموقع الحالي
      Position? position = await MapsService.getCurrentLocation();
      if (position != null) {
        setState(() {
          _userPosition = position;
          _currentLocation = LatLng(position.latitude, position.longitude);
        });
      }
      
      // تحميل المسارات
      await _loadPaths();
      
    } catch (e) {
      print('خطأ في تهيئة الخريطة: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  Future<void> _loadPaths() async {
    final pathsProvider = Provider.of<PathsProvider>(context, listen: false);
    final paths = pathsProvider.paths;
    
    await _updateMapData(paths);
  }
  
  Future<void> _updateMapData(List<PathModel> paths) async {
    Set<Marker> markers = {};
    Set<Polyline> polylines = {};
    
    // إضافة marker لموقع المستخدم
    if (_userPosition != null) {
      markers.add(
        MapsService.createMarker(
          markerId: 'user_location',
          position: LatLng(_userPosition!.latitude, _userPosition!.longitude),
          title: 'موقعك الحالي',
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
    
    // تطبيق الفلترة
    final filteredPaths = paths.where((path) {
      if (_selectedDifficulty != null && path.difficulty != _selectedDifficulty) {
        return false;
      }
      
      if (_selectedActivity != null && !path.activities.contains(_selectedActivity)) {
        return false;
      }
      
      return true;
    }).toList();
    
    // إضافة markers و polylines للمسارات
    for (int i = 0; i < filteredPaths.length; i++) {
      final path = filteredPaths[i];
      
      if (path.coordinates.isNotEmpty) {
        // إضافة marker لبداية المسار
        markers.add(
          MapsService.createMarker(
            markerId: 'path_start_${path.id}',
            position: LatLng(
              path.coordinates.first.latitude,
              path.coordinates.first.longitude,
            ),
            title: path.nameAr,
            snippet: path.locationAr,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              _getDifficultyHue(path.difficulty),
            ),
            onTap: () => _onMarkerTap(path),
          ),
        );
        
        // إضافة marker لنهاية المسار
        if (path.coordinates.length > 1) {
          markers.add(
            MapsService.createMarker(
              markerId: 'path_end_${path.id}',
              position: LatLng(
                path.coordinates.last.latitude,
                path.coordinates.last.longitude,
              ),
              title: 'نهاية ${path.nameAr}',
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            ),
          );
        }
        
        // إضافة polyline للمسار
        polylines.add(
          MapsService.createPolyline(
            polylineId: 'path_${path.id}',
            points: path.coordinates.map((coord) => 
              LatLng(coord.latitude, coord.longitude)
            ).toList(),
            color: path.id == _selectedPathId
                ? AppColors.secondary
                : _getDifficultyColor(path.difficulty),
            width: path.id == _selectedPathId ? 6.0 : 4.0,
          ),
        );
      }
    }
    
    setState(() {
      _markers = markers;
      _polylines = polylines;
    });
  }
  
  double _getDifficultyHue(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return BitmapDescriptor.hueGreen;
      case DifficultyLevel.medium:
        return BitmapDescriptor.hueOrange;
      case DifficultyLevel.hard:
        return BitmapDescriptor.hueRed;
    }
  }
  
  Color _getDifficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return AppColors.difficultyEasy;
      case DifficultyLevel.medium:
        return AppColors.difficultyMedium;
      case DifficultyLevel.hard:
        return AppColors.difficultyHard;
    }
  }
  
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    
    // تطبيق الستايل المخصص للخريطة (اختياري)
    _setMapStyle();
  }
  
  Future<void> _setMapStyle() async {
    // يمكن إضافة ستايل مخصص للخريطة هنا
    if (_mapController != null) {
      try {
        const String mapStyle = '''[
          {
            "featureType": "poi",
            "elementType": "labels",
            "stylers": [{"visibility": "off"}]
          }
        ]''';
        await _mapController!.setMapStyle(mapStyle);
      } catch (e) {
        print('خطأ في تطبيق ستايل الخريطة: $e');
      }
    }
  }
  
  void _onMarkerTap(PathModel path) {
    setState(() {
      _selectedPathId = path.id;
    });
    
    // تحديث المسارات على الخريطة
    _updateMapData(Provider.of<PathsProvider>(context, listen: false).paths);
    
    // تحريك الكاميرا إلى المسار
    if (_mapController != null && path.coordinates.isNotEmpty) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(path.coordinates.first.latitude, path.coordinates.first.longitude),
          14.0,
        ),
      );
    }
    
    // عرض معلومات المسار
    _showPathInfoBottomSheet(path);
  }
  
  void _showPathInfoBottomSheet(PathModel path) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PathInfoBottomSheet(
        path: path,
        onViewDetails: () {
          Navigator.of(context).pop();
          context.go('/paths/${path.id}');
        },
      ),
    );
  }
  
  void _togglePathsFilter() {
    setState(() {
      _showPathsFilter = !_showPathsFilter;
    });
  }
  
  void _clearFilters() {
    setState(() {
      _selectedDifficulty = null;
      _selectedActivity = null;
    });
    _loadPaths();
  }
  
  Future<void> _centerUserLocation() async {
    if (_mapController != null) {
      if (_userPosition != null) {
        await _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(_userPosition!.latitude, _userPosition!.longitude),
            15.0,
          ),
        );
      } else {
        // محاولة الحصول على الموقع مرة أخرى
        Position? position = await MapsService.getCurrentLocation();
        if (position != null) {
          setState(() {
            _userPosition = position;
            _currentLocation = LatLng(position.latitude, position.longitude);
          });
          
          await _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(_currentLocation, 15.0),
          );
          
          // تحديث الـ markers
          _loadPaths();
        } else {
          // الانتقال إلى وسط فلسطين كبديل
          await _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(MapsService.palestineCenter, 8.0),
          );
        }
      }
    }
  }
  
  Future<void> _fitAllPaths() async {
    if (_mapController != null) {
      final pathsProvider = Provider.of<PathsProvider>(context, listen: false);
      final paths = pathsProvider.paths;
      
      if (paths.isNotEmpty) {
        List<LatLng> allPoints = [];
        for (var path in paths) {
          allPoints.addAll(path.coordinates.map((coord) => 
            LatLng(coord.latitude, coord.longitude)
          ));
        }
        
        if (allPoints.isNotEmpty) {
          LatLngBounds bounds = MapsService.calculateBounds(allPoints);
          await _mapController!.animateCamera(
            CameraUpdate.newLatLngBounds(bounds, 100.0),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('الخريطة'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _showPathsFilter ? PhosphorIcons.funnel_fill : PhosphorIcons.funnel,
              color: _showPathsFilter ? AppColors.primary : null,
            ),
            onPressed: _togglePathsFilter,
          ),
        ],
      ),
      body: Stack(
        children: [
          // الخريطة
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentLocation,
              zoom: 8.0,
            ),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: _getMapType(settingsProvider.mapType),
            onTap: (LatLng position) {
              setState(() {
                _selectedPathId = null;
              });
              _loadPaths(); // إعادة تحميل لإزالة التحديد
            },
            compassEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
          ),
          
          // مؤشر التحميل
          if (_isLoading)
            const LoadingIndicator(
              message: 'جاري تحميل الخريطة...',
            ),
          
          // فلترة المسارات
          if (_showPathsFilter)
            Positioned(
              top: 8,
              left: 16,
              right: 16,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'فلتر المسارات',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(PhosphorIcons.x),
                            onPressed: _togglePathsFilter,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      // فلتر مستوى الصعوبة
                      const Text(
                        'مستوى الصعوبة',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: DifficultyLevel.values.map((difficulty) {
                          return FilterChip(
                            label: Text(_getDifficultyText(difficulty)),
                            selected: _selectedDifficulty == difficulty,
                            onSelected: (selected) {
                              setState(() {
                                _selectedDifficulty = selected ? difficulty : null;
                              });
                              _loadPaths();
                            },
                            selectedColor: _getDifficultyColor(difficulty).withOpacity(0.3),
                            checkmarkColor: _getDifficultyColor(difficulty),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      
                      // فلتر نوع النشاط
                      const Text(
                        'نوع النشاط',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: ActivityType.values.map((activity) {
                          return FilterChip(
                            label: Text(_getActivityText(activity)),
                            selected: _selectedActivity == activity,
                            onSelected: (selected) {
                              setState(() {
                                _selectedActivity = selected ? activity : null;
                              });
                              _loadPaths();
                            },
                            selectedColor: AppColors.primary.withOpacity(0.2),
                            checkmarkColor: AppColors.primary,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      
                      // زر مسح الفلاتر
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: _clearFilters,
                          child: const Text('مسح الفلاتر'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
          // أزرار تحكم الخريطة
          Positioned(
            bottom: 24,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // زوم إن
                MapControlButton(
                  icon: PhosphorIcons.plus,
                  onPressed: () {
                    _mapController?.animateCamera(
                      CameraUpdate.zoomIn(),
                    );
                  },
                ),
                const SizedBox(height: 8),
                
                // زوم آوت
                MapControlButton(
                  icon: PhosphorIcons.minus,
                  onPressed: () {
                    _mapController?.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                  },
                ),
                const SizedBox(height: 8),
                
                // الموقع الحالي
                MapControlButton(
                  icon: PhosphorIcons.map_pin,
                  onPressed: _centerUserLocation,
                ),
                const SizedBox(height: 8),
                
                // عرض جميع المسارات
                MapControlButton(
                  icon: PhosphorIcons.map_trifold,
                  onPressed: _fitAllPaths,
                ),
                const SizedBox(height: 8),
                
                // تغيير نوع الخريطة
                MapControlButton(
                  icon: settingsProvider.mapType == 'satellite'
                      ? PhosphorIcons.map_pin
                      : PhosphorIcons.stack,
                  onPressed: () {
                    final newType = settingsProvider.mapType == 'satellite'
                        ? 'standard'
                        : 'satellite';
                    settingsProvider.setMapType(newType);
                  },
                ),
              ],
            ),
          ),
          
          // معلومات إضافية
          Positioned(
            bottom: 24,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Consumer<PathsProvider>(
                builder: (context, pathsProvider, child) {
                  final filteredCount = pathsProvider.paths.where((path) {
                    if (_selectedDifficulty != null && path.difficulty != _selectedDifficulty) {
                      return false;
                    }
                    if (_selectedActivity != null && !path.activities.contains(_selectedActivity)) {
                      return false;
                    }
                    return true;
                  }).length;
                  
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        PhosphorIcons.map_pin,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$filteredCount مسار',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  MapType _getMapType(String mapType) {
    switch (mapType) {
      case 'satellite':
        return MapType.satellite;
      case 'terrain':
        return MapType.terrain;
      case 'hybrid':
        return MapType.hybrid;
      default:
        return MapType.normal;
    }
  }
  
  String _getDifficultyText(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return 'سهل';
      case DifficultyLevel.medium:
        return 'متوسط';
      case DifficultyLevel.hard:
        return 'صعب';
    }
  }

  String _getActivityText(ActivityType activity) {
    switch (activity) {
      case ActivityType.hiking:
        return 'المشي';
      case ActivityType.camping:
        return 'التخييم';
      case ActivityType.climbing:
        return 'التسلق';
      case ActivityType.religious:
        return 'ديني';
      case ActivityType.cultural:
        return 'ثقافي';
      case ActivityType.nature:
        return 'طبيعة';
      case ActivityType.archaeological:
        return 'أثري';
    }
  }
}