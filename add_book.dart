import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF393742),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Add Book',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1st row: Image insertion
              GestureDetector(
                onTap: () async {
                  await _pickImage(ImageSource.gallery);
                },
                child: Container(
                  width: 250.0, // Set width of the container
                  height: 250.0, // Set height of the container
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: _imageFile == null
                      ? Icon(Icons.image, size: 100.0, color: Colors.grey)
                      : Center(
                        child: Image.file(
                          _imageFile!,
                          width: 250.0, // Set width to 200 pixels
                          height: 250.0, // Set height to 200 pixels
                          fit: BoxFit.cover, // Adjust the image to cover the specified size
                        ),
                      ),
                ),
              ),
              SizedBox(height: 16.0),
        
              // 2nd row: Book name input
              TextFormField(
                decoration: InputDecoration(labelText: 'Book Name'),
              ),
              SizedBox(height: 16.0),
        
              // 3rd row: Genre dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Genre'),
                items: [
                  DropdownMenuItem(
                    value: 'Academic',
                    child: Text('Academic'),
                  ),
                  DropdownMenuItem(
                    value: 'Fantasy',
                    child: Text('Fantasy'),
                  ),
                  DropdownMenuItem(
                    value: 'Horror',
                    child: Text('Horror'),
                  ),
                  DropdownMenuItem(
                    value: 'Manga',
                    child: Text('Manga'),
                  ),
                  DropdownMenuItem(
                    value: 'Mystery',
                    child: Text('Mystery'),
                  ),
                  DropdownMenuItem(
                    value: 'Romance',
                    child: Text('Romance'),
                  ),
                  DropdownMenuItem(
                    value: 'Thriller',
                    child: Text('Thriller'),
                  ),
                  DropdownMenuItem(
                    value: 'Science Fiction',
                    child: Text('Science Fiction'),
                  ),
                ],
                onChanged: (value) {
                  // Handle dropdown value change
                },
              ),
              SizedBox(height: 16.0),
        
              // 4th row: Selling price input
              TextFormField(
                decoration: InputDecoration(labelText: 'Selling Price'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
        
              // 5th row: Rental price input
              TextFormField(
                decoration: InputDecoration(labelText: 'Rental Price'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
        
              // Add a button to submit the form or any additional actions
              ElevatedButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return the AlertDialog
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Are you sure you want to add this book?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                // Redirect to previous page
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(child: Text('Book Added')),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Color.fromARGB(255, 57, 55, 66),
                                  ),
                                );
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
    // Implement form submission or any desired action
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF393742), // Change the button color here
  ),
  child: Text('Submit', style: TextStyle(color: Colors.white),),
),

            ],
          ),
        ),
      ),
    );
  }
}
