import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:veresiye_app/model/wholesaler_model.dart';

final wholeSalerProvider =
    StateNotifierProvider<WholeSalerNotifier, List<WholeSaler>>((ref) {
  return WholeSalerNotifier();
});

final wholealerFormProvider = Provider<WholeSalerForm>((ref) {
  return WholeSalerForm();
});

class WholeSalerNotifier extends StateNotifier<List<WholeSaler>> {
  WholeSalerNotifier() : super([]);

  late final Box<WholeSaler> _wholeSalerBox = Hive.box<WholeSaler>("wholesalers");

  void loadWholeSaler() {
    state = _wholeSalerBox.values.toList();
  }

  void addWholeSaler(WholeSaler wholealer) {
    state = [...state, wholealer];
    _wholeSalerBox.put(wholealer.id, wholealer);
  }

  void removeWholeSaler(String wholealerId) {
    state = state.where((wholealer) => wholealer.id != wholealerId).toList();
    _wholeSalerBox.delete(wholealerId);
  }

  void updateWholeSaler(WholeSaler updatedWholeSaler) {
    state = state.map((wholealer) {
      if (wholealer.id == updatedWholeSaler.id) {
        _wholeSalerBox.put(updatedWholeSaler.id, updatedWholeSaler);
        return updatedWholeSaler;
      }
      return wholealer;
    }).toList();
  }

  void addOrderDetailToWholeSaler(String wholealerId, WOrderDetail orderDetail) {
    state = state.map((wholealer) {
      if (wholealer.id == wholealerId) {
        wholealer.orderDetails.add(orderDetail);
        _wholeSalerBox.put(wholealer.id, wholealer);
        return wholealer;
      }
      return wholealer;
    }).toList();
  }

  void removeOrderDetailFromWholeSaler(String wholealerId, String orderDetailId) {
    state = state.map((wholealer) {
      if (wholealer.id == wholealerId) {
        wholealer.orderDetails
            .removeWhere((detail) => detail.id == orderDetailId);
        _wholeSalerBox.put(wholealer.id, wholealer);
        return wholealer;
      }
      return wholealer;
    }).toList();
  }

  void updateOrderDetailOfWholeSaler(
      String wholealerId, WOrderDetail updatedOrderDetail) {
    state = state.map((wholealer) {
      if (wholealer.id == wholealerId) {
        wholealer.orderDetails = wholealer.orderDetails.map((detail) {
          if (detail.id == updatedOrderDetail.id) {
            return updatedOrderDetail;
          }
          return detail;
        }).toList();
        _wholeSalerBox.put(wholealer.id, wholealer);
        return wholealer;
      }
      return wholealer;
    }).toList();
  }
   void updateTotalPrice(String wholealerId) {
    state = state.map((wholealer) {
      if (wholealer.id == wholealerId) {
        double totalDebt = 0;
        double totalPaid = 0;

        for (var detail in wholealer.orderDetails) {
          totalDebt += detail.debt;
          totalPaid += detail.paid;
        }

        wholealer.totalPrice = totalDebt - totalPaid;
        _wholeSalerBox.put(wholealer.id, wholealer);
        return wholealer;
      }
      return wholealer;
    }).toList();
  }
}

class WholeSalerForm {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
}

final wholealerUpdateProvider = Provider<WholeSalerUpdater>((ref) {
  return WholeSalerUpdater(ref.read(wholeSalerProvider.notifier));
});

class WholeSalerUpdater {
  final WholeSalerNotifier _wholeSalerNotifier;

  WholeSalerUpdater(this._wholeSalerNotifier);

  void updateWholeSaler(WholeSaler updatedWholeSaler) {
    _wholeSalerNotifier.updateWholeSaler(updatedWholeSaler);
  }
}


final wholeSalerDetailUpdaterProvider =
    Provider<WholeSalerDetailUpdater>((ref) => WholeSalerDetailUpdater());

class WholeSalerDetailUpdater {
  double updateTotalPrice(List<WOrderDetail> orderDetails) {
    double totalDebt = 0;
    double totalPaid = 0;

    for (var detail in orderDetails) {
      totalDebt += detail.debt;
      totalPaid += detail.paid;
    }

    return totalDebt - totalPaid;
  }
}