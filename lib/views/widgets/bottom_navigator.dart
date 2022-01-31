import 'package:flutter/material.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:get_it/get_it.dart';
import 'package:pack/config/constants.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:pack/views/screens/home.dart';
import 'package:pack/views/screens/dashboard.dart';
import 'package:pack/views/screens/landing.dart';
import 'package:pack/views/screens/qr_generate/generate_qr.dart';
import 'package:pack/views/screens/qr_generate/upload_image.dart';
import 'package:pack/views/screens/scan/scan_qr.dart';
import 'package:pack/views/screens/scan/scan_result.dart';
import 'package:pack/views/screens/package_detail_screen/package_detail_screen.dart';
import 'package:pack/views/screens/search_screen/search.dart';
import 'package:pack/views/styles/baseStyles.dart';
import 'package:pack/views/widgets/bottom_curved_Painter.dart';

class BottomNavigator extends StatefulWidget {
  var selectedIndex;

  // final Function(int) onIconPresedCallback;
  // BottomNavigator({Key? key, required this.onIconPresedCallback})
  //     : super(key: key);

  BottomNavigator({Key? key, required this.selectedIndex}) : super(key: key);
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState(selectedIndex);
}

class _BottomNavigatorState extends State<BottomNavigator>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  // _BottomNavigatorState(int selectedIndex) {
  //   _selectedIndex = selectedIndex;
  // }
  final GlobalKey _navbarkey = GetIt.instance<GlobalKey>();

  late AnimationController _xController;
  late AnimationController _yController;

  _BottomNavigatorState(selectedIndex) {
    _selectedIndex = selectedIndex;
  }

  @override
  void initState() {
    _xController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _xController.value =
        _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;

    super.didChangeDependencies();
  }

  double _indexToPosition(int index) {
    // Calculate button positions based off of their
    // index (works with `MainAxisAlignment.spaceAround`)
    const buttonCount = 4.0;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonsWidth) / 2;
    return startX +
        index.toDouble() * buttonsWidth / buttonCount +
        buttonsWidth / (buttonCount * 2.0);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  Widget _icon(IconData icon, bool isEnable, int index) {
    return Expanded(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        onTap: () {
          _handlePressed(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          alignment: isEnable ? Alignment.topCenter : Alignment.center,
          child: AnimatedContainer(
              height: isEnable ? 40 : 20,
              duration: Duration(milliseconds: 300),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isEnable ? kPrimaryColor : Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: isEnable ? Color(0xfffeece2) : Colors.white,
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(5, 5),
                    ),
                  ],
                  shape: BoxShape.circle),
              child: Opacity(
                opacity: isEnable ? _yController.value : 1,
                child: Icon(icon,
                    color: isEnable
                        ? BaseStyles.background
                        : Colors.grey.shade500),
              )),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    const inCurve = ElasticOutCurve(0.38);
    return CustomPaint(
      painter: BackgroundCurvePainter(
          _xController.value * MediaQuery.of(context).size.width,
          Tween<double>(
            begin: Curves.easeInExpo.transform(_yController.value),
            end: inCurve.transform(_yController.value),
          ).transform(_yController.velocity.sign * 0.5 + 0.5),
          Colors.white),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  void _handlePressed(int index) async {
    if (_selectedIndex == index || _xController.isAnimating) return;
    await _onItemTapped(index);
    if (_selectedIndex != index) return;
    _yController.value = 1.0;
    _xController.animateTo(
        _indexToPosition(index) / MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 620));
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        _yController.animateTo(1.0, duration: Duration(milliseconds: 1200));
      },
    );
    _yController.animateTo(0.0, duration: Duration(milliseconds: 300));
  }

  void changePage(int index) {
    switch (index) {
      case 0:
        context.router.replaceNamed('/inventory-page');
        break;
      case 1:
        context.router.pushNamed('/q-rgenerator-share-page');
        break;
      case 2:
        context.router.replaceNamed('/package-finder');
        break;
      case 3:
        context.router.replaceNamed('/settings-screen');
        break;
    }
  }

  Future<void> _onItemTapped(int index) async {
    if (_selectedIndex == 1 && index != 1) {
      // If the current tab is the first tab (the form tab)
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Unsaved data will be lost.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context), // Closes the dialog
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  setState(() => _selectedIndex = index); // Changes the tab
                  Navigator.pop(context);
                  final imageBloc = GetIt.instance<ImageBloc>();
                  imageBloc.eventSink.add(ImageEvent(ImageAction.clearImages));
                  changePage(index);
                  // Closes the dialog
                },
                child: const Text('Yes'),
              ),
            ],
          );
        },
      );
    } else {
      if (index == 0 && _selectedIndex != 0) {
        setState(() {
          _selectedIndex = 0;
        });
        changePage(index);
      } else if (index == 1 && _selectedIndex != 1) {
        setState(() {
          _selectedIndex = 1;
        });
      } else if (index == 2 && _selectedIndex != 2) {
        setState(() {
          _selectedIndex = 2;
        });
      } else if (index == 3 && _selectedIndex != 3) {
        setState(() {
          _selectedIndex = 3;
        });
      }
      changePage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    final height = 60.0;
    return Container(
      width: appSize.width,
      height: height,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            width: appSize.width,
            height: height - 10,
            child: _buildBackground(),
          ),
          Positioned(
            left: (appSize.width - _getButtonContainerWidth()) / 2,
            top: 0,
            width: _getButtonContainerWidth(),
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _icon(Icons.home, _selectedIndex == 0, 0),
                _icon(Icons.add_circle, _selectedIndex == 1, 1),
                _icon(Icons.search, _selectedIndex == 2, 2),
                _icon(Icons.account_circle, _selectedIndex == 3, 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return (BottomNavigationBar(
  //     key: _navbarkey,
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Colors.white, //Color(0xFF6200EE),
  //     selectedItemColor: Colors.orange, //Color(0xFF6200EE)
  //     unselectedItemColor: Colors.orange.withOpacity(.60),
  //     selectedFontSize: 14,
  //     unselectedFontSize: 14,
  //     currentIndex: _selectedIndex,
  //     onTap: _onItemTapped,
  //     items: const [
  //       BottomNavigationBarItem(
  //         label: '',
  //         icon: Icon(
  //           Icons.home,
  //           size: 35,
  //         ),
  //       ),
  //       BottomNavigationBarItem(
  //         label: "",
  //         icon: Icon(
  //           Icons.add_circle,
  //           size: 35,
  //         ),
  //       ),
  //       BottomNavigationBarItem(
  //         label: '',
  //         icon: Icon(
  //           Icons.search,
  //           size: 35,
  //         ),
  //       ),
  //       BottomNavigationBarItem(
  //         label: '',
  //         icon: Icon(
  //           Icons.account_circle,
  //           size: 35,
  //         ),
  //       ),
  //     ],
  //   ));
  // }
}
