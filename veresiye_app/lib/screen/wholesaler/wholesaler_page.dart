import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veresiye_app/model/wholesaler_model.dart';
import 'package:veresiye_app/provider/theme/theme_provider.dart';
import 'package:veresiye_app/provider/wholesaler_provider.dart';
import 'package:veresiye_app/screen/wholesaler/wholesaler_detail_page.dart';
import 'package:veresiye_app/widgets/text_field_float.dart';

class WholeSalerPage extends ConsumerStatefulWidget {
  const WholeSalerPage({super.key});

  @override
  ConsumerState<WholeSalerPage> createState() => _WholeSalerPageState();
}

class _WholeSalerPageState extends ConsumerState<WholeSalerPage> {
  @override
  Widget build(BuildContext context) {
    final wholesaler = ref.watch(wholeSalerProvider);
    final wholesalerUpdater = ref.read(wholealerUpdateProvider);
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(
              label: Text(
            "TARİH",
            style: Sabitler.anaFont(ref.watch(selectedColorProvider)),
          )),
          DataColumn(
              label: Text(
            "İSİM",
            style: Sabitler.anaFont(ref.watch(selectedColorProvider)),
          )),
          DataColumn(
              label: Text(
            "TEL",
            style: Sabitler.anaFont(ref.watch(selectedColorProvider)),
          )),
          DataColumn(
              label: Text(
            "TUTAR",
            style: Sabitler.anaFont(ref.watch(selectedColorProvider)),
          )),
          DataColumn(
              label: Text(
            "AYRINTI",
            style: Sabitler.anaFont(ref.watch(selectedColorProvider)),
          )),
          DataColumn(
              label: Text(
            "SİL",
            style: Sabitler.anaFont(ref.watch(selectedColorProvider)),
          )),
        ],
        rows: wholesaler.map((wholesaler) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  wholesaler.creationDate.toString(),
                ),
              ),
              DataCell(
                TextButton(
                  onPressed: () {
                    _showUpdateDialog(context, wholesalerUpdater, wholesaler);
                  },
                  child: Text(wholesaler.name),
                ),
              ),
              DataCell(
                TextButton(
                  onPressed: () {
                    _showUpdateDialog(context, wholesalerUpdater, wholesaler);
                  },
                  child: Text(wholesaler.number),
                ),
              ),
              DataCell(
                Text(
                  ref
                      .read(wholeSalerDetailUpdaterProvider)
                      .updateTotalPrice(wholesaler.orderDetails)
                      .toString(),
                ),
              ),
              DataCell(
                TextButton(
                  onPressed: () {
                    wshowDetailBottomSheet(wholesaler, context, ref);
                  },
                  child: const Text("Ayrıntı Göster"),
                ),
              ),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Call the removeCustomer method from the provider
                    ref
                        .read(wholeSalerProvider.notifier)
                        .removeWholeSaler(wholesaler.id);
                  },
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context,
      WholeSalerUpdater wholesalerUpdater, WholeSaler wholesaler) {
    final TextEditingController nameController =
        TextEditingController(text: wholesaler.name);

    final TextEditingController numberController =
        TextEditingController(text: wholesaler.number);

    showDialog(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              title: const Text("Update Customer"),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textField("Name", nameController),
                  textField("Number", numberController),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final updatedCustomer = WholeSaler(
                      id: wholesaler.id,
                      name: nameController.text,
                      number: numberController.text,
                      totalPrice: wholesaler.totalPrice,
                      orderDetails: wholesaler.orderDetails,
                      creationDate: wholesaler.creationDate,
                    );

                    wholesalerUpdater.updateWholeSaler(updatedCustomer);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
