import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../splashScreen.dart';
import '../../mainPageP.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String groupValue = 'card';

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget build(BuildContext context) {
     h = MediaQuery.of(context).size.height;
     w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_sharp),
          color: Colors.black87,
          iconSize: h * 0.03,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainPageP()));
          },
        ),
        title: Text(
          'Attendance',
          style: TextStyle(
            fontSize: h * 0.03,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: new Icon(Icons.edit),
            color: Colors.black87,
            iconSize: h * 0.03,
          ),
        ],
      ),
      body: Column(
          // children: [
          //
          //   // Padding(
          //   //   padding: const EdgeInsets.all(10.0),
          //   //   child: Row(
          //   //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   //     crossAxisAlignment: CrossAxisAlignment.center,
          //   //     children: [
          //   //
          //   //       Container(
          //   //         width: w*0.3,
          //   //         height: h*0.16,
          //   //         decoration: BoxDecoration(
          //   //           borderRadius: BorderRadius.circular(10),
          //   //           color: Colors.grey,
          //   //           image: DecorationImage(
          //   //             fit: BoxFit.fill,
          //   //             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyZ97ruNg0zjxXWPTVLGI_UiLQocg6MoST3A&usqp=CAU"),
          //   //           ),
          //   //         ),
          //   //       ),
          //   //
          //   //       Column(
          //   //         crossAxisAlignment: CrossAxisAlignment.start,
          //   //         children: [
          //   //           Text("Jhonny Depp",
          //   //           style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          //   //           ),
          //   //           SizedBox(height: 10,),
          //   //           Text("Owensboro, Kentucky \nUnited States",
          //   //             style: TextStyle(fontFamily: "Montserrat",fontSize: 15),
          //   //           ),
          //   //         ],
          //   //       ),
          //   //
          //   //     ],
          //   //   ),
          //   // ),
          //
          //   SizedBox(
          //     height: h*0.05,
          //     child: TabBar(
          //         isScrollable: true,
          //         unselectedLabelColor: Colors.blueGrey,
          //         labelColor: Colors.black,
          //         controller: _tabController,
          //         indicatorColor: Colors.amber,
          //         indicatorWeight: 2,
          //         tabs: [
          //           Tab(text: "Account"),
          //           Tab(text: "Payment Method"),
          //           Tab(text: "History"),
          //         ]
          //     ),
          //   ),
          //
          //   Expanded(
          //     child: TabBarView(
          //         controller: _tabController,
          //         children:[
          //
          //           Text("Account Page"),
          //
          //
          //           Container(
          //
          //             child: SingleChildScrollView(
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children:  [
          //
          //                   Padding(
          //                     padding: EdgeInsets.only(left : 15,top: 10),
          //                     child: Text("My Cards",
          //                       style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
          //                     ),
          //                   ),
          //
          //                   Row(
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       Container(
          //                         height: h*0.25,
          //                         width: w*0.82 ,
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(10),
          //                           image: DecorationImage(
          //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTll-PNG0JYOEgui1OIHNXt5J9ErcgS1C1Plw&usqp=CAU"),
          //                             fit: BoxFit.fill,
          //                           ),
          //                         ),
          //                       ),
          //
          //                       CircleAvatar(
          //                         radius: 25.0,
          //                         backgroundColor: Colors.amber,
          //                         child: Icon(Icons.add,size: 30,color: Colors.black,),
          //                       ),
          //
          //                     ],
          //                   ),
          //
          //                   Padding(
          //                     padding:  EdgeInsets.only(left : 15),
          //                     child: Text("Add new card",
          //                       style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
          //                     ),
          //                   ),
          //
          //                   Padding(
          //                     padding:  EdgeInsets.only(left: 15,right: 15),
          //                     child: Column(
          //                       children: [
          //
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                           children: [
          //
          //                             Row(
          //                               children: [
          //                                 Container(
          //                                   height: h*0.09,
          //                                   width: w*0.15,
          //                                   child: Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0pEw7N6OngOHy5tdAtUhbr_YXJRCr5ornIg&usqp=CAU")),
          //                                 ),
          //                                 Text("Google Pay",style: TextStyle(fontWeight: FontWeight.w600),),
          //                               ],
          //                             ),
          //
          //                             Radio(value: "Google Pay", groupValue: groupValue, onChanged: (value){
          //                               setState( () {
          //                                 groupValue = value.toString();
          //                               });
          //                             }),
          //                           ],
          //                         ),
          //
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                           children: [
          //
          //                             Row(
          //                               children: [
          //                                 Container(
          //                                   height: h*0.08,
          //                                   width: w*0.15,
          //                                   child: Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsjHTHD5T1mFOZsCqkNMfujHaX6BYxFxGkXQ&usqp=CAU")),
          //                                 ),
          //                                 Text("Credit Card",style: TextStyle(fontWeight: FontWeight.w600),),
          //                               ],
          //                             ),
          //
          //                             Radio(value: "Credit Card", groupValue: groupValue, onChanged: (value){
          //                               setState( () {
          //                                 groupValue = value.toString();
          //                               });
          //                             }),
          //                           ],
          //                         ),
          //
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                           children: [
          //
          //                             Row(
          //                               children: [
          //                                 Container(
          //                                   height: h*0.08,
          //                                   width: w*0.15,
          //                                   child: Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3SGUreVD7pVxevpSTYkUDPhZsoFycafhxEA&usqp=CAU")),
          //                                 ),
          //                                 Text("Apple Pay",style: TextStyle(fontWeight: FontWeight.w600),),
          //                               ],
          //                             ),
          //
          //                             Radio(value: "Apple Pay", groupValue: groupValue, onChanged: (value){
          //                               setState( () {
          //                                 groupValue = value.toString();
          //                               });
          //                             }),
          //                           ],
          //                         ),
          //
          //                         SizedBox(height: h*0.02),
          //                         Center(
          //                           child: Container(
          //                             alignment: Alignment.center,
          //                             width: w*0.9,
          //                             height: h*0.06,
          //                             decoration: BoxDecoration(
          //                               color: Colors.amber,
          //                               borderRadius: BorderRadius.circular(20),
          //                             ),
          //                             child: Text("Add New",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          //                           ),
          //                         ),
          //
          //                       ],
          //                     ),
          //                   ),
          //
          //                 ],
          //               ),
          //             ),
          //
          //           ),
          //
          //           Text("History Page"),
          //
          //         ]
          //     ),
          //   ),
          //
          // ],
          ),
    );
  }
}
