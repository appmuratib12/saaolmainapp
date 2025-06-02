import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineYearResponse.dart';
import 'package:saaolapp/data/network/BaseApiService.dart';
import 'package:shimmer/shimmer.dart';
import '../common/app_colors.dart';
import 'Magazine/MagazineBlogDetailPage.dart';

class EmagazineScreen extends StatefulWidget {
  const EmagazineScreen({super.key});

  @override
  State<EmagazineScreen> createState() => _EmagazineScreenState();
}

class _EmagazineScreenState extends State<EmagazineScreen> {
  int? selectedIndex = 0;
  String selectedItem = '2025';
  String storeMonth = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'SAAOL E-Magazine',
          style: TextStyle(
            fontFamily: 'FontPoppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment:CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: FutureBuilder<EmagazineYearResponse>(
                future: BaseApiService().getEmagazineData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 50,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('No internet connection'));

                  } else if (!snapshot.hasData ||
                      snapshot.data!.data == null ||
                      snapshot.data!.data!.isEmpty) {
                    return const Center(child: Text('No Emagazine available.'));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data!.data![index];
                        final isSelected = selectedIndex == index;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                selectedItem = item;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: isSelected
                                    ? [
                                  BoxShadow(
                                    color: AppColors.primaryColor
                                        .withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                                    : [
                                  BoxShadow(
                                    color:
                                    Colors.grey.withOpacity(0.15),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    fontFamily: 'FontPoppins',
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Expanded(child:FutureBuilder<EmagazineResponse>(
              future: BaseApiService().getEmagazine(selectedItem.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 130,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  final errorMessage = snapshot.error.toString();
                  if (errorMessage.contains('No internet connection')) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wifi_off_rounded,
                              size:30,
                              color: Colors.redAccent,
                            ),
                            SizedBox(height:8),
                            Text(
                              'No Internet Connection',
                              style: TextStyle(
                                fontSize:14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'Please check your network settings and try again.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:12,
                                fontFamily: 'FontPoppins',
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('Error: $errorMessage'));
                  }
                } else if (!snapshot.hasData ||
                    snapshot.data!.emagzines == null ||
                    snapshot.data!.emagzines!.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 12),
                          Text(
                            'No Emagazine available.',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Please check back later. New data will be available soon!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'FontPoppins',
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return  ListView.builder(
                    itemCount: snapshot.data!.emagzines!.length,
                    scrollDirection:Axis.vertical,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = snapshot.data!.emagzines![index];
                      return InkWell(
                        onTap: () {
                          storeMonth = item.month.toString();
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    MagazineBlogDetailPage(month:storeMonth,year:selectedItem)),
                          );
                        },
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            shadowColor: Colors.grey.withOpacity(0.2),
                            child: Container(
                              width: double.infinity,
                              height: 320,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Magazine Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child:  Image(
                                      image: NetworkImage(item.image.toString()),
                                      fit: BoxFit.fill,
                                      height: 200,
                                      width: double.infinity,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  /*Text(textAlign: TextAlign.center,
                                        item.date.toString(),style:const TextStyle(fontWeight:FontWeight.w500,
                                          fontSize:14,fontFamily:'FontPoppins',color:Colors.black87),),*/
                                  Text(item.header.toString(),
                                    style: const TextStyle(
                                        fontSize:14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        storeMonth = item.month.toString();
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  MagazineBlogDetailPage(month:storeMonth,year:selectedItem)),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                      ),
                                      child: const Text(
                                        'Read More',
                                        style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            ),
          ],
        ),
      ),
    );
  }
}
