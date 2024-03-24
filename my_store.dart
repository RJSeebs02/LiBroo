import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'book_details.dart';
import 'add_book.dart';

class MyStorePage extends StatefulWidget {
  const MyStorePage({Key? key}) : super(key: key);

  @override
  _MyStorePageState createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> with TickerProviderStateMixin {
  final double coverHeight = 200;
  final double profileHeight = 144;
  late TabController _tabController; // Add TabController
  bool showFloatingButton = true; // Add a boolean to track button visibility

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection); // Add listener for tab changes

  }

  void _handleTabSelection() {
    setState(() {
      // Update the button visibility based on the active tab index
      showFloatingButton = _tabController.index == 0;
    });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xFF393742),
      iconTheme: IconThemeData(color: Colors.white),
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
    floatingActionButton: showFloatingButton ? FloatingActionButton( // Conditionally show the button
        onPressed: () {
          // Navigate to the AddProductPage when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF393742),
      ) : null, // If showFloatingButton is false, don't show the button
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Adjust the location if needed
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
      color:Color(0xFF393742),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Color(0xFFFFD3AF),
        unselectedLabelColor: Colors.white,
        labelColor: Color(0xFFFFD3AF),
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
  return ListView(
    shrinkWrap: true,
    children: [
      Container(
        height: 300, // Set the height of the container
        child: BookItem(
          title: 'Solo Leveling Vol. 3',
          number: 1,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga1.jpg',
          genreText: 'Genre: Manga',
          userText: 'Posted by: Elijah Faeldonea',
          locationText: 'Bacolod City',
          price: 'Price: ₱580.00',
          rentPrice: 'Rental Price: ₱80.00/week in 2 months',
        ),
      ),
      const Divider(),
      SizedBox(
        height: 30,
      ),
      Container(
        height: 300, // Set the height of the container
        child: BookItem(
          title: 'Komi Can\'t Communicate Vol. 26',
          number: 2,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga2.jpg',
          genreText: 'Genre: Manga',
          userText: 'Posted by: Elijah Faeldonea',
          locationText: 'Bacolod City',
          price: 'Price: ₱850.00',
          rentPrice: 'Rental Price: ₱120.00/week in 2 months',
        ),
      ),
      const Divider(),
      SizedBox(
        height: 30,
      ),
      Container(
        height: 300, // Set the height of the container
        child: BookItem(
          title: 'My Hero Academia, Vol. 26',
          number: 3,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga3.jpg',
          genreText: 'Genre: Manga',
          userText: 'Posted by: Elijah Faeldonea',
          locationText: 'Bacolod City',
          price: 'Price: ₱300.00',
          rentPrice: 'Rental Price: ₱50.00/week in 2 months',
        ),
      ),
    ],
  );
}

Widget buildPendingContent() {
  return ListView(
    shrinkWrap: true,
    children: [
      Container(
        height: 300, // Set the height of the container
        child: Item(
          title: 'Solo Leveling Vol. 3',
          number: 1,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga1.jpg',
          genreText: 'Transaction ID: 1235134',
          userText: 'Erjun Quilisadio',
          locationText: 'Bacolod City',
          price: 'To Buy',
          rentPrice: 'Rental Price: ₱80.00/week in 2 months',
        ),
      ),
      const Divider(),
      SizedBox(
        height: 30,
      ),
      Container(
        height: 300, // Set the height of the container
        child: Item(
          title: 'Komi Can\'t Communicate Vol. 26',
          number: 2,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga2.jpg',
          genreText: 'Transaction ID: 11234474',
          userText: 'Kirby Calampinay',
          locationText: 'Bacolod City',
          price: 'To Rent',
          rentPrice: 'Rental Price: ₱120.00/week in 2 months',
        ),
      ),
      const Divider(),
      SizedBox(
        height: 30,
      ),
      Container(
        height: 300, // Set the height of the container
        child: Item(
          title: 'My Hero Academia, Vol. 26',
          number: 3,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga3.jpg',
          genreText: 'Transaction ID: 6541323',
          userText: 'Stefan Delgado',
          locationText: 'Victorias City',
          price: 'To Buy',
          rentPrice: 'Rental Price: ₱50.00/week in 2 months',
        ),
      ),
    ],
  );
}




  Widget buildHistoryContent() {
    return ListView(
    shrinkWrap: true,
    children: [
      Container(
        height: 300, // Set the height of the container
        child: Item(
          title: 'Komi Can\'t Communicate Vol. 26',
          number: 1,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga2.jpg',
          genreText: 'Transaction ID: 1244352',
          userText: 'Sold to: Romeo Seva III',
          locationText: 'Jan 10, 2024',
          price: 'Bought',
          rentPrice: 'Rental Price: ₱80.00/week in 2 months',
        ),
      ),
      const Divider(),
      SizedBox(
        height: 30,
      ),
      Container(
        height: 300, // Set the height of the container
        child: Item(
          title: 'My Hero Academia, Vol. 26',
          number: 2,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga3.jpg',
          genreText: 'Transaction ID: 1754724',
          userText: 'Rented by: Russ Garde',
          locationText: 'Jan 4, 2024',
          price: 'Rented (1 week due)',
          rentPrice: 'Rental Price: ₱120.00/week in 2 months',
        ),
      ),
      const Divider(),
      SizedBox(
        height: 30,
      ),
      Container(
        height: 300, // Set the height of the container
        child: Item(
          title: 'Solo Leveling Vol. 3',
          number: 3,
          imagePath: 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Manga1.jpg',
          genreText: 'Transaction ID: 7433456',
          userText: 'Sold to: EJ Arnado',
          locationText: 'Dec 13, 2023',
          price: 'Bought',
          rentPrice: 'Rental Price: ₱50.00/week in 2 months',
        ),
      ),
    ],
  );
  }

  Widget buildAboutContent() => Expanded(
  child: SingleChildScrollView(
    child: Column(
      children: [
        Center(
          child: Container(
            color: Color(0xFF393742), // Set background color of the container
            padding: EdgeInsets.all(10),
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
        ),
        const SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Text(
            'Overview',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Center(
            child: Text(
              'Lij Store, owned by Elijah Faeldonea sells and rents mangas with affordable prices.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 20),
        
        const SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Text(
            'Contact Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Center(
            child: Text(
              'Contact No.: +639385294825',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Center(
            child: Text(
              'Email Address: boieloi@example.com',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 20),
        
        const SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Text(
            'Location',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Center(
            child: Text(
              'Lot 32, Block 17, City Heights Subdivision, Ruby St. corner Sapphire St., Brgy. Taculing, Bacolod City, Negros Occidental',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 60),
      ],
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
              ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.white),
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

class BookItem extends StatelessWidget {
  final String title;
  final int number;
  final String imagePath;
  final String genreText;
  final String userText;
  final String locationText;
  final String price;
  final String rentPrice;

  const BookItem({
    required this.title,
    required this.number,
    required this.imagePath,
    required this.genreText,
    required this.userText,
    required this.locationText,
    required this.price,
    required this.rentPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // Navigate to the book details page and pass the book details
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookDetailsPage(
              title: title,
              genreText: genreText,
              userText: userText,
              locationText: locationText,
              price: price,
              rentPrice: rentPrice,
              imagePath: imagePath, // Pass the image path
            )),
          );
        },
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Image.network( // Change from Image.asset to Image.network
                  imagePath,
                  height: 250,
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Color.fromARGB(255, 57, 55, 66),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          genreText,
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          userText,
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        locationText,
                        style: TextStyle(
                          color: Color.fromARGB(255, 57, 55, 66),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 10.0, right: 16.0),
                          child: Text(
                            price,
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 55, 66),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final int number;
  final String imagePath;
  final String genreText;
  final String userText;
  final String locationText;
  final String price;
  final String rentPrice;

  const Item({
    required this.title,
    required this.number,
    required this.imagePath,
    required this.genreText,
    required this.userText,
    required this.locationText,
    required this.price,
    required this.rentPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network( // Change from Image.asset to Image.network
                imagePath,
                height: 250,
                width: 250,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Color.fromARGB(255, 57, 55, 66),
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        genreText,
                        style: TextStyle(
                          color: Color.fromARGB(255, 57, 55, 66),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        userText,
                        style: TextStyle(
                          color: Color.fromARGB(255, 57, 55, 66),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      locationText,
                      style: TextStyle(
                        color: Color.fromARGB(255, 57, 55, 66),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 10.0, right: 16.0),
                        child: Text(
                          price,
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 55, 66),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: MyStorePage(),
  ));
}
