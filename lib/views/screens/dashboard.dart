import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:pack/models/package.dart';
import 'package:hive/hive.dart';
import 'package:pack/views/routes/routes.gr.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:pack/views/styles/colors.dart';
import 'package:pack/views/widgets/bottom_navigator.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: _buildShrineTheme(),
//       home: InventoryPage(),
//     );
//   }
// }

Box<Package>? packageBox = Hive.box<Package>('packageBox');

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  final String title = "Inventory";

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final Data _data = Data();

  int _itemCount() {
    int items = 0;
    for (int i = 0; i < packageBox!.length; i++) {
      if (packageBox!.values.toList()[i].itemList == "") {
        items += 0;
      } else {
        items +=
            (",").allMatches(packageBox!.values.toList()[i].itemList).length;
        items +=
            (" ").allMatches(packageBox!.values.toList()[i].itemList).length;
        items += 1;
      }
    }
    return items;
  }

  final ScrollController _firstController = ScrollController();
  @override
  Widget build(BuildContext context) {
    _data.update();
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset(
            'assets/img-txt.jpeg',
            width: 200,
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: constraints.maxHeight / 12,
                width: constraints.maxWidth / 3,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        packageBox!.length.toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      const Text(
                        '# inventories',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: constraints.maxHeight / 12,
                width: constraints.maxWidth / 3,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        _itemCount().toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      const Text(
                        '# items',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(children: [
            const Text(
              "Inventories",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: constraints.maxHeight / 2.5,
                  width: constraints.maxWidth / 1.1,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _firstController,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      controller: _firstController,
                      itemCount: _data.getLength(),
                      itemBuilder: _itemBuilder,
                    ),
                  ),
                )
              ],
            ),
          ])
        ]),
        bottomNavigationBar: BottomNavigator(
          selectedIndex: 0,
        ),
      );
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
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: () {
          context.router
              .push(PackageDetailScreen(packageList: _foundPackages[index]));
        },
        leading: Text('Package Id: ' +
            _foundPackages[index].packageId.toString() +
            '\n' +
            'Item List: ' +
            _foundPackages[index].itemList),
      ),
    );
  }
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: ShrineColor.shrineBrown900);
}

// ThemeData _buildShrineTheme() {
//   final ThemeData base = ThemeData.light();
//   return base.copyWith(
//     colorScheme: _shrineColorScheme,
//     accentColor: shrineBrown900,
//     primaryColor: shrinePink100,
//     buttonColor: shrinePink100,
//     scaffoldBackgroundColor: shrineBackgroundWhite,
//     cardColor: shrineBackgroundWhite,
//     textSelectionColor: shrinePink100,
//     errorColor: shrineErrorRed,
//     buttonTheme: const ButtonThemeData(
//       colorScheme: _shrineColorScheme,
//       textTheme: ButtonTextTheme.normal,
//     ),
//     primaryIconTheme: _customIconTheme(base.iconTheme),
//     textTheme: _buildShrineTextTheme(base.textTheme),
//     primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
//     accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
//     iconTheme: _customIconTheme(base.iconTheme),
//   );
// }

// TextTheme _buildShrineTextTheme(TextTheme base) {
//   return base
//       .copyWith(
//         headline: base.headline.copyWith(
//           fontWeight: FontWeight.w500,
//           letterSpacing: defaultLetterSpacing,
//         ),
//         title: base.title.copyWith(
//           fontSize: 18,
//           letterSpacing: defaultLetterSpacing,
//         ),
//         caption: base.caption.copyWith(
//           fontWeight: FontWeight.w400,
//           fontSize: 14,
//           letterSpacing: defaultLetterSpacing,
//         ),
//         body2: base.body2.copyWith(
//           fontWeight: FontWeight.w500,
//           fontSize: 16,
//           letterSpacing: defaultLetterSpacing,
//         ),
//         body1: base.body1.copyWith(
//           letterSpacing: defaultLetterSpacing,
//         ),
//         subhead: base.subhead.copyWith(
//           letterSpacing: defaultLetterSpacing,
//         ),
//         display1: base.display1.copyWith(
//           letterSpacing: defaultLetterSpacing,
//         ),
//         button: base.button.copyWith(
//           fontWeight: FontWeight.w500,
//           fontSize: 14,
//           letterSpacing: defaultLetterSpacing,
//         ),
//       )
//       .apply(
//         fontFamily: 'Rubik',
//         displayColor: shrineBrown900,
//         bodyColor: shrineBrown900,
//       );
// }

// const ColorScheme _shrineColorScheme = ColorScheme(
//   primary: shrinePink100,
//   primaryVariant: shrineBrown900,
//   secondary: shrinePink50,
//   secondaryVariant: shrineBrown900,
//   surface: shrineSurfaceWhite,
//   background: shrineBackgroundWhite,
//   error: shrineErrorRed,
//   onPrimary: shrineBrown900,
//   onSecondary: shrineBrown900,
//   onSurface: shrineBrown900,
//   onBackground: shrineBrown900,
//   onError: shrineSurfaceWhite,
//   brightness: Brightness.light,
// );
const defaultLetterSpacing = 0.03;
