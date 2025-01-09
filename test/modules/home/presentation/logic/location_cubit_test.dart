import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_api/modules/home/presentation/logic/geolocator/geolocator_wrapper.dart';
import 'package:weather_app_api/modules/home/presentation/logic/geolocator/location_cubit.dart';
import 'package:weather_app_api/modules/home/presentation/logic/geolocator/location_state.dart';

class MockGeolocator extends Mock implements GeolocatorPlatform {}

void main() {
  late MockGeolocator mockGeolocator;
  late LocationCubit locationCubit;

  setUp(() {
    mockGeolocator = MockGeolocator();
    GeolocatorPlatform.instance = mockGeolocator;
    locationCubit = LocationCubit(geolocatorWrapper: GeolocatorWrapper());
  });

  tearDown(() {
    locationCubit.close();
  });

  group(
    'LocationCubit',
    () {
      blocTest<LocationCubit, LocationState>(
        'emits [LocationLoadingState, LocationFailureState] when location services are disabled',
        build: () => locationCubit,
        setUp: () {
          when(mockGeolocator.isLocationServiceEnabled())
              .thenAnswer((_) async => false);
        },
        act: (cubit) => cubit.getLocation(),
        expect: () => [
          LocationLoadingState(),
          LocationFailureState(errorMessage: "Location Service is Disabled"),
        ],
      );

      blocTest<LocationCubit, LocationState>(
        'emits [LocationLoadingState, LocationFailureState] when location permission is denied',
        build: () => locationCubit,
        setUp: () {
          when(mockGeolocator.isLocationServiceEnabled())
              .thenAnswer((_) async => true);
          when(mockGeolocator.checkPermission())
              .thenAnswer((_) async => LocationPermission.denied);
          when(mockGeolocator.requestPermission())
              .thenAnswer((_) async => LocationPermission.denied);
        },
        act: (cubit) => cubit.getLocation(),
        expect: () => [
          LocationLoadingState(),
          LocationFailureState(errorMessage: "Location permission are denied"),
        ],
      );

      blocTest<LocationCubit, LocationState>(
        'emits [LocationLoadingState, LocationFailureState] when location permission is denied forever',
        build: () => locationCubit,
        setUp: () {
          when(mockGeolocator.isLocationServiceEnabled())
              .thenAnswer((_) async => true);
          when(mockGeolocator.checkPermission())
              .thenAnswer((_) async => LocationPermission.deniedForever);
        },
        act: (cubit) => cubit.getLocation(),
        expect: () => [
          LocationLoadingState(),
          LocationFailureState(
            errorMessage:
                "Location permissions are permanently denied, we cannot request permissions.",
          ),
        ],
      );

      blocTest<LocationCubit, LocationState>(
        'emits [LocationLoadingState, LocationSuccessState] when location is successfully retrieved',
        build: () => locationCubit,
        setUp: () {
          when(mockGeolocator.isLocationServiceEnabled())
              .thenAnswer((_) async => true);
          when(mockGeolocator.checkPermission())
              .thenAnswer((_) async => LocationPermission.whileInUse);
          when(mockGeolocator.getCurrentPosition()).thenAnswer(
            (_) async => Position(
              latitude: 27.7172,
              longitude: 85.3240,
              timestamp: DateTime.now(),
              accuracy: 10.0,
              altitude: 100.0,
              heading: 0.0,
              speed: 0.0,
              speedAccuracy: 0.0,
              altitudeAccuracy: 0.0,
              headingAccuracy: 0.0,
            ),
          );
        },
        act: (cubit) => cubit.getLocation(),
        expect: () => [
          LocationLoadingState(),
          isA<LocationSuccessState>()
              .having(
                (state) => state.position.latitude,
                'latitude',
                27.7172,
              )
              .having(
                (state) => state.position.longitude,
                'longitude',
                85.3240,
              ),
        ],
      );

      blocTest<LocationCubit, LocationState>(
        'emits [LocationLoadingState, LocationFailureState] when an exception occurs',
        build: () => locationCubit,
        setUp: () {
          when(mockGeolocator.isLocationServiceEnabled())
              .thenThrow(Exception('Test Exception'));
        },
        act: (cubit) => cubit.getLocation(),
        expect: () => [
          LocationLoadingState(),
          LocationFailureState(errorMessage: 'Exception: Test Exception'),
        ],
      );
    },
  );
}
