part of 'banner_bloc.dart';

@immutable
sealed class BannerState {}

final class BannerInitial extends BannerState {}

final class Banner extends BannerState {}

final class BannerLoadingState extends BannerState {}

final class BannerLoadedState extends BannerState {
  final List<Promotion> banners;

  BannerLoadedState({required this.banners});
}

final class BannerErrorState extends BannerState {
  final String error;

  BannerErrorState({required this.error});
}
