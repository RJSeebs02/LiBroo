import 'package:flutter/material.dart';

class PremiumSubscriptionPage extends StatelessWidget {
  const PremiumSubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF393742),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Subscription Offers',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  SubscriptionOfferCard(
                    title: 'Premium User',
                    price: '\₱99.99',
                    description: 'Unlock feature to sell books.',
                    fullDescription: '-Ad-Free Experience\n-Create your own Virtual Store\n-Sell Books',
                    gradientColors: [Color(0xFF64B5F6), Color(0xFF393742)],
                    iconData: Icons.star,
                    isUnsubscribe: true,
                  ),
                  SizedBox(height: 20),
                  SubscriptionOfferCard(
                    title: 'VIP User',
                    price: '\₱99.99/month',
                    description: 'Access to VIP events such as book swapping events, and book clubs.',
                    fullDescription: '-Premium User Features\n-Access to VIP Events\n-Access to Book Clubs',
                    gradientColors: [Color(0xFF81C784), Color(0xFF393742)],
                    iconData: Icons.emoji_events,
                  ),
                  SizedBox(height: 20),
                  SubscriptionOfferCard(
                    title: 'Platinum User',
                    price: '\₱149.99/month',
                    description: 'The ultimate package with unlimited access to all features.',
                    fullDescription: '-VIP User Features\n-Priority Customer Support\n-Exclusive Discounts',
                    gradientColors: [Color(0xFFFFB74D), Color(0xFF393742)],
                    iconData: Icons.card_giftcard,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionOfferCard extends StatefulWidget {
  final String title;
  final String price;
  final String description;
  final String fullDescription;
  final List<Color> gradientColors;
  final IconData iconData;
  final bool isUnsubscribe;

  const SubscriptionOfferCard({
    Key? key,
    required this.title,
    required this.price,
    required this.description,
    required this.fullDescription,
    required this.gradientColors,
    required this.iconData,
    this.isUnsubscribe = false,
  }) : super(key: key);

  @override
  _SubscriptionOfferCardState createState() => _SubscriptionOfferCardState();
}

class _SubscriptionOfferCardState extends State<SubscriptionOfferCard> {
  bool _showFront = true;

  void _showGcashDetailsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Provide GCash Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter your GCash details:"),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add functionality to process GCash details
                Navigator.of(context).pop();
                // Add additional functionality here, like processing GCash details
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showFront = !_showFront;
        });
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: _showFront
            ? _buildFront()
            : _buildBack(),
      ),
    );
  }

  Widget _buildFront() {
    return Container(
      key: UniqueKey(),
      height: 250, // Adjust height as needed
      width: double.infinity, // Take the full width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Icon(
                widget.iconData,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.price,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBack() {
  return Container(
    key: UniqueKey(),
    height: 250, // Adjust height as needed
    width: double.infinity, // Take the full width
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: widget.gradientColors,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 15,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            widget.fullDescription,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (widget.isUnsubscribe) {
                // Show unsubscribe dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Unsubscribe"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Are you sure you want to unsubscribe?"),
                          SizedBox(height: 20),
                          Text("Please provide your GCash details:"),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Phone Number'),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Full Name'),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Process unsubscribe
                            Navigator.of(context).pop();
                          },
                          child: Text('Unsubscribe'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                // Show upgrade dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Upgrade your Account?"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Are you sure you want to upgrade to VIP?"),
                          SizedBox(height: 20),
                          Text("Please provide your GCash details:"),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Phone Number'),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Full Name'),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Process upgrade
                            Navigator.of(context).pop();
                            // Add additional upgrade functionality here
                          },
                          child: Text('Upgrade'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            child: Text(widget.isUnsubscribe ? 'Unsubscribe' : 'Upgrade'),
          ),
        ],
      ),
    ),
  );
}



}
