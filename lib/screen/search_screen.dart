import 'dart:developer';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/assets_manager.dart';
import '../widgets/products/product_widget.dart';
import '../widgets/title_text.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const TitlesTextWidget(label: "Search"),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsManager.shoppingCart),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        // setState(() {
                        searchTextController.clear();
                        FocusScope.of(context).unfocus();
                        // });
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  onChanged: (value) {},
                  onSubmitted: (value) {
                    log(searchTextController.text);
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: DynamicHeightGridView(
                    itemCount: productProvider.getProducts.length,
                    builder: ((context, index) {
                      return ChangeNotifierProvider.value(
                        value: productProvider.getProducts[index],
                        child: const ProductWidget(),
                      );
                    }),
                    crossAxisCount: 2,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
