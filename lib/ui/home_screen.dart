import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rds_test/provider/supplier_provider.dart';
import 'package:rds_test/widget/supplier_card.dart';

import '../data/api/api_service.dart';
import '../utils/result_state.dart';
import 'add_supplier.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SupplierProvider>(
      create: (_) => SupplierProvider(apiService: ApiService(http.Client())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Supplier List'),
        ),
        body: _buildList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddSupplier.routeName);
          },
          child: const Icon(
            Icons.add,
            size: 28,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildList() {
    return Consumer<SupplierProvider>(
      builder: (_, provider, __) {
        switch (provider.state) {
          case ResultState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ResultState.hasData:
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!provider.isFetching &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  provider.loadMore();
                }
                return false;
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: provider.supplierData.length +
                    (provider.isFetching ? 1 : 0),
                itemBuilder: (_, index) {
                  if (index == provider.supplierData.length) {
                    if (provider.isFetching) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const SizedBox();
                  }
                  final supplier = provider.supplierData[index];
                  return SupplierCard(supplierData: supplier);
                },
              ),
            );

          case ResultState.noData:
            return const Center(
              child: Text("No data available"),
            );
          case ResultState.error:
            return Center(
              child: Text("Error: ${provider.message}"),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
