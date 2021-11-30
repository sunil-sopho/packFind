import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:pack/models/package.dart';
import 'package:hive/hive.dart';
import 'package:pack/views/routes/routes.gr.dart';
import 'package:pack/views/widgets/bottom_navigator.dart';

void main() {
  runApp(const PackageFinder());
}

class PackageFinder extends StatelessWidget {
  const PackageFinder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well

  // This list holds the data for the list view
  List<Package> _foundUsers = [];
  Box<Package>? packageBox = Hive.box<Package>('packageBox');
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = [];
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Package> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = [];
    } else {
      packageBox!.length > 0
          ? results = packageBox!.values
              .where((item) => item.itemList
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList()
          : results = [];
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Package...'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        onChanged: (value) => _runFilter(value),
                        decoration: const InputDecoration(
                            labelText: 'Search', suffixIcon: Icon(Icons.search)),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.router.push(const ScanQRPage());
                      },
                      icon: const Icon(
                        Icons.qr_code_scanner_rounded,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index].packageId),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          onTap: () {
                            context.router.push(PackageDetailScreen(
                                packageList: _foundUsers[index]));
                          },
                          leading: Text('Package Id: ' +
                              _foundUsers[index].packageId.toString() +
                              '\n' +
                              'Item List: ' +
                              _foundUsers[index].itemList),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 18),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigator(
        selectedIndex: 2,
      ),
    );
  }
}
