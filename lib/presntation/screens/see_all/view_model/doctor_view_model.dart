import 'dart:async';
import 'package:aljoud_hospital/data/api_manager/api_manager.dart';
import 'package:flutter/widgets.dart';
import '../../../../data/model_api/selectedDoctor/Data.dart';
import '../../../../data/model_api/selectedDoctor/DoctorResponse.dart';

class DoctorViewModel extends ChangeNotifier {
  final Map<String, StreamController<List<Data>>> _dataControllers = {};
  final Map<String, List<Data>> _currentData = {};
  Timer? _pollingTimer;
  String? _currentSpecialty;
  bool isLoading = false;
  String? error;

  List<Data>? getDataForSpecialty(String specialty) => _currentData[specialty] ?? [];

  Stream<List<Data>> getDataStream(String specialty) {
    if (!_dataControllers.containsKey(specialty)) {
      _dataControllers[specialty] = StreamController<List<Data>>.broadcast();
      print('Created new StreamController for $specialty at ${DateTime.now()}');
      if (_currentData.containsKey(specialty) && _currentData[specialty]!.isNotEmpty) {
        _dataControllers[specialty]!.add(_currentData[specialty]!);
        print('Triggered cached data for $specialty: ${_currentData[specialty]!.map((e) => e.drID).toList()}');
      }
    }
    return _dataControllers[specialty]!.stream;
  }

  Future<void> getSpecialDoctor({required String specialty, bool forceRefresh = false}) async {
    if (!forceRefresh && _currentData.containsKey(specialty) && _currentData[specialty]!.isNotEmpty) {
      print('Using cached data for $specialty: ${_currentData[specialty]!.map((e) => e.drID).toList()} at ${DateTime.now()}');
      if (_dataControllers.containsKey(specialty)) {
        _dataControllers[specialty]!.add(_currentData[specialty]!);
        print('StreamController emitted cached data for $specialty');
      }
      isLoading = false;
      notifyListeners();
      return;
    }

    if (_currentSpecialty != specialty) {
      _pollingTimer?.cancel();
      _currentSpecialty = specialty;
    }

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      print('Fetching new data for $specialty from API at ${DateTime.now()}');
      DoctorResponse? response = await ApiManger.fetchDoctorsBySpecialty(specialty);
      print('API Response for $specialty: status=${response?.status}, data=${response?.data?.map((e) => e.drID).toList()}');
      if (response == null) {
        isLoading = false;
        error = 'Failed to fetch doctors: No response from server';
        if (_dataControllers.containsKey(specialty)) {
          _dataControllers[specialty]!.addError(error!);
        }
        notifyListeners();
        return;
      }

      if (response.status == 'success') {
        final newData = response.data ?? [];
        print('New Data for $specialty: ${newData.map((e) => e.drID).toList()} at ${DateTime.now()}');
        _currentData[specialty] = newData;
        if (_dataControllers.containsKey(specialty)) {
          _dataControllers[specialty]!.add(_currentData[specialty]!);
          print('Data added to StreamController for $specialty: ${_currentData[specialty]!.map((e) => e.drID).toList()}');
        }
        isLoading = false;
        error = null;
        notifyListeners();
      } else {
        isLoading = false;
        error = response.status ?? 'Unknown error occurred';
        print('Error: $error');
        if (_dataControllers.containsKey(specialty)) {
          _dataControllers[specialty]!.addError(error!);
        }
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      error = 'Error fetching doctors: ${e.toString()}';
      print('Exception: $error');
      if (_dataControllers.containsKey(specialty)) {
        _dataControllers[specialty]!.addError(error!);
      }
      notifyListeners();
    }
  }

  void clearCache(String specialty) {
    _currentData.remove(specialty);
    print('Cache cleared for $specialty at ${DateTime.now()}');
    notifyListeners();
  }

  void startPolling(String specialty, {Duration interval = const Duration(seconds: 3)}) {
    _pollingTimer?.cancel();
    _currentSpecialty = specialty;
    _pollingTimer = Timer.periodic(interval, (timer) {
      if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
        print('Polling for $specialty at ${DateTime.now()}');
        clearCache(specialty); // Clear cache before each polling
        getSpecialDoctor(specialty: specialty, forceRefresh: true);
      }
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _currentSpecialty = null;
    print('Polling stopped at ${DateTime.now()}');
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _dataControllers.forEach((_, controller) => controller.close());
    _dataControllers.clear();
    super.dispose();
  }
}