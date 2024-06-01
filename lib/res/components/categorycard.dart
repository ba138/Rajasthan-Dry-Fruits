// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/repository/home_ui_repository.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/enums.dart';
import 'package:rjfruits/view_model/home_view_model.dart';

class CategoryCart extends StatefulWidget {
  const CategoryCart({
    super.key,
    required this.text,
  });

  final String text;

  @override
  _CategoryCartState createState() => _CategoryCartState();
}

class _CategoryCartState extends State<CategoryCart> {
  Color _backgroundColor = AppColor.boxColor;
  Color _textColor = AppColor.textColor1;
  void checkUiType() {}

  @override
  void initState() {
    // ignore: unrelated_type_equality_checks
    checkUiType();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUIType =
        Provider.of<HomeUiSwithchRepository>(context, listen: false)
            .selectedType;

    if (currentUIType == UIType.DefaultSection) {
      setState(() {
        _backgroundColor = AppColor.boxColor;
        _textColor = AppColor.textColor1;
      });
    }

    return GestureDetector(
      onTap: () {
        Provider.of<HomeRepositoryProvider>(context, listen: false)
            .categoryFilter(
          widget.text,
        );
        Provider.of<HomeUiSwithchRepository>(context, listen: false)
            .switchToType(
          UIType.CategoriesSection,
        );
        setState(() {
          _backgroundColor = (_backgroundColor == AppColor.boxColor)
              ? AppColor.primaryColor
              : AppColor.boxColor;
          _textColor = (_textColor == AppColor.whiteColor)
              ? AppColor.textColor1
              : AppColor.whiteColor;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IntrinsicWidth(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.text,
                      style: GoogleFonts.getFont(
                        "Poppins",
                        color: _textColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
