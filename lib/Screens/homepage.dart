// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_string_interpolations, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nebulae/Constants/Color_constants.dart';
import 'package:nebulae/Data/Data_modal/photo_modal.dart';

import '../Bloc/search/bloc/search_api_integration_bloc.dart';
import '../Bloc/trending/trending_api_integration_bloc.dart';
import '../Constants/Data_constants.dart';
import '../Widgets/Drawer.dart';
import 'wallpaperScreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController searchController = TextEditingController();
  int mPageNo = 1;
  // late ScrollController mController;
  int totalResult = 0;

  @override
  void initState() {
    // mController = ScrollController()
    //   ..addListener(() {
    //     if (mController.position.pixels ==
    //         mController.position.maxScrollExtent) {
    //       mPageNo++;
    //       print('End of Result');

    //     }
    //   });
    context
        .read<SearchApiBloc>()
        .add(GetSearchWallpaper(query: 'nature', pageNo: mPageNo));
    context.read<TrendingWalpaperBloc>().add(GetTrendingWallpaper());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<PhotoModal> arrPhotos = [];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'NEB',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 13,
            ),
            children: const [
              TextSpan(
                  text: 'U',
                  style: TextStyle(
                    // fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 22,
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 13,
                  )),
              TextSpan(
                  text: 'LAE',
                  style: TextStyle(
                    // fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 13,
                  )),
            ],
          ),
        ),
        backgroundColor: ColorConstants.mainColor(),
        elevation: 0,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      backgroundColor: ColorConstants.backgroundColor(),
      drawer: MyDrawer(),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color(0xff000000),
              Color(0xff330867),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * .02),
              //----------------Search Bar-----------------------//
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(31, 67, 67, 67),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          controller: searchController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            hintText: 'search',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                      )),
                  // SizedBox(width: size.width * 0.2),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.read<SearchApiBloc>().add(
                              GetSearchWallpaper(
                                query: searchController.text
                                    .toString()
                                    .replaceAll(" ", "%20"),
                                pageNo: mPageNo,
                              ),
                            );
                        searchController.clear();
                      },
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * .01),
              //--------------Popular Category----------------------//
              Text(
                'Popular Now  ',
                style: TextStyle(
                  // fontFamily: GoogleFonts.poppins().fontFamily,
                  color: const Color.fromARGB(255, 172, 170, 170),
                  fontSize: size.width * 0.035,
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
                width: size.width,
                child:
                    BlocBuilder<TrendingWalpaperBloc, TrendingWallpaperState>(
                  builder: (context, state) {
                    if (state is TrendingWallpaperLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TrendingWallpaperInternetErrorState) {
                      return Center(
                        child: Text(
                          state.errorMsg,
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      );
                    } else if (state is TrendingWallpaperErrorState) {
                      return Center(
                        child: Text(
                          state.errorMsg,
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      );
                    } else if (state is TrendingWallpaperLoadedState) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.dataPhotoModal.photos!.length,
                        itemBuilder: (context, index) {
                          var data = state.dataPhotoModal.photos![index];
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SizedBox(
                              // width: size.width * 1 / 3,
                              child: Image.network(
                                '${data.src!.portrait}',
                                fit: BoxFit.fill,
                                width: size.width * 0.4,
                                // height: size.height*0.,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * .01),
              Divider(thickness: 2, color: Colors.grey.shade900),
              SizedBox(height: size.height * .01),
              //-----------------Category List----------------//
              SizedBox(
                height: size.height * 0.05,
                width: size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: DataConstants.searchLst.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              context.read<SearchApiBloc>().add(
                                    GetSearchWallpaper(
                                      query: DataConstants.searchLst[index],
                                    ),
                                  );
                            },
                            child: Text(
                              '${DataConstants.searchLst[index]}',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 172, 170, 170)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * 0.008),
              //--------------------Wallpapers---------------------//
              BlocBuilder<SearchApiBloc, SearchApiState>(
                builder: (context, state) {
                  if (state is SearchWallpaperLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchWallpaperLoadedState) {
                    return MasonryGridView.builder(
                      // controller: mController,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: state.dataPhotoModal.photos!.length,
                      itemBuilder: (context, index) {
                        var data = state.dataPhotoModal.photos![index];
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WallpaperScreenPage(
                                    imgAdd: '${data.src!.portrait}'),
                              ),
                            ),
                            child: Hero(
                              tag: '${data.src!.portrait}',
                              child: Image.network('${data.src!.portrait}'),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<dataPhotoModal.Modal?> getApidataPhotoModal.(String query) async {
  //   Uri mUrl = Uri.parse('https://api.pexels.com/v1/search?query=$query');
  //   var res = await http.get(mUrl, headers: {'Authorization': API_KEY});

  //   if (res.statusCode == 200) {
  //     var json = jsonDecode(res.body);
  //     dataPhotoModal.Modal dataPhotoModal. = dataPhotoModal.Modal.fromJson(json);
  //     return dataPhotoModal.;
  //   } else {
  //     return dataPhotoModal.Modal();
  //   }
  // }
}

// Future Builder:----🔻
// FutureBuilder(
//                 future: dataPhotoModal.,
//                 builder: (context, state) {
//                   if (state.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state.hasError) {
//                     return Text('Error: ${state.error}');
//                   } else if (state.dataPhotoModal. != null &&
//                       state.dataPhotoModal.!.photos != null &&
//                       state.dataPhotoModal.!.photos!.isNotEmpty) {
//                     return MasonryGridView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       gridDelegate:
//                           SliverSimpleGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                       ),
//                       itemCount: state.dataPhotoModal.?.photos!.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: InkWell(
//                             onTap: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => WallpaperScreenPage(
//                                     imgAdd:
//                                         '${state.dataPhotoModal.?.photos![index].src!.portrait}'),
//                               ),
//                             ),
//                             child: Hero(
//                               tag:
//                                   '${state.dataPhotoModal.?.photos![index].src!.portrait}',
//                               child: Image.network(
//                                   '${state.dataPhotoModal.?.photos![index].src!.portrait}'),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   } else {
//                     return Center(
//                       child: Text(
//                         'No dataPhotoModal. available',
//                         style: TextStyle(
//                             color: Colors.white, fontSize: size.height * 0.05),
//                       ),
//                     );
//                   }
//                 },
//               ),
