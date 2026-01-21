import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kidsflix_flutter/controller/home_screen_controller.dart';
import 'package:kidsflix_flutter/delegate/search_delegate.dart';
import 'package:kidsflix_flutter/models/add_watchlist_response.dart';
import 'package:kidsflix_flutter/models/banner_response.dart';
import 'package:kidsflix_flutter/models/home_data_model.dart';
import 'package:kidsflix_flutter/models/home_data_request.dart';
import 'package:kidsflix_flutter/models/search_data.dart';
import 'package:kidsflix_flutter/models/search_query_response.dart';
import 'package:kidsflix_flutter/ui/games_screen.dart';
import 'package:kidsflix_flutter/util/common_class.dart';
import 'package:http/http.dart' as http;
import 'package:kidsflix_flutter/util/common_getters.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../util/app_strings.dart';

class SearchScreen extends StatefulWidget {
  dynamic function;

  SearchScreen(this.function, {super.key});

  bool visibility = false;
  bool focus = false;
  String contentId = "";
  String query = "";

  final HomeScreenController _homeController = Get.find<HomeScreenController>();

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);

    searchController.addListener(() {
      setState(() {
        widget.query = searchController.text.toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    print("Focus: ${_focus.hasFocus.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(gradient: bgLinearGradient),
          child: SafeArea(child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Focus(
                  onFocusChange: (bool) {
                    widget.focus = bool;
                  },
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: AppStrings.l10n.search,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: const Icon(Icons.search, size: 30)),
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    validator: (value) {
                      searchController.text = value.toString();
                    },
                    onFieldSubmitted: (value) {
                      saveData(value);
                      setState(() {
                        widget.query = value;
                      });
                    },
                    style: const TextStyle(
                        color: Colors.black, fontFamily: "moch", fontSize: 16),
                  ),
                ),
              ),
              if (!widget.focus && widget.query == "")
                Expanded(
                    child: FutureBuilder<List<PublishMasters>>(
                      future: getHomeData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return dataShimmer();
                        } else if (snapshot.hasData) {
                          final posts = snapshot.data!;
                          return buildHomeData(posts);
                        } else {
                          return const Text("No data available");
                        }
                      },
                    )),
              if (widget.focus)
                Expanded(
                    child: FutureBuilder<List<String>>(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container();
                        } else if (snapshot.hasData) {
                          final commonList = [];
                          final postsData = snapshot.data!;
                          for (var fruit in postsData) {
                            if (fruit
                                .toLowerCase()
                                .contains(widget.query.toLowerCase())) {
                              commonList.add(fruit);
                            }
                          }
                          return ListView.builder(
                            itemCount: commonList.length,
                            itemBuilder: (context, index) {
                              var result = commonList[index];
                              return GestureDetector(
                                child: ListTile(
                                  leading: Icon(Icons.history),
                                  title: Text(
                                    "$result",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "moch",
                                        fontSize: 18),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    searchController.text =
                                        commonList[index].toString();
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                              );
                            },
                          );
                        } else {
                          return const Text("No data available");
                        }
                      },
                    )),
              if (!widget.focus && widget.query != "")
                Expanded(
                    child: FutureBuilder<List<SearchResult>>(
                      future: getQueryData(widget.query),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return dataShimmer();
                        } else if (snapshot.hasData) {
                          final posts = snapshot.data!;
                          if (posts.isEmpty) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset('assets/lottie/box.json',
                                      width: 200, height: 200),
                                  Text(AppStrings.l10n.ooops_nothing_found,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: "moch",
                                          color: Colors.black))
                                ]);
                          } else {
                            return buildQueryResult(posts);
                          }
                        } else {
                          return Container(
                            height: 500,
                            width: 500,
                            child: Lottie.asset('assets/lottie/box.json'),
                          );
                        }
                      },
                    ))
            ],
          )),
        );
  }

  Widget buildQueryResult(List<SearchResult> posts) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(Constants.IMAGE_BASE_URL +
                      posts[index].imagepage.toString()),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onTap: () {
                widget.function(posts[index].contentId.toString());
              },
            ));
      },
      itemCount: posts.length,
    );
  }

  Widget buildHomeData(List<PublishMasters> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: GradientText(
                list[index].titleDisplay.toString(),
                style: const TextStyle(
                    fontSize: 16, fontFamily: "moch", color: Colors.black),
                colors: const [
                  Color(0xff002274),
                  Color(0xff6F1CC3),
                  Color(0xff195AF6)
                ],
              ),
            ),
            Builder(builder: (context) {
              if (list[index].layoutName == "games_slider") {
                return Container(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            elevation: 4,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(Constants.IMAGE_BASE_URL +
                                    findUrl(
                                        "games_slider",
                                        list[index]
                                                    .portalContents![innerIndex]
                                                    .contentImages !=
                                                null
                                            ? list[index]
                                                .portalContents![innerIndex]
                                                .contentImages!
                                                .toList()
                                            : [],
                                        list[index]
                                            .portalContents![innerIndex]
                                            .imagepage
                                            .toString())),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.to(() => GamesScreen(list[index]
                              .portalContents![innerIndex]
                              .id
                              .toString()));
                        },
                      );
                    },
                  ),
                );
              } else if (list[index].layoutName == "v_rect_3") {
                return Container(
                  height: 230,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(5),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AspectRatio(
                            aspectRatio: 244 / 332,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(Constants.IMAGE_BASE_URL +
                                  findUrl(
                                      "v_rect_3",
                                      list[index]
                                                  .portalContents![innerIndex]
                                                  .contentImages !=
                                              null
                                          ? list[index]
                                              .portalContents![innerIndex]
                                              .contentImages!
                                              .toList()
                                          : [],
                                      list[index]
                                          .portalContents![innerIndex]
                                          .imagepage
                                          .toString())),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (list[index].portalContents![innerIndex].album ==
                              "Games") {
                            Get.to(GamesScreen(list[index]
                                .portalContents![innerIndex]
                                .id
                                .toString()));
                          } else {
                            widget.function(list[index]
                                .portalContents![innerIndex]
                                .contentId
                                .toString());
                          }
                        },
                      );
                    },
                  ),
                );
              } else if (list[index].layoutName == "h_rect_2") {
                return Container(
                  height: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(5),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AspectRatio(
                            aspectRatio: 195 / 101,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Image.network(Constants.IMAGE_BASE_URL +
                                      findUrl(
                                          "h_rect_2",
                                          list[index]
                                                      .portalContents![
                                                          innerIndex]
                                                      .contentImages !=
                                                  null
                                              ? list[index]
                                                  .portalContents![innerIndex]
                                                  .contentImages!
                                                  .toList()
                                              : [],
                                          list[index]
                                              .portalContents![innerIndex]
                                              .imagepage
                                              .toString())),
                                  GestureDetector(
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    onTap: () {
                                      showBottomSheet(
                                          list[index]
                                              .portalContents![innerIndex]
                                              .info
                                              .toString(),
                                          list[index]
                                              .portalContents![innerIndex]
                                              .contentId
                                              .toString());
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (list[index].portalContents![innerIndex].album ==
                              "Games") {
                            Get.to(GamesScreen(list[index]
                                .portalContents![innerIndex]
                                .id
                                .toString()));
                          } else {
                            widget.function(list[index]
                                .portalContents![innerIndex]
                                .contentId
                                .toString());
                          }
                        },
                      );
                    },
                  ),
                );
              } else if (list[index].layoutName == "circle_4") {
                return Container(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.all(5),
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(Constants.IMAGE_BASE_URL +
                                    findUrl(
                                        "circle_4",
                                        list[index]
                                                    .portalContents![innerIndex]
                                                    .contentImages !=
                                                null
                                            ? list[index]
                                                .portalContents![innerIndex]
                                                .contentImages!
                                                .toList()
                                            : [],
                                        list[index]
                                            .portalContents![innerIndex]
                                            .imagepage
                                            .toString())),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (list[index].portalContents![innerIndex].album ==
                                "Games") {
                              Get.to(GamesScreen(list[index]
                                  .portalContents![innerIndex]
                                  .id
                                  .toString()));
                            } else {
                              widget.function(list[index]
                                  .portalContents![innerIndex]
                                  .contentId
                                  .toString());
                            }
                          });
                    },
                  ),
                );
              } else if (list[index].layoutName == "square_3") {
                return Container(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(5),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(Constants.IMAGE_BASE_URL +
                                  findUrl(
                                      "square_3",
                                      list[index]
                                                  .portalContents![innerIndex]
                                                  .contentImages !=
                                              null
                                          ? list[index]
                                              .portalContents![innerIndex]
                                              .contentImages!
                                              .toList()
                                          : [],
                                      list[index]
                                          .portalContents![innerIndex]
                                          .imagepage
                                          .toString())),
                            ),
                          ),
                        ),
                        onTap: () {
                          print(list[index].portalContents![innerIndex].album);
                          if (list[index].portalContents![innerIndex].album ==
                              "Games") {
                            Get.to(GamesScreen(list[index]
                                .portalContents![innerIndex]
                                .id
                                .toString()));
                          } else {
                            widget.function(list[index]
                                .portalContents![innerIndex]
                                .contentId
                                .toString());
                          }
                        },
                      );
                    },
                  ),
                );
              } else if (list[index].layoutName == "body_banner") {
                return Container(
                  height: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(5),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AspectRatio(
                            aspectRatio: 350 / 152,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(Constants.IMAGE_BASE_URL +
                                  findUrl(
                                      "body_banner",
                                      list[index]
                                                  .portalContents![innerIndex]
                                                  .contentImages !=
                                              null
                                          ? list[index]
                                              .portalContents![innerIndex]
                                              .contentImages!
                                              .toList()
                                          : [],
                                      list[index]
                                          .portalContents![innerIndex]
                                          .imagepage
                                          .toString())),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (list[index].portalContents![innerIndex].album ==
                              "Games") {
                            Get.to(GamesScreen(list[index]
                                .portalContents![innerIndex]
                                .id
                                .toString()));
                          } else {
                            widget.function(list[index]
                                .portalContents![innerIndex]
                                .contentId
                                .toString());
                          }
                        },
                      );
                    },
                  ),
                );
              } else {
                return Container(
                  height: 230,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(5),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AspectRatio(
                            aspectRatio: 244 / 332,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(Constants.IMAGE_BASE_URL +
                                  CommonClass.findCorrectImageUrl(
                                      "v_rect_3",
                                      (list[index]
                                                  .portalContents![innerIndex]
                                                  .contentImages ==
                                              null)
                                          ? []
                                          : list[index]
                                              .portalContents![innerIndex]
                                              .contentImages!
                                              .toList(),
                                      list[index]
                                          .portalContents![innerIndex]
                                          .imagepage
                                          .toString())),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (list[index].portalContents![innerIndex].album ==
                              "Games") {
                            Get.to(GamesScreen(list[index]
                                .portalContents![innerIndex]
                                .id
                                .toString()));
                          } else {
                            widget.function(list[index]
                                .portalContents![innerIndex]
                                .contentId
                                .toString());
                          }
                        },
                      );
                    },
                  ),
                );
              }
            })
          ],
        );
      },
    );
  }

  Future<List<PublishMasters>> getHomeData() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();

      HomeDataRequest model = HomeDataRequest();

      print("object");

      model.portalId = sp.getString("portalId").toString();
      model.pageId = "1";
      model.pageName = "search";
      model.scheme = "SearchPageContent";

      print("object");

      final response =
          await http.post(Uri.parse(Constants.BASE_URL + Constants.SEARCH_DATA),
              headers: <String, String>{
                "accessToken": sp.getString("token").toString(),
                "userId": sp.getString("userId").toString(),
                "source": "app",
                'Content-Type': "application/json",
              },
              body: jsonEncode(model.toJson()));

      print("object");

      if (response.statusCode == 200) {
        HomeDataModel result =
            HomeDataModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        return result.publishMasters!.toList();
      } else {
        throw Exception("Failed to load ${response.statusCode}");
      }
    } catch (e) {
      print("object $e");
      throw Exception("Failed to load ${e}");
    }
  }

  Future<List<SearchResult>> getQueryData(String query) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();

      var model = <String, String>{
        "portalId": sp.getString("portalId").toString(),
        "searchKeyword": query
      };

      final response = await http.post(
          Uri.parse(Constants.BASE_URL + Constants.SEARCH_QUERY),
          headers: <String, String>{
            "accessToken": sp.getString("token").toString(),
            "userId": sp.getString("userId").toString(),
            "source": "app",
            'Content-Type': "application/json",
          },
          body: jsonEncode(model));

      if (response.statusCode == 200) {
        SearchQueryResponse result =
            SearchQueryResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        return result.searchResult!.toList();
      } else {
        throw Exception("Failed to load ${response.statusCode}");
      }
    } catch (e) {
      print("object $e");
      throw Exception("Failed to load ${e}");
    }
  }

  Widget dataShimmer() {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 500),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  height: 30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.maxFinite,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const AspectRatio(
                          aspectRatio: 244 / 332,
                          child: Card(),
                        );
                      }),
                )
              ],
            );
          }),
    );
  }

  void showSearchBar() {
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
    );
  }

  Future<List<String>> getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.containsKey(Constants.SEARCH_CACHE_DATA)) {
      SearchData model = SearchData.fromJson(jsonDecode(
          (sp.getString(Constants.SEARCH_CACHE_DATA) == null)
              ? "{}"
              : sp.getString(Constants.SEARCH_CACHE_DATA)!));
      return (model.data == null) ? [] : model.data!.toList();
    } else {
      var model = SearchData();
      model.data = [];
      sp.setString(Constants.SEARCH_CACHE_DATA, jsonEncode(model.toJson()));
      return [];
    }
  }

  String findUrl(String key, List<ContentImages> list, String imageUrl) {
    for (var item in list) {
      if (item.layoutName == key) {
        return item.contextPath.toString();
      }
    }
    return imageUrl;
  }

  saveData(String key) async {
    if (key.trim() == "") {
      return;
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    var model = SearchData.fromJson(jsonDecode(
        (sp.getString(Constants.SEARCH_CACHE_DATA) == null)
            ? "{}"
            : sp.getString(Constants.SEARCH_CACHE_DATA)!));

    model.data ??= [];
    model.data?.add(key);
    sp.setString(Constants.SEARCH_CACHE_DATA, jsonEncode(model.toJson()));
  }

  showBottomSheet(String title, String contentId) {
    showModalBottomSheet<void>(
        // context and builder are
        // required properties in this widget
        context: context,
        builder: (BuildContext context) {
          // we set up a container inside which
          // we create center column and display text

          // Returning SizedBox instead of a Container
          return Container(
            height: 200,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(gradient: bgLinearGradient),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: GradientText(
                        title,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 17,
                            fontFamily: "moch",
                            color: Colors.black),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 1,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20, right: 20),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ImageConstants.watchlist_grad,
                                  width: 40, height: 40),
                              SizedBox(height: 10),
                              GradientText(
                                AppStrings.l10n.watchlist,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "moch",
                                    color: Colors.black),
                                colors: const [
                                  Color(0xff002274),
                                  Color(0xff6F1CC3),
                                  Color(0xff195AF6)
                                ],
                              )
                            ],
                          ),
                          onTap: () async {
                            // FutureBuilder(
                            //   future: widget._homeController.addWatchList(contentId),
                            //   builder: (context,snapshot) {
                            //       if(snapshot.hasData){
                            //           if(snapshot.data!.responseDescription?.errorCode==0){
                            //               return
                            //           }
                            //       }
                            //   },
                            // );
                            Navigator.pop(context);

                            AddWatchListResponse response = await widget
                                ._homeController
                                .addWatchList(contentId);

                            if (response.responseDescription?.errorCode == 0 ||
                                response.responseDescription?.errorCode ==
                                    1200) {
                              showSnackBar(AppStrings.l10n.added_to_watchlist);
                            }
                          },
                        ),
                        GestureDetector(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ImageConstants.share_grad,
                                  width: 40, height: 40),
                              SizedBox(height: 10),
                              GradientText(
                                AppStrings.l10n.share,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "moch",
                                    color: Colors.black),
                                colors: const [
                                  Color(0xff002274),
                                  Color(0xff6F1CC3),
                                  Color(0xff195AF6)
                                ],
                              )
                            ],
                          ),
                          onTap: () {
                            CommonClass.shareApp();
                          },
                        )
                      ],
                    ))
                  ],
                )
              ],
            ),
          );
        });
  }

  void showSnackBar(String s) {}
}
