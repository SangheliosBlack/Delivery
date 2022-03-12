import 'package:delivery/global/enviroment.dart';
import 'package:delivery/models/customer.dart';
import 'package:delivery/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class StripeService with ChangeNotifier {
  String _tarjetaPredeterminada = '';

  String get tarjetaPredeterminada => _tarjetaPredeterminada;

  set tarjetaPredeterminada(String valor) {
    _tarjetaPredeterminada = valor;
    notifyListeners();
  }

  StripeService() {
    obtenerCustomer();
  }

  late Customer customer;

  obtenerCustomer() async {
    final resp = await http
        .get(Uri.parse('${Statics.apiUrl}/stripe/obtenerCliente'), headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });
    if (resp.statusCode == 200) {
      final customerResponse = customerFromJson(resp.body);
      customer = customerResponse;
      tarjetaPredeterminada = customer.invoiceSettings.defaultPaymentMethod;
      return true;
    } else {
      return false;
    }
  }
}
