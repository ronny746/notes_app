import 'package:replay_bloc/replay_bloc.dart';

class ListData {
  final List<String> items;
  ListData(this.items);
}


class ListCubic extends ReplayCubit<ListData>{

 ListCubic() : super(ListData([]));

 void newItem(String text){
  final items = [...state.items];
  items.add(text);
  emit(ListData (items));
 } 

}