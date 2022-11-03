import 'package:flutter_bloc/flutter_bloc.dart';

part 'page_view_event.dart';

part 'page_view_state.dart';

class PageViewStateBloc extends Bloc<PageViewStateEvent, PageViewStateState> {
  PageViewStateBloc() : super(PageViewStateInitial()) {
    on<PageViewStateEvent>((event, emit) {
      return emit(PageViewStateInitial());
    });

    on<OnNextPressEvent>((event, emit) {
      return emit(OnNextPressState());
    });

    on<OnPreviousPressEvent>((event, emit) {
      return emit(OnPreviousPressState());
    });

    on<OnSpeakPressEvent>((event, emit) {
      return emit(OnSpeakPressState());
    });

    on<OnFavoriteIconPressEvent>((event, emit) {
      return emit(OnFavoriteIconPressState());
    });
  }

}
