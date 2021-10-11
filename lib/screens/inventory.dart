import 'package:flutter/material.dart';
import 'package:pack/controllers/services/package_handler.dart';

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

class InventoryPage extends StatefulWidget {
  InventoryPage({Key? key}) : super(key: key);

  final String title = "Inventory";

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final Data _data = Data();

  Widget build(BuildContext context) {
    _data.update();
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(5.5),
        itemCount: _data.getLength(),
        itemBuilder: _itemBuilder,
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
    Image img = _data.getImage(index);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.arrow_drop_down_circle),
            title: Text(_data.getId(index).toString()),
            subtitle: Text(
              'User : ' + _data.getName(index).toString(),
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "ITEMS : " + _data.getItemList(index).toString(),
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  // Perform some action
                },
                child: const Text('ACTION 1'),
              ),
              TextButton(
                onPressed: () {
                  // Perform some action
                },
                child: const Text('ACTION 2'),
              ),
            ],
          ),
          img,
        ],
      ),
    );
  }
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
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

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
