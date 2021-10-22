import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/Notifiers.dart';

final totalProvider = ChangeNotifierProvider((ref) => TotalNotifier());
final walletProvider = ChangeNotifierProvider((ref) => WalletNotifier());
final countProvider = ChangeNotifierProvider((ref) => CountNotifier());
final cartProvider = ChangeNotifierProvider((ref) => CartNotifier());
final quantityProvider = ChangeNotifierProvider((ref) => QuantityNotifier());
