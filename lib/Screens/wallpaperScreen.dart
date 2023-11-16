// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper/wallpaper.dart';

import '../Bloc/search/bloc/search_api_integration_bloc.dart';

class WallpaperScreenPage extends StatefulWidget {
  String imgAdd;
  WallpaperScreenPage({
    Key? key,
    required this.imgAdd,
  }) : super(key: key);

  @override
  State<WallpaperScreenPage> createState() => _WallpaperScreenPageState();
}

class _WallpaperScreenPageState extends State<WallpaperScreenPage> {
  bool isFav = false;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff000000),
              Color(0xff330867),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: InkWell(
          onTap: () {
            isVisible = !isVisible;
            setState(() {});
          },
          child: Stack(
            children: [
              Hero(
                tag: '$widget.imgAdd',
                child: SizedBox(
                  height: double.infinity,
                  child: Image.network(
                    widget.imgAdd,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Positioned(
                  top: size.height * 0.06,
                  left: size.width * 0.05,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 100),
                    opacity: isVisible ? 1 : 0,
                    child: Container(
                      padding: EdgeInsets.only(right: size.width * 0.1),
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                          InkWell(
                            child: Icon(Icons.share),
                          ),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                bottom: size.height * 0.254,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: isVisible ? 1 : 0,
                  child: Container(
                    height: size.height * 0.1,
                    width: size.width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(91, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(6)),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isFav = !isFav;
                                  });
                                },
                                child: isFav
                                    ? Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: size.width * 0.08,
                                      )
                                    : Icon(
                                        Icons.star_border,
                                        color: Colors.white,
                                        size: size.width * 0.08,
                                      ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.03),
                            Container(
                              height: size.height * 0.05,
                              width: size.width * 0.12,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(91, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(12)),
                              child: InkWell(
                                onTap: () {
                                  downloadWallpaper();
                                },
                                child: Icon(
                                  Icons.download_rounded,
                                  color: Color.fromARGB(201, 255, 255, 255),
                                  size: size.height * 0.04,
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.03),
                            Container(
                              height: size.height * 0.035,
                              width: size.width * 0.1,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(91, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(6)),
                              child: InkWell(
                                onTap: () {
                                  setWallpaper();
                                },
                                child: Icon(
                                  Icons.image,
                                  color: Color.fromARGB(201, 255, 255, 255),
                                  size: size.width * 0.05,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // --------------------similar wallpaper-----------------//
              Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 100),
                    opacity: isVisible ? 1 : 0,
                    child: Container(
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(155, 0, 0, 0),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: size.height * 0.01,
                                width: size.width * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          Container(
                            padding: EdgeInsets.zero,
                            height: size.height * 0.27,
                            child: BlocBuilder<SearchApiBloc, SearchApiState>(
                              builder: (context, state) {
                                if (state is SearchWallpaperLoadingState) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is SearchWallpaperLoadedState) {
                                  return MasonryGridView.builder(
                                    gridDelegate:
                                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    itemCount:
                                        state.dataPhotoModal.photos!.length,
                                    itemBuilder: (context, index) {
                                      var data =
                                          state.dataPhotoModal.photos![index];
                                      return Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: InkWell(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WallpaperScreenPage(
                                                      imgAdd:
                                                          '${data.src!.portrait}'),
                                            ),
                                          ),
                                          child: Hero(
                                            tag: '${data.src!.portrait}',
                                            child: Image.network(
                                                '${data.src!.portrait}'),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                return Center(
                                  child: Text(
                                    'No Data',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setWallpaper() {
    var downloadStream = Wallpaper.imageDownloadProgress(widget.imgAdd);

    downloadStream.listen(
      (event) {
        Wallpaper.homeScreen(options: RequestSizeOptions.RESIZE_FIT);
        print(event.toString());
      },
      onDone: () async {
        print("Wallpaper Download in catch...!!");
      },
    );
  }

  void downloadWallpaper() {
    GallerySaver.saveImage(widget.imgAdd).then(
      (value) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Your Wallpaper Set Successfully!!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok'))
                ],
              );
            });
      },
    );
  }

  // void setWallpaper(BuildContext context) async {
  //   var width = MediaQuery.of(context).size.width;
  //   var height = MediaQuery.of(context).size.height;
  //
  //   await Wallpaper.homeScreen(
  //     options: RequestSizeOptions.RESIZE_FIT,
  //     width: width,
  //     height: height,
  //   );
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Your Wallpaper Set Successfully!!'),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('Ok'))
  //           ],
  //         );
  //       });
  // }
}
