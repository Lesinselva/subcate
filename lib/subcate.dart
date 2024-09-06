library subcate;

import 'package:animatedfloat/animatedfloat.dart';
import 'package:custom_dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:net_store/mian.dart';
import 'package:flutter_svg/svg.dart';

class Subcate extends StatefulWidget {
  final String? firstButtonText;
  final String secButtonText;
  final Color color;
  final String title;

  const Subcate({
    super.key,
    this.firstButtonText,
    required this.secButtonText,
    required this.color,
    required this.title,
  });

  @override
  _SubcateState createState() => _SubcateState();
}

class _SubcateState extends State<Subcate> {
  final List<Widget> containers = [];
  final ScrollController scrollController = ScrollController();

  void addCategoryContainer(String title) {
    if (title.isNotEmpty) {
      setState(() {
        containers.add(buildCategoryContainer(title));
      });
    }
  }

  void _addProductContainer(String title, String price) {
    if (title.isNotEmpty && price.isNotEmpty) {
      setState(() {
        containers.add(buildProductContainer(title, price, context));
      });
    }
  }

  Widget buildCategoryContainer(String title) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Subcate(
                  secButtonText: 'Add Product',
                  color: Colors.black,
                  title: title,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'lib/images/category.svg',
                      package: 'inventory',
                      width: 33,
                      height: 33,
                    ),
                    const SizedBox(width: 12),
                    Text(title,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400))),
                  ],
                ),
                const Icon(Icons.more_vert)
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  Widget buildProductContainer(
      String title, String price, BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NetStore.editProduct(color: widget.color),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset(
                  'lib/images/product.svg',
                  package: 'inventory',
                  height: 33,
                  width: 33,
                ),
                const SizedBox(width: 12),
                Text(title,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w300))),
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: containers.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      containers[index],
                      if (index != containers.length - 1)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Divider(
                            thickness: 1,
                            height: 1,
                            color: Color(0x7704938D),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomAnimatedFloatingActionButton(
                    svgPath: 'lib/images/addProduct.svg',
                    package: 'inventory',
                    text: 'Add product',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final firstFieldController = TextEditingController();
                          final secondFieldController = TextEditingController();

                          return CustomDialog(
                            icon: Icons.note_alt_outlined,
                            secicon: Icons.currency_rupee,
                            title: 'Add Product',
                            subtitle: 'Product title',
                            firstButtonLabel: 'Create',
                            firstButtonColor:
                                const Color.fromARGB(255, 39, 236, 22),
                            firstButtonAction: (String title) {
                              _addProductContainer(
                                  title, secondFieldController.text);
                              Navigator.of(context).pop();
                            },
                            secondButtonLabel: 'Cancel',
                            secondButtonColor: Colors.red,
                            firstFieldController: firstFieldController,
                            secondFieldController: secondFieldController,
                            maxLength: 100,
                            titleBackgroundGradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 45, 255, 26),
                                Color.fromARGB(255, 1, 136, 57),
                              ],
                            ),
                            firstButtonIcon: Icons.check,
                            secondButtonIcon: Icons.close,
                            secondButtonAction: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    },
                    scrollController: scrollController,
                  ),
                  const SizedBox(height: 16),
                  CustomAnimatedFloatingActionButton(
                    svgPath: 'lib/images/addCate.svg',
                    package: 'inventory',
                    text: 'Add Category',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final firstFieldController = TextEditingController();
                          return CustomDialog(
                            firstButtonIcon: Icons.check,
                            secondButtonIcon: Icons.close,
                            secondButtonAction: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icons.category,
                            title: 'Add Category',
                            subtitle: 'Category title',
                            firstButtonLabel: 'Create',
                            firstButtonColor:
                                const Color.fromARGB(255, 39, 236, 22),
                            firstButtonAction: (String title) {
                              addCategoryContainer(title);
                              Navigator.of(context).pop();
                            },
                            secondButtonLabel: 'Cancel',
                            secondButtonColor: Colors.red,
                            firstFieldController: firstFieldController,
                            maxLength: 32,
                            titleBackgroundGradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 251, 255, 26),
                                Color.fromARGB(255, 136, 127, 1),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    scrollController: scrollController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
