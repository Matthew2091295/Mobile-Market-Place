import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/CartNotifier.dart';

final cartProvider = ChangeNotifierProvider((ref) => CartNotifier());
