import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pack/config/constants.dart';
import 'package:pack/controllers/providers/settings.dart';
import 'package:pack/controllers/services/generate_pdf.dart';
import 'package:pack/controllers/services/item_handler.dart';
import 'package:pack/main.dart';
import 'package:pack/models/package.dart';
import 'package:hive/hive.dart';
import 'package:pack/views/routes/routes.gr.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:pack/views/styles/colors.dart';
import 'package:pack/views/widgets/bottom_navigator.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:pack/views/widgets/common.dart';
import 'package:provider/provider.dart';

Box<Package>? packageBox = Hive.box<Package>('packageBox');

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

enum CurrentTab { packagePage, itemPage }

class _InventoryPageState extends State<InventoryPage> {
  // final Data _data = Data();
  final dataBloc = GetIt.instance<DataBloc>();
  final itemDataBloc = GetIt.instance<ItemDataBloc>();
  final imageBloc = GetIt.instance<ImageBloc>();
  final int selectedIndex = 0;

  var _currentTab;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _currentTab = CurrentTab.packagePage;
    dataBloc.eventSink.add(DataEvent(DataAction.init));
    imageBloc.eventSink.add(ImageEvent(ImageAction.clearImages));
    itemDataBloc.eventSink.add(ItemDataEvent(ItemDataAction.init));
    super.initState();
  }

  final ScrollController _firstController = ScrollController();
  Widget _appBar() {
    return Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RotatedBox(
                quarterTurns: 4,
                child: IconAppBar(
                  icon: Icons.sort,
                  color: Colors.black54,
                  isOutLine: true,
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        constraints: BoxConstraints(minHeight: 150),
                        builder: (context) {
                          return Wrap(
                            spacing: 200,
                            clipBehavior: Clip.antiAlias,
                            children: [
                              ListTile(
                                  leading: Icon(Icons.share),
                                  title: Text('Export Inventory'),
                                  onTap: () async {
                                    final pdfFile =
                                        await PdfApiPackages.generateNew(1, 20);
                                    await PdfApiPackages.openFile(pdfFile);
                                  }),
                              ListTile(
                                  leading: Icon(Icons.copy),
                                  title: Text('Share Link'),
                                  onTap: () {
                                    Clipboard.setData(const ClipboardData(
                                            text:
                                                "https://play.google.com/store/apps/details?id=com.pack.pack"))
                                        .then((_) {
                                      Fluttertoast.showToast(
                                        msg: 'Link to app copid',
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.black,
                                        timeInSecForIosWeb: 3,
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
                                      Navigator.of(context).pop();
                                    });
                                  }),
                            ],
                          );
                        });
                  },
                )),
            InkWell(
                onTap: () {
                  context.router.pushNamed('/settings-screen');
                }, // Handle your callback
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color(0xfff8f8f8),
                              blurRadius: 10,
                              spreadRadius: 10),
                        ],
                      ),
                      child: CircleAvatar(
                          minRadius: 50,
                          backgroundImage:
                              NetworkImage(settingsProvider.userProfilePic),
                          backgroundColor: kPrimaryDarkColor)),
                ))
          ],
        ),
      );
    });
  }

  Widget _icon(IconData icon, {Color color = AppColor.lightGrey}) {
    return InkWell(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              color: Theme.of(context).backgroundColor,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
              ]),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        onTap: () {},
        borderRadius: const BorderRadius.all(Radius.circular(13)));
  }

  void _opTapPackagePage() {
    if (_currentTab != CurrentTab.packagePage) {
      setState(() {
        _currentTab = CurrentTab.packagePage;
      });
    }
  }

  void _opTapItemPage() {
    if (_currentTab != CurrentTab.itemPage) {
      setState(() {
        _currentTab = CurrentTab.itemPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("dashboard build");
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SafeArea(
            child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // SingleChildScrollView(
            // child:
            Container(
                height: MediaQuery.of(context).size.height - 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _appBar(),
                          // NavBar(eventSink: dataBloc.eventSink),
                          // const Padding(
                          //     padding: EdgeInsets.only(top: 10),
                          //     child: LogoWidget(width: 210, height: 120)),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DisplayBox(
                                constraints: constraints,
                                informationStream: dataBloc.sizeStream,
                                icon: Icons.archive,
                                textdata: 'Packages',
                                isSelected:
                                    _currentTab == CurrentTab.packagePage
                                        ? true
                                        : false,
                                onTapHandler: _opTapPackagePage,
                              ),
                              DisplayBox(
                                constraints: constraints,
                                icon: Icons.my_library_books,
                                informationStream: dataBloc.itemStream,
                                textdata: 'Items',
                                isSelected: _currentTab == CurrentTab.itemPage
                                    ? true
                                    : false,
                                onTapHandler: _opTapItemPage,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Column(children: [
                          const Center(
                              child: Text(
                            "Inventory",
                            style: TextStyle(fontSize: 20),
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                          // SizedBox(
                          //   height: 450,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          Expanded(
                            child: StreamBuilder<List>(
                                stream: dataBloc.dataStream,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.data == null) {
                                    return const Text("Loading");
                                  } else if (snapshot.hasError) {
                                    print("error");
                                    return const Text("Error");
                                  } else {
                                    return ListView.builder(
                                      padding: const EdgeInsets.all(0),
                                      controller: _firstController,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: _itemBuilder,
                                    );
                                  }
                                }),
                          )
                          // ],
                        ])))
          ],
        ));
      }),
      bottomNavigationBar: BottomNavigator(
        selectedIndex: selectedIndex,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    // return InkWell(
    //   child: Card(
    //     child: Center(
    //       child: Text(
    //         "${_data.getName(index)}",
    //         style: TextStyle(
    //           fontWeight: FontWeight.w500,
    //           color: Colors.orange,
    //         ),
    //       ),
    //     ),
    //   ),
    //   onTap: () => MaterialPageRoute(
    //       builder: (context) =>
    //           SecondRoute(id: _data.getId(index), name: _data.getName(index))),
    // );
    // Image img = _data.getImage(index);
    // This list holds the data for the list view
    List<Package> _foundPackages = [];
    packageBox!.length > 0
        ? _foundPackages = packageBox!.values.toList()
        : null;
    @override
    initState() {
      // at the beginning, all users are shown
      _foundPackages = [];
      super.initState();
    }

    return Card(
      // clipBehavior: Clip.antiAlias,
      // child: Column(
      //   children: [
      //     ListTile(
      //       leading: const Icon(Icons.arrow_drop_down_circle),
      //       title: Text(_data.getId(index).toString()),
      //       subtitle: Text(
      //         'User : ' + _data.getName(index).toString(),
      //         style: TextStyle(color: Colors.black.withOpacity(0.6)),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Text(
      //         "ITEMS : " + _data.getItemList(index).toString(),
      //         style: TextStyle(color: Colors.black.withOpacity(0.6)),
      //       ),
      //     ),
      //     ButtonBar(
      //       alignment: MainAxisAlignment.start,
      //       children: [
      //         TextButton(
      //           onPressed: () {
      //             // Perform some action
      //           },
      //           child: const Text('ACTION 1'),
      //         ),
      //         TextButton(
      //           onPressed: () {
      //             // Perform some action
      //           },
      //           child: const Text('ACTION 2'),
      //         ),
      //       ],
      //     ),
      //     img,
      //   ],
      // ),

      key: ValueKey(_foundPackages[index].packageId),
      color: Colors.amberAccent,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        onTap: () {
          analytics.logEvent(
            name: "package_detail_opened",
          );
          context.router
              .push(PackageDetailScreen(packageList: _foundPackages[index]));
        },
        title: _foundPackages[index].name == ""
            ? Text('Package Id: ' + _foundPackages[index].packageId.toString())
            : Text('Package Name: ' + _foundPackages[index].name.toString()),
        subtitle: Text('Item List: ' + _foundPackages[index].itemList),
        trailing: SizedBox(
            width: 70,
            height: 70,
            child: QrCodeTrailing(
                textdata: _foundPackages[index].packageId.toString(),
                size: 90)),
      ),
    );
  }
}

// IconThemeData _customIconTheme(IconThemeData original) {
//   return original.copyWith(color: ShrineColor.shrineBrown900);
// }

class NavBar extends StatelessWidget {
  const NavBar({Key? key, this.eventSink = ""}) : super(key: key);

  final eventSink;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              if (eventSink == "") return;
              eventSink.add(DataAction.init);
            },
            heroTag: 'Btn',
            tooltip: "reload",
            child: const Icon(Icons.image),
          )
        ]);
  }
}

const defaultLetterSpacing = 0.03;

class DisplayBox extends StatelessWidget {
  final onTapHandler;

  final isSelected;

  const DisplayBox(
      {Key? key,
      required this.constraints,
      required this.informationStream,
      required this.icon,
      required this.isSelected,
      required this.onTapHandler,
      this.textdata = ''})
      : super(key: key);

  final BoxConstraints constraints;
  final Stream informationStream;
  final textdata;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: constraints.maxHeight / 10,
        width: constraints.maxWidth / 3,
        child: InkWell(
          onTap: onTapHandler,
          child: Card(
            color: isSelected ? Colors.blue : null,
            elevation: 10,
            shadowColor: kPrimaryColor,
            margin: EdgeInsets.all(2),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: kPrimaryDarkColor)),
            child: Column(
              children: <Widget>[
                StreamBuilder(
                    stream: informationStream,
                    initialData: 0,
                    builder: (context, snapshot) {
                      return ListTile(
                        leading: Icon(icon),
                        trailing: Column(children: [
                          Spacer(),
                          Text(
                            '${snapshot.data}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 25),
                          ),
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(textdata,
                                    style: const TextStyle(
                                        backgroundColor: Colors.white,
                                        color: Colors.black,
                                        fontSize: 12))
                              ]),
                        ]),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
