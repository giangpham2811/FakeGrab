import 'package:app/src/page/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void logout() async {
    emit(LogoutSuccess());
  }
}
