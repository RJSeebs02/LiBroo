import 'package:flutter/material.dart';

class MyStorePage extends StatefulWidget {
  const MyStorePage({Key? key}) : super(key: key);

  @override
  _MyStorePageState createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> with TickerProviderStateMixin {
  final double coverHeight = 200;
  final double profileHeight = 144;
  late TabController _tabController; // Add TabController

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xFF393742),
      title: Text(
        'My Store',
        style: TextStyle(color: Colors.white),
      ),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          buildTop(),
          buildName(),
          buildTabBar(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6, // Adjust the height as needed
            child: TabBarView(
              controller: _tabController,
              children: [
                buildItemsContent(),
                buildPendingContent(),
                buildHistoryContent(),
                buildAboutContent(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}





  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        )
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Books.png',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(
            'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg'),
      );

  Widget buildName() => Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'Lij Store',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'by: Elijah Faeldonea',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(height: 16),
        ],
      );

  Widget buildTabBar() {
    return Container(
      child: TabBar(
        controller: _tabController,
        tabs: [
          Tab(icon: Icon(Icons.book), text: 'Items'),
          Tab(icon: Icon(Icons.hourglass_bottom), text: 'Pending'),
          Tab(icon: Icon(Icons.history), text: 'History'),
          Tab(icon: Icon(Icons.store), text: 'About'),
        ],
      ),
    );
  }

  Widget buildItemsContent() {
    // Implement content for 'Items' tab
    return Center(child: Text('Items Content'));
  }

  Widget buildPendingContent() {
    // Implement content for 'Pending' tab
    return Center(child: Text('Pending Content'));
  }

  Widget buildHistoryContent() {
    // Implement content for 'History' tab
    return Center(child: Text('History Content'));
  }

  Widget buildAboutContent() => Expanded(
  child: SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20), // Add padding
      child: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton(text: 'Sales', value: 21),
                const SizedBox(width: 20),
                buildButton(text: 'Following', value: 2),
                const SizedBox(width: 20),
                buildButton(text: 'Followers', value: 121),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Overview',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'Lij Store, owned by Elijah Faeldonea sells and rents educational books for highschool students with affordable prices.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          
          const SizedBox(height: 30),
          Text(
            'Contact Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'Contact No.: +639385294825',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'Email Address: boieloi@example.com',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          
          const SizedBox(height: 30),
          Text(
            'Location',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'Lot 32, Block 17, City Heights Subdivision, Ruby St. corner Sapphire St., Brgy. Taculing, Bacolod City, Negros Occidental',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  ),
);




Widget buildButton(
          {required String text, int? value, VoidCallback? onPressed}) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {}, // Corrected onPressed callback
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 2),
            if (value != null)
              Text(
                '$value',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the TabController
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: MyStorePage(),
  ));
}
