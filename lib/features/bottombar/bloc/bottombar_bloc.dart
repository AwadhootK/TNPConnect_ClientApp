import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottombar_events.dart';
part 'bottombar_states.dart';

class BottomBarBloc extends Bloc<BottomBarEvents, BottomBarStates> {
  BottomBarBloc() : super(BottomBarCompanyPostingsState()) {
    on<BottomBarProfileEvent>((event, emit) => emit(BottomBarProfileState()));
    on<BottomBarChatbotEvent>((event, emit) => emit(BottomBarChatbotState()));
    on<BottomBarCompanyPostingsEvent>((event, emit) => emit(BottomBarCompanyPostingsState()));
    on<BottomBarDocumentsEvent>((event, emit) => emit(BottomBarDocumentsState()));
  }
}
