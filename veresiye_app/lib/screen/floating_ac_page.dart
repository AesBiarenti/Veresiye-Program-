import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:veresiye_app/model/customer_model.dart';
import 'package:veresiye_app/model/wholesaler_model.dart';
import 'package:veresiye_app/provider/customer_provider.dart';
import 'package:veresiye_app/provider/theme/theme_provider.dart';
import 'package:veresiye_app/provider/wholesaler_provider.dart';
import 'package:veresiye_app/widgets/text_field_float.dart';

class FloatAcButton extends ConsumerStatefulWidget {
  const FloatAcButton({super.key});

  @override
  ConsumerState<FloatAcButton> createState() => _FloatAcButtonState();
}

class _FloatAcButtonState extends ConsumerState<FloatAcButton> {
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerAddressController =
      TextEditingController();
  final TextEditingController customerNumberController =
      TextEditingController();
  final TextEditingController wholesalerController = TextEditingController();
  final TextEditingController wholesalerNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: ref.watch(selectedColorProvider),
              content: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Müşteri Ekle",
                            ),
                            content: SizedBox(
                              height: 200,
                              child: Column(
                                children: [
                                  textField("İsim Gir", customerNameController),
                                  const SizedBox(height: 10),
                                  textField(
                                      "Adres Gir", customerAddressController),
                                  const SizedBox(height: 10),
                                  textField(
                                      "Numara Gir", customerNumberController),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  final name = customerNameController.text;
                                  final address =
                                      customerAddressController.text;
                                  final number = customerNumberController.text;

                                  final newCustomer = Customer(
                                    id: const Uuid().v4(),
                                    name: name,
                                    address: address,
                                    number: number,
                                    totalPrice: 0,
                                    orderDetails: [],
                                    creationDate: DateTime.now(),
                                  );

                                  ref
                                      .read(customersProvider.notifier)
                                      .addCustomer(newCustomer);

                                  Navigator.of(context).pop();
                                },
                                child: const Text("Kaydet"),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            "Müşteri Ekle",
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Toptancı Ekle",
                            ),
                            content: SizedBox(
                              height: 200,
                              child: Column(
                                children: [
                                  textField(
                                      "Toptancı Gir", wholesalerController),
                                  textField(
                                      "Numara Gir", wholesalerNumberController),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  final wholesaler = wholesalerController.text;
                                  final wholesalernumber =
                                      wholesalerNumberController.text;
                                  final newWholeSaler = WholeSaler(
                                    id: const Uuid().v4(),
                                    name: wholesaler,
                                    number: wholesalernumber,
                                    totalPrice: 0,
                                    orderDetails: [],
                                    creationDate: DateTime.now(),
                                  );
                                  ref
                                      .read(wholeSalerProvider.notifier)
                                      .addWholeSaler(newWholeSaler);
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Kaydet"),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            "Toptancı Ekle",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
