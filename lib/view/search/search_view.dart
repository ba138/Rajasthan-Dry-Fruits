import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/repository/search_section_ui.dart';
import 'package:rjfruits/res/components/search_enums.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/search/default_search_section.dart';
import 'package:rjfruits/view/search/filter_search_section.dart';
import 'package:rjfruits/view/search/search_Section.dart';
import 'package:rjfruits/view_model/shop_view_model.dart';

import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          image: DecorationImage(
              image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const VerticalSpeacing(30.0),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.west,
                          color: AppColor.appBarTxColor,
                        ),
                      ),
                      const SizedBox(width: 100.0),
                      Text(
                        'Search',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.appBarTxColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(20.0),
                  Consumer<ShopRepositoryProvider>(
                    builder: (context, searchModel, _) {
                      return Row(
                        children: [
                          Container(
                            height: 46,
                            width: MediaQuery.of(context).size.width * 0.66,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColor.boxColor,
                            ),
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                if (searchController.text.isNotEmpty) {
                                  searchModel.search(
                                    value,
                                  );
                                  Provider.of<SearchUiSwithchRepository>(
                                          context,
                                          listen: false)
                                      .switchToType(
                                          SearchUIType.SearchSectionUi);
                                } else {
                                  Provider.of<SearchUiSwithchRepository>(
                                          context,
                                          listen: false)
                                      .switchToType(
                                          SearchUIType.DeaultSearchSection);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: AppColor.primaryColor,
                                ),
                                suffixIcon: Container(
                                  height: 47.0,
                                  width: 47.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: AppColor.primaryColor),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, RoutesName.filter);
                                      },
                                      icon: const ImageIcon(
                                        AssetImage("images/filter.png"),
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                                hintStyle: GoogleFonts.getFont(
                                  "Roboto",
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.textColor2,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 18,
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<SearchUiSwithchRepository>(context,
                                      listen: false)
                                  .switchToType(
                                      SearchUIType.DeaultSearchSection);
                            },
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.getFont(
                                "Poppins",
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const VerticalSpeacing(16),
                  Consumer<SearchUiSwithchRepository>(
                    builder: (context, uiState, _) {
                      Widget selectedWidget;

                      switch (uiState.selectedType) {
                        case SearchUIType.SearchSectionUi:
                          selectedWidget = const SearchSectionUi();
                          break;
                        case SearchUIType.FilterSearchSection:
                          selectedWidget = const FilterSearchSection();
                          break;

                        case SearchUIType.DeaultSearchSection:
                          selectedWidget = const DeaultSearchSection();
                          break;
                      }

                      return selectedWidget;
                    },
                  ),
                  const VerticalSpeacing(20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
