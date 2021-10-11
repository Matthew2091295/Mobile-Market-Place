import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/Notifiers.dart';

final totalProvider = ChangeNotifierProvider((ref) => TotalNotifier());
final walletProvider = ChangeNotifierProvider((ref) => WalletNotifier());
final quantityProvider = ChangeNotifierProvider((ref) => QuantityNotifier());
final countProvider = ChangeNotifierProvider((ref) => CountNotifier());
