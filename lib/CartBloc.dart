import 'dart:async';
import 'package:market_place/CartEvent.dart';

class CartBloc {
  
  final _cartStateController = StreamController<double>();
  StreamSink<double> get _cart => _cartStateController.sink;
  Stream<double> get cart => _cartStateController.stream;

  final _cartEventController = StreamController<CartEvent>();
  Sink<CartEvent> get cartEventSink => _cartEventController.sink;

  double _total = 0;
  

  CartBloc() {
    _cartEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CartEvent event) {
    if (event is AddToTotal) {
      _total += event.price;
    } else if (event is RemoveFromTotal) {
      _total -= event.price;
    }

    _cart.add(_total);
  }

  void dispose() {
    _cartStateController.close();
    _cartEventController.close();
  }
}
