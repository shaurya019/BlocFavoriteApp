import 'package:bloc/bloc.dart';
import 'fav_event.dart';
import 'fav_state.dart';
import 'favourite_item_model.dart';
import 'favourite_reposiotry.dart';


class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteItemState> {
  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> tempFavouriteList = [];
  FavouriteRepository favouriteRepository;
  FavouriteBloc(this.favouriteRepository) : super(const FavouriteItemState()){
    on<FetchFavouriteList>(_fetchList);
    on<FavouriteItem>(_addFavourite);
    on<DeleteItem>(deleteItem);
    on<SelectItem>(selectedItem);
    on<UnSelectItem>(unSelectItem);
  }

  void _fetchList(FetchFavouriteList event, Emitter<FavouriteItemState> emit) async {
    favouriteList = await favouriteRepository.fetchItems();
    emit(state.copyWith(favouriteItemList: List.from(favouriteList),listStatus: ListStatus.success));
  }

  void _addFavourite(FavouriteItem events , Emitter<FavouriteState> emit)async{

    final personIndex = favouriteList.indexWhere((person) => person.id == events.item.id);
    if(events.item.isFavourite){
      if(tempFavouriteList.contains(favouriteList[personIndex])){
        tempFavouriteList.remove(favouriteList[personIndex]);
        tempFavouriteList.add(events.item);
      }
    }else {
      if(tempFavouriteList.contains(favouriteList[personIndex])){
        tempFavouriteList.remove(favouriteList[personIndex]);
        tempFavouriteList.add(events.item);
      }
    }
    favouriteList[personIndex] = events.item;
    emit(state.copyWith(favouriteItemList: List.from(favouriteList) , tempFavouriteList: List.from(tempFavouriteList)));
  }

  void deleteItem(DeleteItem event, Emitter<FavouriteItemState> emit) async {
    favouriteList.remove(event.object);
    emit(
        state.copyWith(
          favouriteItemList: List.from(favouriteList),
          listStatus: ListStatus.success ,
        ));
  }

  void selectedItem(SelectItem event, Emitter<FavouriteItemState> emit) async {
    tempFavouriteList.add(event.item);
    emit(state.copyWith(tempFavouriteList:List.from(tempFavouriteList)));
  }

  void unSelectItem(UnSelectItem event, Emitter<FavouriteItemState> emit) async {
    tempFavouriteList.remove(event.item);
    emit(state.copyWith(tempFavouriteList:List.from(tempFavouriteList)));
  }

}


