import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reboeng/ui/Screens/Profile/payment_history/dispatching.dart';
import 'package:reboeng/ui/Screens/Profile/payment_history/payment_history.dart';
import 'package:reboeng/ui/Screens/Profile/payment_history/received.dart';
import 'package:reboeng/ui/Screens/Profile/payment_history/sending.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/ui/constants.dart';

class MainPaymentHistory extends StatefulWidget {
  final int tabIndex;

  MainPaymentHistory(this.tabIndex);

  @override
  _MainPaymentHistoryState createState() => _MainPaymentHistoryState(tabIndex);
}

class _MainPaymentHistoryState extends State<MainPaymentHistory> with TickerProviderStateMixin{

  final int tabIndex;

  _MainPaymentHistoryState(this.tabIndex);

  int myIndex;
  String title;
  Color tabColor;
  TabController tabController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setStatus(tabIndex);
    tabController = new TabController(vsync: this, length: _page.length);
    tabController.animateTo(tabIndex);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
//  PageController _controller;

  List<Widget> _page = [
    PaymentHistory(),
    DispatchingProductHistory(),
    SendingProductHistory(),
    ReceivedProductHistory()
  ];



  void setStatus(int index) {
    setState(() {
      setIndex(index);
    });
//    _initialPageChange(index);
    setState(() {
      switch (index) {
        case 0:
          tabColor = Colors.teal;
          title = 'History Pembayaran';
          break;
        case 1:
          tabColor = Colors.black26;
          title = 'Sedang Dikemas';
          break;
        case 2:
          tabColor = Colors.blueAccent;
          title = 'Sedang Dikirim';
          break;
        case 3:
          tabColor = Colors.amber;
          title = 'Sudah Diterima';
          break;
      }
    });
  }

  void setIndex(int index) {
    setState(() {
      myIndex = index;
    });
  }

//  void _setTabIndex(index) {
//    _tabController.index = index;
//  }

//  void _initialPageChange(int index) {
//    setState(() {
//      _controller = PageController(initialPage: index);
//      _tabController.addListener(() {
//        _setTabIndex(index);
//      });
//    });
//    _controller.dispose();
//  }


//  @override
//  void dispose() {
//    _controller.dispose();
//    super.dispose();
//  }



  @override
  Widget build(BuildContext context) {
    setIndex(tabIndex);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: tabColor,
              leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white,), onPressed: () => Navigator.of(context).pop(),),
//            automaticallyImplyLeading: false,
//            title: Padding(
//              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 3),
//              child: Container(
//                width: SizeConfig.widthMultiplier * 100,
//                height: SizeConfig.heightMultiplier * 10,
//                child: _nestedAppBar(title),
//              ),
//            ),
//            title: Padding(
//              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2, bottom: SizeConfig.heightMultiplier * 1),
//              child: _nestedAppBar(title),
//            ),
              title: Text(title, style: TextStyle(color: Colors.white),),
              bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: kPrimaryLightColor,
                  indicatorWeight: SizeConfig.textMultiplier * 0.5,
                  controller: tabController,
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        setStatus(index);
                        break;
                      case 1:
                        setStatus(index);
                        break;
                      case 2:
                        setStatus(index);
                        break;
                      case 3:
                        setStatus(index);
                        break;
                    }
                  },
                  tabs: <Widget>[
                    Tab(
                      child: Container(
                          child: Text(
                            'Pembelian',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Tab(
                      child: Container(
                          child: Text(
                            'Sedang Dikemas',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Tab(
                      child: Container(
                          child: Text(
                            'Sedang Dikirim',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Tab(
                      child: Container(
                          child: Text(
                            'Sudah Diterima',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ]),
            ),
            body: TabBarView(
                controller: tabController,
                children: _page,
                physics: NeverScrollableScrollPhysics(),
            ),
//          body: PageView(
//            scrollDirection: Axis.horizontal,
//            children: <Widget>[
//              PaymentHistory(),
//              DispatchingProductHistory(),
//              SendingProductHistory(),
//              ReceivedProductHistory()
//            ],
//            controller: _controller,
//            onPageChanged: (index) => setStatus(index),
//          )
          )),
    );
  }

//  Widget _nestedAppBar(String _title) {
//    return Container(
//      decoration: BoxDecoration(
//          color: Colors.white,
//          borderRadius: BorderRadius.all(Radius.circular(11))),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Container(
//            child: IconButton(
//              onPressed: () => Navigator.of(context).pop(),
//              icon: Icon(FontAwesomeIcons.arrowLeft),
//            ),
//          ),
//          Container(
//            child: Text(
//              '${_title}',
//              style: TextStyle(color: Colors.grey),
//            ),
//          ),
//          Container(
//            child: IconButton(
//                icon: Icon(
//                  FontAwesomeIcons.search,
//                  color: kPrimaryColor,
//                ),
//                onPressed: null),
//          ),
//        ],
//      ),
//    );
//  }
}
