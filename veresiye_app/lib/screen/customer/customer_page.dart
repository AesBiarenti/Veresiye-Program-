import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veresiye_app/model/customer_model.dart';
import 'package:veresiye_app/provider/customer_provider.dart';
import 'package:veresiye_app/provider/theme/theme_provider.dart';
import 'package:veresiye_app/screen/customer/customer_detail_page.dart';
import 'package:veresiye_app/widgets/text_field_float.dart';

class CustomerPage extends ConsumerStatefulWidget {
  const CustomerPage({super.key});

  @override
  ConsumerState<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends ConsumerState<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    final customers = ref.watch(customersProvider);
    final customerUpdater = ref.read(customerUpdateProvider);
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
            "ADRES",
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
        rows: customers.map((customer) {
          return DataRow(
            cells: [
              DataCell(
                Text(customer.creationDate.toString()),
              ),
              DataCell(
                TextButton(
                  onPressed: () {
                    _showUpdateDialog(context, customerUpdater, customer);
                  },
                  child: Text(customer.name),
                ),
              ),
              DataCell(
                TextButton(
                  onPressed: () {
                    _showUpdateDialog(context, customerUpdater, customer);
                  },
                  child: Text(customer.address),
                ),
              ),
              DataCell(
                TextButton(
                  onPressed: () {
                    _showUpdateDialog(context, customerUpdater, customer);
                  },
                  child: Text(customer.number),
                ),
              ),
              DataCell(
                Text(
                  ref
                      .read(customersDetailUpdaterProvider)
                      .updateTotalPrice(customer.orderDetails)
                      .toString(),
                ),
              ),
              DataCell(
                TextButton(
                  onPressed: () {
                    showDetailBottomSheet(customer, context, ref);
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
                        .read(customersProvider.notifier)
                        .removeCustomer(customer.id);
                    
                  },
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, CustomerUpdater customerUpdater,
      Customer customer) {
    final TextEditingController nameController =
        TextEditingController(text: customer.name);
    final TextEditingController addressController =
        TextEditingController(text: customer.address);
    final TextEditingController numberController =
        TextEditingController(text: customer.number);

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
                  textField("Address", addressController),
                  textField("Number", numberController),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final updatedCustomer = Customer(
                      id: customer.id,
                      name: nameController.text,
                      address: addressController.text,
                      number: numberController.text,
                      totalPrice: customer.totalPrice,
                      orderDetails: customer.orderDetails,
                      creationDate: customer.creationDate,
                    );

                    customerUpdater.updateCustomer(updatedCustomer);
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
