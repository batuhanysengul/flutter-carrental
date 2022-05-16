import 'package:arabakiralama/components/grid_card.dart';
import 'package:arabakiralama/components/loader.dart';
import 'package:arabakiralama/models/product.dart';
import 'package:arabakiralama/screens/login.dart';
import 'package:arabakiralama/utils/firestore.dart';
import 'package:flutter/material.dart';

import 'araba.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final data = ["1", "2"];
  Future<List<Product>>? products;

  @override
  void initState() {
    super.initState();
    products = FirestoreUtil.getProducts([]);
  }

  @override
  Widget build(BuildContext context) {
    onCardPress(Product product) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArabaScreen(
                    product: product,
                  )));
    }

    return FutureBuilder<List<Product>>(
        future: products,
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return GridView.builder(
                itemCount: snapshot.data?.length,
                padding: const EdgeInsets.symmetric(vertical: 30),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30),
                itemBuilder: (BuildContext context, int index) {
                  return GridCard(
                      product: snapshot.data![index],
                      index: index,
                      onPress: () {
                        onCardPress(snapshot.data![index]);
                      });
                });
          } else {
            return const Center(child: Loader());
          }
        });
  }
}
