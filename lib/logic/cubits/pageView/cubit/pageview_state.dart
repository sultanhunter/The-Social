part of 'pageview_cubit.dart';

class PageviewState extends Equatable {
  final int pageIndex;
  final PageController pageController;
  const PageviewState({required this.pageIndex, required this.pageController});

  @override
  List<Object> get props => [pageIndex, pageController];
}
