import 'package:arabakiralama/components/custom_button.dart';
import 'package:arabakiralama/models/product.dart';
import 'package:arabakiralama/utils/application_state.dart';
import 'package:arabakiralama/utils/custom_theme.dart';
import 'package:arabakiralama/utils/firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ArabaScreen extends StatefulWidget {
  final Product product;

  const ArabaScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ArabaScreen> createState() => _ArabaScreenState();
}

class _ArabaScreenState extends State<ArabaScreen> {
  bool addButtonLoad = false;

  void onAddToCart() async {
    setState(() async {
      setState(() {
        addButtonLoad = true;
      });

      await FirestoreUtil.addToCart(
          Provider.of<ApplicationState>(context, listen: false).user,
          widget.product.id);
      setState(() {
        addButtonLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.product.image,
                        ),
                      ),
                      Positioned(
                        top: 35,
                        right: 35,
                        child: Container(
                          decoration: ShapeDecoration(
                              color: CustomTheme.yellow,
                              shape: CircleBorder(),
                              shadows: CustomTheme.buttonShadow),
                          child: IconButton(
                            icon: const Icon(Icons.share),
                            color: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.headlineLarge!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 22),
                            child: Text(widget.product.title),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                Text("Gün: "),
                                Text("\$" + widget.product.price.toString())
                              ],
                            ),
                          ),
                          CustomButton(
                              text: "Kiralayın",
                              onPress: onAddToCart,
                              loading: addButtonLoad),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "Araba hakkında",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              widget.product.description,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 35,
              left: 30,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          offset: Offset(1, 3),
                          color: CustomTheme.grey)
                    ]),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
