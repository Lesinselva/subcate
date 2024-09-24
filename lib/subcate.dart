library subcate;

import 'package:animatedfloat/animatedfloat.dart';
import 'package:custom_dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insubcate/insubcate.dart';
import 'package:net_store/mian.dart';
import 'package:flutter_svg/svg.dart';

class Subcate extends StatefulWidget {
  final Color color;
  final String title;
  final Color scaffoldColor;

  const Subcate({
    super.key,
    required this.color,
    required this.title,
    required this.scaffoldColor,
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
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Insubcate(
                  color: Colors.black,
                  title: title,
                  scaffoldColor: widget.scaffoldColor,
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
                      package: 'subcate',
                      width: 33,
                      height: 33,
                    ),
                    const SizedBox(width: 16),
                    Text(title,
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400))),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProductContainer(
      String title, String price, BuildContext context) {
    return Column(
      children: [
        InkWell(
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
                  package: 'subcate',
                  height: 33,
                  width: 33,
                ),
                const SizedBox(width: 16),
                Text(title,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w300))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.scaffoldColor,
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 1.0,
        backgroundColor: Colors.teal.shade50,
        titleSpacing: 5,
        title: Row(
          children: [
            // IconButton(
            //   icon: const Icon(Icons.arrow_back),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            // const SizedBox(width: 8),
            Text(widget.title,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: containers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        containers[index],
                        //  if (index != containers.length - 1)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: Color(0xFFF4F4F4),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomAnimatedFloatingActionButton(
                  svgPath: 'lib/images/addProduct.svg',
                  package: 'subcate',
                  text: 'Add product',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final firstFieldController = TextEditingController();
                        final secondFieldController = TextEditingController();

                        return CustomDialog(
                          secicon: Icons.currency_rupee,
                          title: 'Add Product',
                          firstButtonColor: Colors.white,
                          firstButtonIconColor: const Color(0xFF03A758),
                          firstButtonAction: (String title) {
                            _addProductContainer(
                                title, secondFieldController.text);
                            Navigator.of(context).pop();
                          },
                          secondButtonColor: Colors.white,
                          firstFieldController: firstFieldController,
                          secondFieldController: secondFieldController,
                          maxLength: 100,
                          titleBackgroundColor: const Color(0xFF04938D),
                          secondButtonIconColor: const Color(0xFFFF1C1C),
                          firstButtonIcon: Icons.check,
                          secondButtonIcon: Icons.close,
                          secondButtonAction: () {
                            Navigator.of(context).pop();
                          },
                          hintText: 'Product Title',
                          hintText2: 'Selling price',
                        );
                      },
                    );
                  },
                  scrollController: scrollController,
                ),
                const SizedBox(height: 16),
                CustomAnimatedFloatingActionButton(
                  svgPath: 'lib/images/addCate.svg',
                  package: 'subcate',
                  text: 'Add Subcategory',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final firstFieldController = TextEditingController();
                        return CustomDialog(
                          firstButtonIcon: Icons.check,
                          secondButtonIcon: Icons.close,
                          firstButtonIconColor: const Color(0xFF03A758),
                          secondButtonIconColor: const Color(0xFFFF1C1C),
                          secondButtonAction: () {
                            Navigator.of(context).pop();
                          },
                          title: 'Add Subcategory',
                          subtitle: 'Enter a Title for subcategroy',
                          firstButtonAction: (String title) {
                            addCategoryContainer(title);
                            Navigator.of(context).pop();
                          },
                          secondButtonColor: Colors.white,
                          firstFieldController: firstFieldController,
                          maxLength: 32,
                          titleBackgroundColor: const Color(0xFF04938D),
                          hintText: 'Subcategroy Title',
                          hintText2: 'Selling price',
                          firstButtonColor: Colors.white,
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
    );
  }
}
