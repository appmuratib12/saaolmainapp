import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:saaolapp/constant/ApiConstants.dart';
import 'package:saaolapp/data/model/apiresponsemodel/BlogsResponseData.dart';

class BlogProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  BlogsResponseData? blogsResponseData;

  Future<void> fetchBlogs(String category) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://saaol.org/saaolapp/api/blogs/category/$category'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        blogsResponseData = BlogsResponseData.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      errorMessage = 'No internet connection. Please check your network.';
    } on HttpException {
      errorMessage = 'Could not retrieve data. Please try again later.';
    } on FormatException {
      errorMessage = 'Invalid response format. Please contact support.';
    } catch (e) {
      errorMessage = 'Something went wrong. Please try again.';
    }
    isLoading = false;
    notifyListeners();
  }

}
