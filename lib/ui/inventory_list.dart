import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rds_test/widget/inventory_card.dart';

import '../data/api/api_service.dart';
import '../provider/inventory_provider.dart';
import '../utils/result_state.dart';
import 'add_inventory.dart';

class InventoryScreen extends StatefulWidget {
  static const routeName = '/inventory';

  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InventoryProvider>(
      create: (_) => InventoryProvider(apiService: ApiService(http.Client())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inventory List'),
        ),
        body: _buildList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddInventory.routeName);
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

  // Widget _buildList() {
  //   return Consumer<InventoryProvider>(
  //     builder: (_, provider, __) {
  //       switch (provider.state) {
  //         case ResultState.loading:
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //
  //         case ResultState.hasData:
  //           return NotificationListener<ScrollNotification>(
  //             onNotification: (ScrollNotification scrollInfo) {
  //               if (!provider.isFetching &&
  //                   scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
  //                 provider.loadMore();
  //               }
  //               return false;
  //             },
  //             child: ListView.builder(
  //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //               itemCount: provider.inventoryData.length +
  //                   (provider.isFetching ? 1 : 0),
  //               itemBuilder: (_, index) {
  //                 if (index >= provider.inventoryData.length) {
  //                   return const SizedBox(); // Prevent access to invalid index
  //                 }
  //                 final item = provider.inventoryData[index];
  //                 return InventoryCard(inventoryData: item);
  //               },
  //             ),
  //           );
  //
  //         case ResultState.noData:
  //           return const Center(
  //             child: Text("No inventory items available."),
  //           );
  //
  //         case ResultState.error:
  //           return Center(
  //             child: Text("Error: ${provider.message}"),
  //           );
  //
  //         default:
  //           return const SizedBox();
  //       }
  //     },
  //   );
  // }

  Widget _buildList() {
    return Consumer<InventoryProvider>(
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
                itemCount: provider.inventoryData.length +
                    (provider.isFetching ? 1 : 0),
                itemBuilder: (_, index) {
                  if (index == provider.inventoryData.length) {
                    if (provider.isFetching) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const SizedBox();
                  }
                  if (provider.inventoryData.isEmpty) {
                    return const Text('No inventory data ');
                  }
                  final item = provider.inventoryData[index];
                  return InventoryCard(inventoryData: item);
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
