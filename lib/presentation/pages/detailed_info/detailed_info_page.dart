import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailedInfoPage extends StatelessWidget {
  final String pokemonUrl;

  const DetailedInfoPage({Key? key, required this.pokemonUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(pokemonUrl),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                child: Image.network(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
                ),
                radius: 40.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.grey[800],
            ),
            Text(
              'Name',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Max',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 1.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Curren lvl',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'textlevel',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 1.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
