// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../models/tv_model.dart';
import '../../../repositories/tv_repository.dart';

class AiringTodayTVViewModel extends ChangeNotifier {
  final TVRepository tvRepository;

  AiringTodayTVViewModel({required this.tvRepository});

  List<TVResults>? _tvResult = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<TVResults>? get tvResult => _tvResult;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> showNowPlayingTV(BuildContext context) async {
    _isLoading = true;
    try {
      _tvResult = await tvRepository.loadAiringTV();
    } catch (e) {
      _errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: const EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Text(
            '$e',
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
