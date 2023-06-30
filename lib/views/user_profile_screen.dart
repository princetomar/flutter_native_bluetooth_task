import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_profile_model.dart';
import '../queries/api_query.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isDataLoading = true;
  UserProfileResponseModel? userDetails;
  double profileImageHeight = 144;
  double coverHeight = 280;

  @override
  void initState() {
    // TODO: implement initState
    // ApiQueries.getUserProfile(context);
    getUserProfile();
    super.initState();
  }

  void getUserProfile() async {
    userDetails = await ApiQueries.fetchUserDetails();
    setState(() {
      isDataLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileImageHeight / 2;
    return Scaffold(
      body: Container(
        // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: isDataLoading
            ? Center(child: CircularProgressIndicator())
            : userDetails != null
                ? ListView(
                    children: [
                      buildImageSection(top),
                      SizedBox(
                        height: 20,
                      ),
                      buildUserContentSection(
                          userDetails!.results![0].name!.first!.toString() +
                              " " +
                              userDetails!.results![0].name!.title!.toString() +
                              " " +
                              userDetails!.results![0].name!.last!.toString(),
                          userDetails!.results![0].location!.city!.toString() +
                              ", " +
                              userDetails!.results![0].location!.country!
                                  .toString(),
                          userDetails!.results![0].email!.toString(),
                          userDetails!.results![0].dob!.date!.toString(),
                          userDetails!.results![0].dob!.age!.toString() +
                              " years",
                          userDetails!.results![0].registered!.age!.toString()),
                    ],
                  )
                // Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text(
                //               userDetails!.results![0].name!.first!.toString() +
                //                   " " +
                //                   userDetails!.results![0].name!.title!.toString() +
                //                   " " +
                //                   userDetails!.results![0].name!.last!.toString())
                //             ],
                //           )
                : Text("Failed to fetched Data"),
      ),
    );
  }

  buildImageSection(double topV) {
    final bottomMarginValue = profileImageHeight / 2;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottomMarginValue),
          child: buildThumbnailImage(userDetails!.results![0].picture!.large!),
        ),
        Positioned(
          top: topV,
          child: buildProfileImage(userDetails!.results![0].picture!.large!),
        )
      ],
    );
  }

  buildThumbnailImage(String thumbnailURL) {
    return Container(
      width: double.infinity,
      height: coverHeight,
      child: Image.network(
        thumbnailURL,
        fit: BoxFit.cover,
      ),
    );
  }

  buildProfileImage(String imageURL) {
    return CircleAvatar(
      radius: profileImageHeight / 2,
      backgroundImage: NetworkImage(imageURL),
    );
  }

  // Content Section
  buildUserContentSection(name, location, email, dob, age, registration) {
    final space = profileImageHeight / 10;
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: space,
        ),
        Text(
          email,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.blue,
          ),
        ),
        SizedBox(
          height: space,
        ),
        Divider(
          thickness: 1,
        ),
        SizedBox(
          height: space,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  age,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "USER AGE",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  registration + " years",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "REGISTRATION DAYS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: space,
        ),
        Divider(
          thickness: 1,
        ),
        Text(
          "LOCATION",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Text(
          location,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black54,
          ),
        ),
        SizedBox(
          height: space,
        ),
        Divider(
          thickness: 1,
        ),
        Text(
          "DATE OF BIRTH",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Text(
          dob,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
