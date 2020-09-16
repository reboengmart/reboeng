import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/historyNotifier.dart';
import 'package:reboeng/services/api/dispatching_api.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';

class DispatchingProductHistory extends StatefulWidget {
  @override
  _DispatchingProductHistoryState createState() => _DispatchingProductHistoryState();
}

class _DispatchingProductHistoryState extends State<DispatchingProductHistory> {
  @override
  void initState() {
    // TODO: implement initState
    HistoryNotifier historyNotifier =
    Provider.of<HistoryNotifier>(context, listen: false);
    DispatchingAPI.getDispatching(historyNotifier);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryNotifier>(context);
    print("Tessssss"+ historyProvider.historyList.length.toString());
    return new Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: historyProvider.historyList.length,
                    itemBuilder: (context, index){
                      final item = historyProvider.historyList[index];
                      return FutureBuilder(
                          future: Firestore.instance.collection('transaction').document(item.transaction_ref).collection('invoice').where('id_invoice', isEqualTo: item.invoice_ref).getDocuments(),
                          builder: (BuildContext context,
                              AsyncSnapshot snap) {
                            if(snap.hasData){
                              Timestamp t = snap
                                  .data.documents
                                  .toList()[0]
                                  .data['date_invoice'];
                              DateTime tanggal = t.toDate();
//                            String formattanggal = DateFormat('d MMMM y').format(tanggal);
                              String total_payment = snap
                                  .data.documents
                                  .toList()[0]
                                  .data['total_payment'].toString();
                              double height = MediaQuery.of(context).size.height;
                              double width = MediaQuery.of(context).size.width;
                              return Container(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 2,
                                      right: 5,
                                      left: 5),
                                  height: height * 0.23,
                                  child: Card(
                                      elevation: 1.0,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Center(
                                              child:
                                              Container(
                                                padding:
                                                EdgeInsets
                                                    .all(
                                                    10.0),
                                                width:
                                                (width *
                                                    0.80),
                                                height:
                                                height *
                                                    0.25,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: <
                                                      Widget>[
                                                    Text(
                                                      'Tanggal Transaksi +${tanggal.toString()}',
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        2.9 * SizeConfig.textMultiplier,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                      7.0,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: <
                                                          Widget>[
                                                        Text(
                                                          'Total Pembayaran:',
                                                          style:
                                                          TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 1.8 * SizeConfig.textMultiplier,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                          10.0,
                                                        ),
                                                        Text(
                                                          'Rp. ${total_payment}',
                                                          style:
                                                          TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 1.8 * SizeConfig.textMultiplier,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            }
                            if(!snap.hasData){
                              return Center(child: Text(''));
                            }
//                            if (snap.hasError) {
//                              return Center(
////                                          child: Text(wishListSnapshot.error));
//                                  child: CircularProgressIndicator());
//                            }
//                            if(snap.hasData)
//                            }
//                            if (snap.connectionState !=
//                                ConnectionState.done) {
//                              return Center(
//                                child: CircularProgressIndicator(),
//                              );
//                            }
//                            if (!snap.hasData &&
//                                snap.connectionState ==
//                                    ConnectionState.done) {
//                              return Text('Tidak Ada Barang');
//                            }
//                            if(!snap.hasData){
//                              return Center(
//                                child: CircularProgressIndicator(
//                                  backgroundColor: Colors.green,
//                                ),
//                              );
//                            }
                          });
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}
