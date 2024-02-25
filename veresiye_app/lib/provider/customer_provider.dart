import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:veresiye_app/model/customer_model.dart';

final customersProvider =
    StateNotifierProvider<CustomersNotifier, List<Customer>>((ref) {
  return CustomersNotifier();
});

final customerFormProvider = Provider<CustomerForm>((ref) {
  return CustomerForm();
});

class CustomersNotifier extends StateNotifier<List<Customer>> {
  CustomersNotifier() : super([]);

  late final Box<Customer> _customersBox = Hive.box<Customer>("customers");

  void loadCustomers() {
    state = _customersBox.values.toList();
  }

  void addCustomer(Customer customer) {
    state = [...state, customer];
    _customersBox.put(customer.id, customer);
  }

  void removeCustomer(String customerId) {
    state = state.where((customer) => customer.id != customerId).toList();
    _customersBox.delete(customerId);
  }

  void updateCustomer(Customer updatedCustomer) {
    state = state.map((customer) {
      if (customer.id == updatedCustomer.id) {
        _customersBox.put(updatedCustomer.id, updatedCustomer);
        return updatedCustomer;
      }
      return customer;
    }).toList();
  }

  void addOrderDetailToCustomer(String customerId, OrderDetail orderDetail) {
    state = state.map((customer) {
      if (customer.id == customerId) {
        customer.orderDetails.add(orderDetail);
        _customersBox.put(customer.id, customer);
        return customer;
      }
      return customer;
    }).toList();
  }

  void removeOrderDetailFromCustomer(String customerId, String orderDetailId) {
    state = state.map((customer) {
      if (customer.id == customerId) {
        customer.orderDetails
            .removeWhere((detail) => detail.id == orderDetailId);
        _customersBox.put(customer.id, customer);
        return customer;
      }
      return customer;
    }).toList();
  }

  void updateOrderDetailOfCustomer(
      String customerId, OrderDetail updatedOrderDetail) {
    state = state.map((customer) {
      if (customer.id == customerId) {
        customer.orderDetails = customer.orderDetails.map((detail) {
          if (detail.id == updatedOrderDetail.id) {
            return updatedOrderDetail;
          }
          return detail;
        }).toList();
        _customersBox.put(customer.id, customer);
        return customer;
      }
      return customer;
    }).toList();
  }
   void updateTotalPrice(String customerId) {
    state = state.map((customer) {
      if (customer.id == customerId) {
        double totalDebt = 0;
        double totalPaid = 0;

        for (var detail in customer.orderDetails) {
          totalDebt += detail.debt;
          totalPaid += detail.paid;
        }

        customer.totalPrice = totalDebt - totalPaid;
        _customersBox.put(customer.id, customer);
        return customer;
      }
      return customer;
    }).toList();
  }
}

class CustomerForm {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
}

final customerUpdateProvider = Provider<CustomerUpdater>((ref) {
  return CustomerUpdater(ref.read(customersProvider.notifier));
});

class CustomerUpdater {
  final CustomersNotifier _customersNotifier;

  CustomerUpdater(this._customersNotifier);

  void updateCustomer(Customer updatedCustomer) {
    _customersNotifier.updateCustomer(updatedCustomer);
  }
}


final customersDetailUpdaterProvider =
    Provider<CustomersDetailUpdater>((ref) => CustomersDetailUpdater());

class CustomersDetailUpdater {
  double updateTotalPrice(List<OrderDetail> orderDetails) {
    double totalDebt = 0;
    double totalPaid = 0;

    for (var detail in orderDetails) {
      totalDebt += detail.debt;
      totalPaid += detail.paid;
    }

    return totalDebt - totalPaid;
  }
}