import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'bloc/detailed_info_bloc.dart';

class DetailedInfoPage extends StatelessWidget {
  final String pokemonUrl;

  const DetailedInfoPage({Key? key, required this.pokemonUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailedInfoBloc, DetailedInfoState>(
      builder: (context, state) {
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
                      state.pokemonInfo.frontImage ?? 'here',
                      //TODO no image image
                    ),
                    radius: 40.0,
                  ),
                ),
                Divider(
                  height: 60.0,
                  color: Colors.grey[800],
                ),
                const Text(
                  'Name: ',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  state.pokemonInfo.name ?? '',
                  style: TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing: 1.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Text(
                  'Curren lvl',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(
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
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Text('weihgt'),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text('height')
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
