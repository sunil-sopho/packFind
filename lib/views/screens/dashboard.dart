import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:pack/config/constants.dart';
import 'package:pack/models/package.dart';
import 'package:hive/hive.dart';
import 'package:pack/views/routes/routes.gr.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:pack/views/styles/colors.dart';
import 'package:pack/views/widgets/bottom_navigator.dart';

import 'package:get_it/get_it.dart';
import 'package:pack/views/widgets/common.dart';

Box<Package>? packageBox = Hive.box<Package>('packageBox');

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  // final Data _data = Data();
  final dataBloc = GetIt.instance<DataBloc>();
  final int selectedIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    dataBloc.eventSink.add(DataEvent(DataAction.init));
    super.initState();
  }

  final ScrollController _firstController = ScrollController();
  @override
  Widget build(BuildContext context) {
    print("dashboard build");
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SafeArea(
          child: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // NavBar(eventSink: dataBloc.eventSink),
          const Padding(
              padding: EdgeInsets.only(top: 10),
              child: LogoWidget(width: 210, height: 120)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DisplayBox(
                  constraints: constraints,
                  informationStream: dataBloc.sizeStream,
                  icon: Icons.archive,
                  textdata: 'Boxes'),
              DisplayBox(
                  constraints: constraints,
                  icon: Icons.my_library_books,
                  informationStream: dataBloc.itemStream,
                  textdata: 'Items')
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(children: [
            const Text(
              "Inventories",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 350,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              child: StreamBuilder<List>(
                  stream: dataBloc.dataStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.data == null) {
                      return const Text("Loading");
                    } else if (snapshot.hasError) {
                      print("error");
                      return const Text("Error");
                    } else {
                      return SizedBox(
                        height: constraints.maxHeight / 2.5,
                        width: constraints.maxWidth / 1.1,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: _firstController,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            controller: _firstController,
                            itemCount: snapshot.data!.length,
                            itemBuilder: _itemBuilder,
                          ),
                        ),
                      );
                    }
                  }),
              // ],
            ),
          ])
        ]),
        bottomNavigationBar: BottomNavigator(
          selectedIndex: selectedIndex,
        ),
      ));
    });
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
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: () {
          context.router
              .push(PackageDetailScreen(packageList: _foundPackages[index]));
        },
        title: _foundPackages[index].name == ""
            ? Text('Box Id: ' + _foundPackages[index].packageId.toString())
            : Text('Box Name: ' + _foundPackages[index].name.toString()),
        subtitle: Text('Item List: ' + _foundPackages[index].itemList),
        trailing: Container(
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
  const DisplayBox(
      {Key? key,
      required this.constraints,
      required this.informationStream,
      required this.icon,
      this.textdata = ''})
      : super(key: key);

  final BoxConstraints constraints;
  final Stream informationStream;
  final textdata;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: constraints.maxHeight / 11,
        width: constraints.maxWidth / 3,
        child: Card(
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
        ));
  }
}
