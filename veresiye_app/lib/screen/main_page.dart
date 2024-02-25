import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veresiye_app/provider/theme/theme_provider.dart';
import 'package:veresiye_app/screen/customer/customer_page.dart';
import 'package:veresiye_app/screen/floating_ac_page.dart';
import 'package:veresiye_app/screen/wholesaler/wholesaler_page.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("VERESİYE"),
          actions: [
            IconButton(
              onPressed: () {
                showColorPaletteDialog(context, ref);
              },
              icon: const Icon(
                Icons.palette,
                color: Colors.white,
                size: 36,
              ),
            )
          ],
          bottom: const TabBar(tabs: [
            Tab(
              text: "MÜŞTERİ",
            ),
            Tab(
              text: "TOPTANCI",
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            CustomerPage(),
            WholeSalerPage(),
          ],
        ),
        floatingActionButton: const FloatAcButton(),
      ),
    );
  }

  void showColorPaletteDialog(BuildContext context, WidgetRef ref) async {
    final selectedColor = ref.watch(selectedColorProvider);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Renk Paleti'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildColorRadioButton("Buz Mavisi", Colors.blueGrey.shade300,
                  selectedColor, ref, context),
              _buildColorRadioButton(
                  "Mavi", Colors.blue.shade300, selectedColor, ref, context),
              _buildColorRadioButton(
                  "Mor", Colors.deepPurple, selectedColor, ref, context),
              _buildColorRadioButton(
                  "Kırmızı", Colors.red.shade300, selectedColor, ref, context),
              _buildColorRadioButton(
                  "Yeşil", Colors.green.shade300, selectedColor, ref, context),
              _buildColorRadioButton("Limon Yeşili", Colors.lightGreen.shade300,
                  selectedColor, ref, context),
              _buildColorRadioButton("Turuncu", Colors.deepOrange.shade300,
                  selectedColor, ref, context),
              _buildColorRadioButton(
                  "Pembe", Colors.pink.shade300, selectedColor, ref, context),
              _buildColorRadioButton("İndigo", Colors.indigo.shade300,
                  selectedColor, ref, context),
              _buildColorRadioButton(
                  "Teal", Colors.teal.shade300, selectedColor, ref, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildColorRadioButton(String text, Color color, Color selectedColor,
      WidgetRef ref, BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: Radio<Color>(
        value: color,
        groupValue: selectedColor,
        onChanged: (selectedColor) {
          ref.read(selectedColorProvider.notifier).updateColor(selectedColor!);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
