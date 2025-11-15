import 'package:bloc/bloc.dart';
import 'package:cosmetics_store/core/api/api_client.dart';
import 'package:cosmetics_store/core/widgets/slider/promotion_entity.dart';
import 'package:meta/meta.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final ApiClient apiClient;

  BannerBloc(this.apiClient) : super(BannerInitial()) {
    on<LoadBannerEvent>(_onLoadBanner);
  }

  void _onLoadBanner(LoadBannerEvent event, Emitter<BannerState> emit) async {
    emit(BannerLoadingState());
    try {
      final banners = await apiClient.getBanners();
      emit(BannerLoadedState(banners: banners));
    } catch (e) {
      emit(BannerErrorState(error: e.toString()));
    }
  }
}
