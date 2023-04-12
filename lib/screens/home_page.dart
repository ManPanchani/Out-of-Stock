import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viva_app/helpers/db_helpers.dart';
import '../globals.dart';
import '../models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int a = Random().nextInt(Global.products.length);

  outOfStock() async {
    Future.delayed(const Duration(seconds: 30), () async {
      a;

      await DBHelper.dbHelper.updateRecord(
        quantity: 0,
        id: a,
        text: 'Out Of Stock',
      );
    });
  }

  int second = 30;

  Duration? time() {
    Future.delayed(const Duration(seconds: 1), () {
      if (second > 0) {
        second--;

        print("==============");
        print("time: $second");
        print("==============");

        return time();
      } else {
        return null;
      }
    });
    return null;
  }

  int t = 30;

  getOut() async {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (t > 0) {
          getOut();
          setState(() {
            t--;
          });
        }
        return null;
      },
    );
  }

  Future? getData;

  @override
  void initState() {
    getData = DBHelper.dbHelper.fetchAllRecode();
    outOfStock();
    getOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Shopping App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('CartPage');
            },
            icon: const Icon(
              CupertinoIcons.shopping_cart,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: getData,
            builder: (BuildContext context, AsyncSnapshot snapShot) {
              if (snapShot.hasError) {
                return Center(
                  child: Text(
                    "Error : ${snapShot.error}",
                  ),
                );
              } else if (snapShot.hasData) {
                List<ProductDB> data = snapShot.data;

                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: h * 0.35,
                            width: w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Align(
                                      child: Image.asset(data[i].image!),
                                    ),
                                    (data[i].id == a)
                                        ? StatefulBuilder(
                                            builder: (context, setState) {
                                              return Text(
                                                t.toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                ),
                                              );
                                            },
                                          )
                                        : const Text(
                                            "Out of Stock",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "${data[i].name}",
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${data[i].quantity}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Add To Cart",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
