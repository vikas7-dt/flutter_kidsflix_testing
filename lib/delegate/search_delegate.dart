import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kidsflix_flutter/models/search_data.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> dataCache = [];

  // first overwrite to
  // clear the search text

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    saveData(query);

    List<String> matchQuery = [];
    return FutureBuilder<List<String>>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final posts = snapshot.data!;
          for (var fruit in posts) {
            if (fruit.toLowerCase().contains(query.toLowerCase())) {
              matchQuery.add(fruit);
            }
          }
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return ListTile(
                title: Text(result),
              );
            },
          );
        } else {
          return const Text("No data available");
        }
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    return FutureBuilder<List<String>>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final posts = snapshot.data!;
          for (var fruit in posts) {
            if (fruit.toLowerCase().contains(query.toLowerCase())) {
              matchQuery.add(fruit);
            }
          }
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return ListTile(
                title: Text(result),
              );
            },
          );
        } else {
          return const Text("No data available");
        }
      },
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

  saveData(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(Constants.SEARCH_CACHE_DATA, key);
  }
}
