import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:veresiye_app/model/wholesaler_model.dart';
import 'package:veresiye_app/provider/theme/theme_provider.dart';
import 'package:veresiye_app/provider/wholesaler_provider.dart';
import 'package:veresiye_app/widgets/text_field_float.dart';

void wshowDetailBottomSheet(
    WholeSaler wholesaler, BuildContext context, WidgetRef ref) {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController debtController = TextEditingController();
  TextEditingController paidController = TextEditingController();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 800,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                        child: textField("Açıklama", descriptionController)),
                    Expanded(child: textField("Borç", debtController)),
                    Expanded(child: textField("Ödenen", paidController)),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  final newOrderDetail = WOrderDetail(
                    id: const Uuid().v4(),
                    description: descriptionController.text,
                    debt: double.tryParse(debtController.text) ?? 0,
                    paid: double.tryParse(paidController.text) ?? 0,
                    date: DateTime.now(),
                  );

                  // Yeni sipariş detayını müşteriye ekle
                  ref
                      .read(wholeSalerProvider.notifier)
                      .addOrderDetailToWholeSaler(
                          wholesaler.id, newOrderDetail);

                  // BottomSheet'i kapat
                  Navigator.of(context).pop();
                },
                child: const Text("Ekle"),
              ),
              const Divider(),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: [
                      DataColumn(
                          label: Text(
                        "Açıklama",
                        style:
                            Sabitler.anaFont(ref.watch(selectedColorProvider)),
                      )),
                      DataColumn(
                          label: Text(
                        "Borç",
                        style:
                            Sabitler.anaFont(ref.watch(selectedColorProvider)),
                      )),
                      DataColumn(
                          label: Text(
                        "Ödeme",
                        style:
                            Sabitler.anaFont(ref.watch(selectedColorProvider)),
                      )),
                      DataColumn(
                          label: Text(
                        "Tarih",
                        style:
                            Sabitler.anaFont(ref.watch(selectedColorProvider)),
                      )),
                      DataColumn(
                          label: Text(
                        "Sil",
                        style:
                            Sabitler.anaFont(ref.watch(selectedColorProvider)),
                      )),
                    ],
                    rows: wholesaler.orderDetails.map((orderDetail) {
                      return DataRow(
                        cells: [
                          DataCell(TextButton(
                              onPressed: () {
                                _showUpdateDialog(
                                    context, ref, wholesaler, orderDetail);
                              },
                              child: Text(orderDetail.description))),
                          DataCell(TextButton(
                              onPressed: () {
                                _showUpdateDialog(
                                    context, ref, wholesaler, orderDetail);
                              },
                              child: Text(orderDetail.debt.toString()))),
                          DataCell(TextButton(
                              onPressed: () {
                                _showUpdateDialog(
                                    context, ref, wholesaler, orderDetail);
                                    
                              },
                              child: Text(orderDetail.paid.toString()))),
                          DataCell(Text(orderDetail.date.toString())),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // Sipariş detayını müşteriden sil
                                ref
                                    .read(wholeSalerProvider.notifier)
                                    .removeOrderDetailFromWholeSaler(
                                        wholesaler.id, orderDetail.id);
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showUpdateDialog(BuildContext context, WidgetRef ref,
    WholeSaler wholeSaler, WOrderDetail orderDetail) {
  TextEditingController updatedDescriptionController =
      TextEditingController(text: orderDetail.description);
  TextEditingController updatedDebtController =
      TextEditingController(text: orderDetail.debt.toString());
  TextEditingController updatedPaidController =
      TextEditingController(text: orderDetail.paid.toString());

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Update Order Detail"),
        content: Column(
          children: [
            TextField(
              controller: updatedDescriptionController,
              decoration: const InputDecoration(labelText: "Açıklama"),
            ),
            TextField(
              controller: updatedDebtController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Borç"),
            ),
            TextField(
              controller: updatedPaidController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Ödeme"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final updatedOrderDetail = WOrderDetail(
                id: orderDetail.id,
                description: updatedDescriptionController.text,
                debt: double.tryParse(updatedDebtController.text) ?? 0,
                paid: double.tryParse(updatedPaidController.text) ?? 0,
                date: orderDetail.date,
              );

              // Güncellenmiş sipariş detayını müşteriye ekle
              ref
                  .read(wholeSalerProvider.notifier)
                  .updateOrderDetailOfWholeSaler(
                      wholeSaler.id, updatedOrderDetail);

              // AlertDialog'ı kapat
              Navigator.of(context).pop();
            },
            child: const Text("Update"),
          ),
        ],
      );
    },
  );
}
