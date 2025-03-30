// list_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../operators.dart';
import '../parser_controller.dart';

// Events
abstract class ListEvent {}

class SelectOptionEvent extends ListEvent {
  final String option;
  SelectOptionEvent(this.option);
}

class AddItemEvent extends ListEvent {
  final String item;
  AddItemEvent(this.item);
}

class ClearListEvent extends ListEvent {}

class PerformActionEvent extends ListEvent {}

// States
class ListState {
  final String selectedOption;
  final List<String> items;

  ListState({required this.selectedOption, required this.items});

  ListState copyWith({String? selectedOption, List<String>? items}) {
    return ListState(
      selectedOption: selectedOption ?? this.selectedOption,
      items: items ?? this.items,
    );
  }
}

// BLoC
class ListBloc extends Bloc<ListEvent, ListState> {
  static final List<String> items = [
    'ZwLight.Brightness >= 50',
    'ZwLight.Brightness>= 50',
    'ZwLight.Brightness >= (50 + BLE.Light.Brightness)',
    'ZwLight.Brightness >= (50+4*8-BLE.Light.Brightness)',
  ];

  ListBloc()
    : super(
        ListState(
          selectedOption: items[0],
          items: [],
        ),
      ) {
    on<SelectOptionEvent>((event, emit) {
      emit(state.copyWith(selectedOption: event.option));
    });

    on<AddItemEvent>((event, emit) {
      final newItems = List<String>.from(state.items)..add(event.item);
      emit(state.copyWith(items: newItems));
    });

    on<ClearListEvent>((event, emit) {
      emit(state.copyWith(items: []));
    });

    on<PerformActionEvent>((event, emit) {
      ParserController parserController = ParserController(
        this,
        state.selectedOption,
        Operators(),
      );
      parserController.parse();
    });
  }
}
