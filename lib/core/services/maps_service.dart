// lib/core/services/maps_service.dart
import 'dart:ui' show Color;

import 'package:flutter/foundation.dart' show VoidCallback;
import 'package:geolocator/geolocator.dart' hide ActivityType; // إخفاء ActivityType من geolocator
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapsService {
  static const String _apiKey = 'AIzaSyBWqjnM9yA4jfihMqRalUqUR0MTm0Pu5CI';
  
  // الحصول على الموقع الحالي
  static Future<Position?> getCurrentLocation() async {
    try {
      // التحقق من تفعيل خدمات الموقع
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('خدمات الموقع غير مفعلة');
      }

      // التحقق من الصلاحيات
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('تم رفض صلاحيات الموقع');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('صلاحيات الموقع مرفوضة نهائياً');
      }

      // الحصول على الموقع الحالي
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return position;
    } catch (e) {
      print('خطأ في الحصول على الموقع: $e');
      return null;
    }
  }

  // تحويل الموقع إلى عنوان
  static Future<String?> getAddressFromCoordinates(
    double latitude, 
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude, 
        longitude,
      );
      
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.locality}, ${place.country}';
      }
    } catch (e) {
      print('خطأ في تحويل الإحداثيات إلى عنوان: $e');
    }
    return null;
  }

  // تحويل العنوان إلى إحداثيات
  static Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations[0].latitude, locations[0].longitude);
      }
    } catch (e) {
      print('خطأ في تحويل العنوان إلى إحداثيات: $e');
    }
    return null;
  }

  // حساب المسافة بين نقطتين
  static double calculateDistance(
    LatLng point1, 
    LatLng point2,
  ) {
    return Geolocator.distanceBetween(
      point1.latitude,
      point1.longitude,
      point2.latitude,
      point2.longitude,
    ) / 1000; // تحويل إلى كيلومتر
  }

  // إنشاء marker للخريطة
  static Marker createMarker({
    required String markerId,
    required LatLng position,
    required String title,
    String? snippet,
    BitmapDescriptor? icon,
    VoidCallback? onTap,
  }) {
    return Marker(
      markerId: MarkerId(markerId),
      position: position,
      infoWindow: InfoWindow(
        title: title,
        snippet: snippet,
      ),
      icon: icon ?? BitmapDescriptor.defaultMarker,
      onTap: onTap,
    );
  }

  // إنشاء polyline للمسار
  static Polyline createPolyline({
    required String polylineId,
    required List<LatLng> points,
    required Color color,
    double width = 5.0,
  }) {
    return Polyline(
      polylineId: PolylineId(polylineId),
      points: points,
      color: color,
      width: width.round(),
      patterns: [],
    );
  }

  // حساب المنطقة المناسبة لعرض جميع النقاط
  static LatLngBounds calculateBounds(List<LatLng> points) {
    if (points.isEmpty) {
      return LatLngBounds(
        southwest: const LatLng(31.0, 34.0), // فلسطين
        northeast: const LatLng(33.5, 36.0),
      );
    }

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (LatLng point in points) {
      minLat = point.latitude < minLat ? point.latitude : minLat;
      maxLat = point.latitude > maxLat ? point.latitude : maxLat;
      minLng = point.longitude < minLng ? point.longitude : minLng;
      maxLng = point.longitude > maxLng ? point.longitude : maxLng;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  // مناطق فلسطين الافتراضية
  static const LatLng palestineCenter = LatLng(31.9522, 35.2332);
  static const LatLng jerusalemCenter = LatLng(31.7683, 35.2137);
  static const LatLng galileeCenter = LatLng(32.8156, 35.0983);
  static const LatLng westBankCenter = LatLng(31.9522, 35.2332);
  static const LatLng gazaCenter = LatLng(31.5, 34.45);

  // الحصول على إحداثيات المنطقة
  static LatLng getRegionCenter(String region) {
    switch (region.toLowerCase()) {
      case 'القدس':
      case 'jerusalem':
        return jerusalemCenter;
      case 'الجليل':
      case 'galilee':
        return galileeCenter;
      case 'غزة':
      case 'gaza':
        return gazaCenter;
      case 'الضفة الغربية':
      case 'west bank':
        return westBankCenter;
      default:
        return palestineCenter;
    }
  }
}