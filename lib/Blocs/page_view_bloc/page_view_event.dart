part of 'page_view_bloc.dart';

abstract class PageViewStateEvent {}

class OnNextPressEvent extends PageViewStateEvent {}

class OnPreviousPressEvent extends PageViewStateEvent {}

class OnSpeakPressEvent extends PageViewStateEvent {}

class OnFavoriteIconPressEvent extends PageViewStateEvent {}

