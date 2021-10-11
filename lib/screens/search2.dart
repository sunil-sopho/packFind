import 'package:flutter/material.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:pack/models/package.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  runApp(PackageFinder());
}

class PackageFinder extends StatelessWidget {
  const PackageFinder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Search package with items'),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: ItemFinder(),
                    );
                  }),
            ]),
        body: const Center(
          child: Text(''),
        ),
      ),
    );
  }
}

class ItemFinder extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ""); // for closing the search page and going back
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchFinder(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchFinder(query: query);
  }
}

class SearchFinder extends StatelessWidget {
  final String query;

  const SearchFinder({Key? key, required this.query}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Package>('packageBox').listenable(),
      builder: (context, Box<Package> packageBox, _) {
        ///* this is where we filter data
        var results = query.isEmpty
            ? [] // whole list
            : packageBox.values
                .where((c) =>
                    c.itemList.toLowerCase().contains(query.toLowerCase()))
                .toList();

        return results.isEmpty
            ? Center(
                child: Text('No results found !',
                    style: Theme.of(context).textTheme.headline6),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  // passing as a custom list
                  final Package packageListItem = results[index];

                  return ListTile(
                    onTap: () {
                      ///* This is where we update index so that we could go to that screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PackageDetailScreen(packageList: packageListItem)));
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          packageListItem.itemList,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          packageListItem.location,
                          textScaleFactor: 1.0,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}

class PackageDetailScreen extends StatelessWidget {
  final Package packageList;
  PackageDetailScreen({Key? key, required this.packageList}) : super(key: key);
  final _data = Data();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
      ),
      body:Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text("List of items:  " + packageList.itemList),
            Text("Location is  :  " + packageList.location),
            const SizedBox(
              height: 20,
            ),
            _data.getImage(int.parse(packageList.packageId)-1)
          ],
        ),
      ), 
    );
  }
}