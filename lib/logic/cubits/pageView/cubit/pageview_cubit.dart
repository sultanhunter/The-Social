import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'pageview_state.dart';

class PageviewCubit extends Cubit<PageviewState> {
  PageController initialPageController = PageController();
  PageviewCubit()
      : super(PageviewState(pageIndex: 0, pageController: PageController()));

  void changePage(int index) {
    emit(PageviewState(pageIndex: index, pageController: state.pageController));
  }

  void getPageController(PageController pageController) {
    emit(PageviewState(pageIndex: 0, pageController: pageController));
  }
}
