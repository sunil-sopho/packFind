import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pack/config/constants.dart';
import 'package:pack/main.dart';
import 'package:pack/models/package.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:pack/views/routes/routes.gr.dart';
import 'package:pack/views/styles/colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pack/views/widgets/common.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:google_fonts/google_fonts.dart';

class PackageDetailScreen extends StatefulWidget {
  final Package? packageList;
  const PackageDetailScreen({Key? key, Package? this.packageList})
      : super(key: key);

  get backgroundDecoration => BoxDecoration();

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen>
    with TickerProviderStateMixin {
  final dataBloc = GetIt.instance<DataBloc>();
  late AnimationController controller;
  late Animation<double> animation;
  // Data? _data;

  @override
  void initState() {
    // _data = dataBloc.data;
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Image> galleryItems = [];
  Image defaultImage = Image.asset('assets/logo-0.png', height: 200);

  void updateGallery() {
    galleryItems.clear();
    if (widget.packageList != null) {
      galleryItems.addAll(
          // _data!.getImages(int.parse(widget.packageList?.packageId) - 1));
          (widget.packageList != null)
              ? getImagesfromStringList(widget.packageList!.image)
              : getImagesfromStringList([]));
    }
    setState(() {
      if (galleryItems.isNotEmpty) {
        defaultImage = galleryItems[0];
      }
    });
  }

  void handleClick(String value, dynamic package) {
    switch (value) {
      case PackageNavbarSettings.edit:
        analytics.logEvent(
          name: "edit_package",
        );
        Navigator.pop(context);
        context.router.push(QRGeneratorSharePage(package: package));
        break;
      case PackageNavbarSettings.delete:
        analytics.logEvent(
          name: "delete_package",
        );
        dataBloc.eventSink.add(DataEvent(DataAction.deletePackage, package));
        Navigator.pop(context);
        break;
    }
  }

  Widget _appBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          .copyWith(bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconAppBar(
            icon: Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          // _icon(isLiked ? Icons.favorite : Icons.favorite_border,
          //     color: isLiked ? LightColor.red : LightColor.lightGrey,
          //     size: 15,
          //     padding: 12,
          //     isOutLine: false, onPressed: () {
          //   setState(() {
          //     isLiked = !isLiked;
          //   });
          // }),
          PopupMenuButton<String>(
            elevation: 10.0,
            padding: const EdgeInsets.all(0.0),
            icon: Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.black, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(13)),
                color: Colors.transparent,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 5,
                      spreadRadius: 10,
                      offset: Offset(5, 5)),
                ],
              ),
              child: Icon(Icons.settings, color: Colors.black54, size: 15),
            ),
            offset: const Offset(-10.0, kToolbarHeight),
            onSelected: (value) => handleClick(value, widget.packageList),
            itemBuilder: (BuildContext context) {
              return PackageNavbarSettings.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }

  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          const Positioned(
              bottom: 40,
              child: TitleText(
                text: "PackFND",
                fontSize: 60,
                color: AppColor.lightGrey,
              )),
          // Image.asset('assets/logo-0.png', height: 200)
          // SizedBox(height: 200, child: defaultImage)
          Container(
            height: MediaQuery.of(context).size.height * 0.38,
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.38,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: galleryItems[index].image,
                    initialScale: PhotoViewComputedScale.contained * 0.7,
                    heroAttributes: PhotoViewHeroAttributes(tag: index),
                  );
                },
                itemCount: galleryItems.length,
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!.toInt(),
                    ),
                  ),
                ),
                backgroundDecoration: widget.backgroundDecoration,
                // pageController: widget.pageController,
                // onPageChanged: onPageChanged,
              )),
          Positioned(bottom: 0.0, child: _categoryWidget()),
        ],
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 0),
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: Center(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: galleryItems.map((x) => _thumbnail(x)).toList()),
        )));
  }

  Widget _thumbnail(Image image) {
    return AnimatedBuilder(
      animation: animation,
      //  builder: null,
      builder: (context, child) => AnimatedOpacity(
        opacity: animation.value,
        duration: Duration(milliseconds: 500),
        child: child,
      ),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
              child: Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  // color: Theme.of(context).backgroundColor,
                ),
                child: image,
              ),
              onTap: () {
                setState(() {
                  defaultImage = image;
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(13)))),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .55,
      minChildSize: .55,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              .copyWith(bottom: 0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: AppColor.icon,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(
                                text: widget.packageList?.name == ''
                                    ? "Package " + widget.packageList?.packageId
                                    : widget.packageList?.name,
                                fontSize: 25),
                            const SizedBox(height: 10),
                            widget.packageList?.name != ''
                                ? Text(
                                    "Package " + widget.packageList!.packageId)
                                : Container(),
                          ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              QrCodeWidget(
                                  textdata: widget.packageList?.packageId),
                            ],
                          ),
                          // Row(
                          //   children: <Widget>[
                          //     Icon(Icons.star,
                          //         color: LightColor.yellowColor, size: 17),
                          //     Icon(Icons.star,
                          //         color: LightColor.yellowColor, size: 17),
                          //     Icon(Icons.star,
                          //         color: LightColor.yellowColor, size: 17),
                          //     Icon(Icons.star,
                          //         color: LightColor.yellowColor, size: 17),
                          //     Icon(Icons.star_border, size: 17),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _descriptionItemList(),
                const SizedBox(
                  height: 20,
                ),
                _descriptionLocation(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _descriptionItemList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const TitleText(
          text: "Item List",
          fontSize: 14,
        ),
        const SizedBox(height: 20),
        Text(widget.packageList!.itemList),
      ],
    );
  }

  Widget _descriptionLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const TitleText(
          text: "Location",
          fontSize: 14,
        ),
        const SizedBox(height: 20),
        Text(widget.packageList!.location),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    updateGallery();
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xfffbfbfb),
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget({Key? key, this.textdata}) : super(key: key);
  final textdata;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Hero(
          tag: 'package_qrcode2',
          child: RepaintBoundary(
            key: key,
            child: Container(
              color: Colors.white,
              child: QrImage(
                size: 70, //size of the QrImage widget.
                data: textdata, //textdata used to create QR code
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen(qrdata: textdata);
          }));
        });
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, this.qrdata = ""}) : super(key: key);
  final String qrdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'package_qrcode2',
            child: QrImage(
              size: 300, //size of the QrImage widget.
              data: qrdata, //textdata used to create QR code
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const TitleText(
      {Key? key,
      required this.text,
      this.fontSize = 18,
      this.color = AppColor.titleTextColor,
      this.fontWeight = FontWeight.w800})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.mulish(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}
