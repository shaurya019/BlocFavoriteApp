import 'package:equatable/equatable.dart';
import 'package:fav/favourite_item_model.dart';


enum ListStatus{loading,success,failure}

class FavouriteItemState extends Equatable{
  final List<FavouriteItemModel> favouriteItemList;
  final List<FavouriteItemModel> tempFavouriteList ;
  final ListStatus listStatus;
  const FavouriteItemState({
    this.favouriteItemList = const [],
    this.tempFavouriteList = const [],
    this.listStatus = ListStatus.loading
});

  FavouriteItemState copyWith({
    List<FavouriteItemModel>? favouriteItemList,
    List<FavouriteItemModel>? tempFavouriteList,
    ListStatus? listStatus
}) {
    return FavouriteItemState(
        favouriteItemList: favouriteItemList ?? this.favouriteItemList,
        tempFavouriteList:tempFavouriteList?? this.tempFavouriteList,
      listStatus: listStatus ?? this.listStatus
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [favouriteItemList];
}
