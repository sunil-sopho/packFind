import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pack/config/constants.dart';
import 'package:pack/models/package.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:pack/views/routes/routes.gr.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pack/views/widgets/common.dart';
import 'package:auto_route/src/router/auto_router_x.dart';

class PackageDetailScreen extends StatefulWidget {
  final Package? packageList;
  const PackageDetailScreen({Key? key, Package? this.packageList})
      : super(key: key);

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  final dataBloc = GetIt.instance<DataBloc>();

  // Data? _data;

  @override
  void initState() {
    // _data = dataBloc.data;
    super.initState();
  }

  List<Image> galleryItems = [];

  void updateGallery() {
    galleryItems.clear();
    if (widget.packageList != null) {
      galleryItems.addAll(
          // _data!.getImages(int.parse(widget.packageList?.packageId) - 1));
          (widget.packageList != null)
              ? getImagesfromStringList(widget.packageList!.image)
              : getImagesfromStringList([]));
    }
  }

  void handleClick(String value, dynamic package) {
    switch (value) {
      case PackageNavbarSettings.edit:
        Navigator.pop(context);
        context.router.push(QRGeneratorSharePage(package: package));
        break;
      case PackageNavbarSettings.delete:
        dataBloc.eventSink.add(DataEvent(DataAction.deletePackage, package));
        Navigator.pop(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    updateGallery();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 1,
        title: widget.packageList?.name != null
            ? Text("Package: ${widget.packageList?.name}")
            : const Text("Package Details"),
        actions: <Widget>[
          PopupMenuButton<String>(
            elevation: 10.0,
            padding: const EdgeInsets.all(0.0),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'List of items :  ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              widget.packageList!.itemList,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Text(
              'Location is  :  ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              widget.packageList!.location,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            // Container(
            //   margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            //   constraints: const BoxConstraints(maxHeight: 300, maxWidth: 300),
            //   decoration: const BoxDecoration(color: Colors.grey),
            //   child: _data.getImage(int.parse(packageList.packageId) - 1),
            // )
            SizedBox(
                height: 300,
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: galleryItems[index].image,
                      initialScale: PhotoViewComputedScale.contained * 0.8,
                      heroAttributes:
                          PhotoViewHeroAttributes(tag: galleryItems[index]),
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
                  // backgroundDecoration: widget.backgroundDecoration,
                  // pageController: widget.pageController,
                  // onPageChanged: onPageChanged,
                )),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 40),
                  QrCodeWidget(textdata: widget.packageList?.packageId),
                  QrShareButton(textdata: widget.packageList?.packageId)
                ])
          ],
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
