import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:unisba_sisfo/config/constanta.dart' as cs;

import '../models/slider.dart';

class PostMorePage extends StatefulWidget {
  @override
  _PostMorePageState createState() => _PostMorePageState();
}

class _PostMorePageState extends State<PostMorePage> {
  bool isLoading = true;
  List<SisfoSlider> sliderList = [];
  // ignore: prefer_final_fields
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    getSliders();
    _refreshController.loadComplete();
  }

  void initState() {
    getSliders();
    super.initState();
  }

  Future<void> getSliders() async {
    setState(() {
      isLoading = true;
    });
    Dio dio = Dio();
    var response = await dio.get(cs.postMoreUrl);
    if (response.statusCode == 200) {
      setState(() {
        for (var i in response.data) {
          sliderList.add(SisfoSlider(
            id: i['id'].toString(),
            title: i['title']['rendered'],
            image: i['jetpack_featured_media_url'],
            link: i['link'],
          ));
          print(response.data);
        }
        isLoading = false;
      });
    } else {
      Fluttertoast.showToast(msg: "Unable to load news");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isLoading ? Text('Please Wait...') : Text("Unisba Posts"),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
            itemCount: sliderList.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                  leading: Image.network(
                    sliderList[i].image,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                  title: Text(sliderList[i].title));
            }),
      ),
    );
  }
}
