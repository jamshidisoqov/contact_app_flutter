import 'package:contact_app_flutter/core/data/models/contact_data.dart';

enum UiState { init, success, loading, error }

class MainUiState {
  UiState state = UiState.init;
  List<ContactData> list = [];
  String errorMessage = "";
  bool isLoading = false;

  MainUiState(
      {required this.state,
      this.list = const [],
      this.errorMessage = "",
      this.isLoading = false});
}
