import 'package:flutter/material.dart';

import '../../../data/model/tv_model.dart';
import '../../../data/repository/tv_repository.dart';

class TopRatedTVViewModel extends ChangeNotifier {
  final TVRepository tvRepository;

  TopRatedTVViewModel({required this.tvRepository});

  List<TVResult>? _tvResult = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<TVResult>? get tvResult => _tvResult;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> showTopRatedTV(BuildContext context) async {
    _isLoading = true;
    try {
      _tvResult = await tvRepository.loadTopRatedTV();
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
