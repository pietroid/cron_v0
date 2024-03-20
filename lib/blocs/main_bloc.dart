import 'package:flutter_template/blocs/main_event.dart';
import 'package:flutter_template/blocs/main_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> with HydratedMixin {
  MainBloc() : super(MainInitial()) {
    hydrate();
  }

  @override
  MainState fromJson(Map<String, dynamic> json) => MainInitial();

  @override
  Map<String, dynamic> toJson(MainState state) => {};
}
