import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:veresiye_app/model/customer_model.dart';
import 'package:veresiye_app/model/wholesaler_model.dart';
import 'package:veresiye_app/provider/customer_provider.dart';
import 'package:veresiye_app/provider/theme/theme_provider.dart';
import 'package:veresiye_app/provider/wholesaler_provider.dart';
import 'package:veresiye_app/screen/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter("VeresiyeDatabase");
  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(OrderDetailAdapter());
  Hive.registerAdapter(WholeSalerAdapter());
  Hive.registerAdapter(WOrderDetailAdapter());
  await Hive.openBox<Customer>("customers");
  await Hive.openBox<WholeSaler>("wholesalers");
  await Hive.openBox<String>('color');

  final selectedColorNotifier = SelectedColorNotifier();
  selectedColorNotifier.loadColor();

  runApp(
    ProviderScope(
      overrides: [
        selectedColorProvider.overrideWith((ref) => selectedColorNotifier),
        customersProvider.overrideWith((ref) {
          return CustomersNotifier()..loadCustomers();
        }),
        wholeSalerProvider.overrideWith((ref) {
          return WholeSalerNotifier()..loadWholeSaler();
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themes(ref),
      title: 'Material App',
      home: const MainPage(),
    );
  }
}
