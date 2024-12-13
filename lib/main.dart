import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rds_test/data/model/request/inventory_request.dart';
import 'package:rds_test/data/model/response/inventory_response.dart';
import 'package:rds_test/data/model/response/supplier_response.dart';
import 'package:rds_test/provider/add_inventory_provider.dart';
import 'package:rds_test/provider/add_supplier_provider.dart';
import 'package:rds_test/provider/inventory_provider.dart';
import 'package:rds_test/provider/supplier_provider.dart';
import 'package:rds_test/ui/add_inventory.dart';
import 'package:rds_test/ui/add_supplier.dart';
import 'package:rds_test/ui/detail_inventory.dart';
import 'package:rds_test/ui/home_screen.dart';
import 'package:rds_test/ui/inventory_list.dart';
import 'package:rds_test/ui/main_screen.dart';

import 'data/api/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) =>
                  SupplierProvider(apiService: ApiService(http.Client()))),
          ChangeNotifierProvider(
              create: (_) =>
                  AddSupplierProvider(apiService: ApiService(http.Client()))),
          ChangeNotifierProvider(
              create: (_) =>
                  InventoryProvider(apiService: ApiService(http.Client()))),
          ChangeNotifierProvider(
              create: (_) =>
                  AddInventoryProvider(apiService: ApiService(http.Client()))),
        ],
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'RDS',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: MainScreen.routeName,
            routes: {
              MainScreen.routeName: (context) => MainScreen(),
              HomeScreen.routeName: (context) => HomeScreen(),
              InventoryScreen.routeName: (context) => InventoryScreen(),
              AddSupplier.routeName: (context) {
                final args = ModalRoute.of(context)?.settings.arguments;
                return AddSupplier(supplierData: args != null ? args as SupplierData : null);
              },
              AddInventory.routeName: (context) {
                final args = ModalRoute.of(context)?.settings.arguments;
                return AddInventory(inventoryRequest: args != null ? args as InventoryRequest : null);
              },
              DetailInventoryScreen.routeName: (context) =>
                  DetailInventoryScreen(inventory: ModalRoute.of(context)!.settings.arguments as InventoryData,),
            },
          );
        },
    );
  }
}
