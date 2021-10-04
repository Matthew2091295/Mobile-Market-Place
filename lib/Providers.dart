import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/Notifiers.dart';

final cartProvider = ChangeNotifierProvider((ref) => CartNotifier());
