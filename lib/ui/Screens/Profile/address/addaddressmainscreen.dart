import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/AddressNotifier.dart';
import 'package:reboeng/ui/Screens/Profile/address/addaddress_mapper.dart';
import 'package:reboeng/ui/components/rounded_button.dart';
import 'package:reboeng/ui/constants.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  bool asTabs = false;
  String selectedValue;
  String preselectedValue = "dolor sit";
  ListAlamat listAlamat;
  List<int> selectedItems = [];
  final List<DropdownMenuItem> items = [];

  static const String appTitle = "Search Choices demo";
  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  void initState() {
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
          return (item.value == wordPair);
        }) ==
            -1) {
          items.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }
    });
    super.initState();
  }

  List<Widget> get appBarActions {
    return ([
      Center(child: Text("Tabs:")),
      Switch(
        activeColor: Colors.white,
        value: asTabs,
        onChanged: (value) {
          setState(() {
            asTabs = value;
          });
        },
      )
    ]);
  }


  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressNotifier>(context);

    Map<String, Widget> widgets;
    widgets = {
      "Pilih Jenis Alamat": SearchableDropdown.single(
      items: ListAlamat.list.map((exNum) {
        return (DropdownMenuItem(
            child: Text(exNum.numberString), value: exNum.numberString));
      }).toList(),
      value: listAlamat,
      hint: "Pilih Satu Jenis",
      searchHint: "Cari Jenis Alamat",
      onChanged: (value) {
        addressProvider.changeIcon(value);
        setState(() {
          listAlamat = value;
        });
      },
      dialogBox: true,
      isExpanded: true,
    ),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: asTabs
          ? DefaultTabController(
        length: widgets.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
            actions: appBarActions,
            bottom: TabBar(
              isScrollable: true,
              tabs: Iterable<int>.generate(widgets.length)
                  .toList()
                  .map((i) {
                return (Tab(
                  text: (i + 1).toString(),
                ));
              }).toList(), //widgets.keys.toList().map((k){return(Tab(text: k));}).toList(),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: TabBarView(
              children: widgets
                  .map((k, v) {
                return (MapEntry(
                    k,
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        Text(k),
                        SizedBox(
                          height: 20,
                        ),
                        v,
                      ]),
                    )));
              })
                  .values
                  .toList(),
            ),
          ),
        ),
      )
          :Scaffold(
        appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pop()), title: Text('Tambah Alamat'), backgroundColor: kPrimaryColor,),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextField(decoration: InputDecoration(hintText: 'Nama Alamat',),
              textAlign: TextAlign.center,
              onChanged: (value){
              addressProvider.changeNama(value);
              },
              ),
              Container(
                child: RoundedButton(
                  text: "Pilih Detail Alamat di peta",
                  press: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddAddressMapper())
                    );
                  },
                ),
              ),
              Container(
                child: Column(
                  children: widgets
                      .map((k, v) {
                    return (MapEntry(
                        k,
                        Center(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text("$k:"),
                                      v,
                                    ],
                                  ),
                                )))));
                  })
                      .values
                      .toList(),
                ),
              ),
              TextField(decoration: InputDecoration(hintText: 'pas pas an'),
                textAlign: TextAlign.center,
                onChanged: (value){
                  addressProvider.changeDetail(value);
                },),
            SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Simpan"),
                onPressed: (){
                  addressProvider.saveAddress();
                }
                ),
            ],
          ),
        ),

      ),
    );
  }
}

class ListAlamat{
  int number;

  static final Map<int, String> map = {
    0: "rumah",
    1: "kantor",
    2: "lain-Lain",
  };

  String get numberString {
    return (map.containsKey(number) ? map[number] : "unknown");
  }

  ListAlamat(this.number);

  String toString() {
    return ("$number $numberString");
  }

  static List<ListAlamat> get list {
    return (map.keys.map((num) {
      return (ListAlamat(num));
    })).toList();
  }
}

