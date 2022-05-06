import 'package:flutter/material.dart';

import 'src/side_bar.dart';

export 'src/menu_item.dart';
export 'src/side_bar.dart';

class AdminScaffold extends StatefulWidget {
  const AdminScaffold({
    Key? key,
    this.appBar,
    this.sideBar,
    required this.body,
    this.backgroundColor,
  }) : super(key: key);

  final AppBar? appBar;
  final SideBar? sideBar;
  final Widget body;
  final Color? backgroundColor;

  @override
  _AdminScaffoldState createState() => _AdminScaffoldState();
}

class _AdminScaffoldState extends State<AdminScaffold>
    with SingleTickerProviderStateMixin {
  static const _mobileThreshold = 768.0;

  late AppBar? _appBar;
  bool _isMobile = false;
  bool _isOpenSidebar = false;
  bool _canDragged = false;
  double _screenWidth = 0;

  @override
  void initState() {
    super.initState();
    _appBar = _buildAppBar(widget.appBar, widget.sideBar);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    if (_screenWidth == mediaQuery.size.width) {
      return;
    }

    setState(() {
      _isMobile = mediaQuery.size.width < _mobileThreshold;
      _isOpenSidebar = !_isMobile;
      print(_isOpenSidebar);
      
      _screenWidth = mediaQuery.size.width;
    });
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  void _toggleSidebar() {
    setState(() {
      _isOpenSidebar = !_isOpenSidebar;
      print(_isOpenSidebar);
      
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: _appBar,
      body: 
        
 widget.sideBar == null
            ? Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: widget.body,
                    ),
                  ),
                ],
              )
            : _isMobile
                ? Stack(
                    children: [
                      
                      widget.body,
                      
                      ClipRect(
                        child: SizedOverflowBox(
                          size: Size(
                              _isOpenSidebar?(widget.sideBar?.width ?? 1.0) *1:(widget.sideBar?.width ?? 1.0)*0,
                              double.infinity),
                          child: widget.sideBar,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      widget.sideBar != null
                          ? ClipRect(
                              child: SizedOverflowBox(
                                size: Size(
                                    _isOpenSidebar?(widget.sideBar?.width ?? 1.0) *1:(widget.sideBar?.width ?? 1.0)*0
                                        ,
                                    double.infinity),
                                child: widget.sideBar,
                              ),
                            )
                          : SizedBox(),
                      Container(
                        width: _isOpenSidebar?_screenWidth-widget.sideBar!.width:_screenWidth,
                        height: MediaQuery.of(context).size.height,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: widget.body,
                        ),
                      ),
                    ],
                  ),
      
    );
  }

  AppBar? _buildAppBar(AppBar? appBar, SideBar? sideBar) {
    if (appBar == null) {
      return null;
    }

    final leading = sideBar != null
        ? IconButton(
            icon: const Icon(Icons.menu),
            onPressed: _toggleSidebar,
          )
        : appBar.leading;
    final shadowColor = Colors.transparent;

    return AppBar(
      leading: leading,
      automaticallyImplyLeading: appBar.automaticallyImplyLeading,
      title: appBar.title,
      actions: appBar.actions,
      flexibleSpace: appBar.flexibleSpace,
      bottom: appBar.bottom,
      elevation: appBar.elevation,
      shadowColor: shadowColor,
      shape: appBar.shape,
      backgroundColor: appBar.backgroundColor,
      foregroundColor: appBar.foregroundColor,
      brightness: appBar.brightness,
      iconTheme: appBar.iconTheme,
      actionsIconTheme: appBar.actionsIconTheme,
      textTheme: appBar.textTheme,
      primary: appBar.primary,
      centerTitle: appBar.centerTitle ?? false,
      excludeHeaderSemantics: appBar.excludeHeaderSemantics,
      titleSpacing: appBar.titleSpacing,
      toolbarOpacity: appBar.toolbarOpacity,
      bottomOpacity: appBar.bottomOpacity,
      toolbarHeight: appBar.toolbarHeight,
      leadingWidth: appBar.leadingWidth,
      backwardsCompatibility: appBar.backwardsCompatibility,
      toolbarTextStyle: appBar.toolbarTextStyle,
      titleTextStyle: appBar.titleTextStyle,
      systemOverlayStyle: appBar.systemOverlayStyle,
    );
  }
}
