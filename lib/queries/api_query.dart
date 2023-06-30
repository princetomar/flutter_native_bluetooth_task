import 'dart:convert';
import 'package:flutter_task/global.dart';
import 'package:flutter_task/models/dog_image_model.dart';
import 'package:flutter_task/models/user_profile_model.dart';

class ApiQueries {
  static Future<UserProfileResponseModel> fetchUserDetails() async {
    // Simulating API request delay with a 2-second delay
    await Future.delayed(Duration(seconds: 2));

    final response = await globalHandler.requestGet(AppURLS.getUserProfileURL);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserProfileResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  static Future<DogImageResponseModel> fetchDogDetails() async {
    // Simulating API request delay with a 2-second delay
    await Future.delayed(Duration(seconds: 2));

    final response =
        await globalHandler.requestGet(AppURLS.getRandomDogImageURL);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DogImageResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }
}

class AppURLS {
  static var getUserProfileURL = "https://randomuser.me/api/";
  static var getRandomDogImageURL = "https://dog.ceo/api/breeds/image/random";
}
