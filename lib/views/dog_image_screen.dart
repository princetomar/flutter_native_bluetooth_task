import 'package:flutter/material.dart';
import 'package:flutter_task/models/dog_image_model.dart';

import '../queries/api_query.dart';

class DogImageScreen extends StatefulWidget {
  const DogImageScreen({super.key});

  @override
  State<DogImageScreen> createState() => _DogImageScreenState();
}

class _DogImageScreenState extends State<DogImageScreen> {
  bool isDataLoading = true;
  DogImageResponseModel? dogDetails;
  double profileImageHeight = 144;
  double coverHeight = 280;

  @override
  void initState() {
    // TODO: implement initState
    // ApiQueries.getUserProfile(context);
    getDogProfile();
    super.initState();
  }

  void getDogProfile() async {
    dogDetails = await ApiQueries.fetchDogDetails();
    setState(() {
      isDataLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dog Image Screen"),
      ),
      body: Container(
        // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: isDataLoading
            ? Center(child: CircularProgressIndicator())
            : dogDetails != null
                ? Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Image.network(
                          dogDetails!.message.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          getDogProfile();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Refresh",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                            Icon(Icons.refresh),
                          ],
                        ),
                      ),
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
}
