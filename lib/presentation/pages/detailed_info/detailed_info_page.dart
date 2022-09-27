import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pika_pika_test_project/presentation/app/app_themes.dart';

import '../../theme/theme_provider.dart';
import '../../app/app_themes.dart';

import 'bloc/detailed_info_bloc.dart';

class DetailedInfoPage extends StatelessWidget {
  final DetailedInfoBloc detailedInfoBloc;

  const DetailedInfoPage({Key? key, required this.detailedInfoBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => detailedInfoBloc,
      child: BlocBuilder<DetailedInfoBloc, DetailedInfoState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: darkTheme.primaryBackgroundColor,
            appBar: AppBar(
              title: const Text('General info'),
              centerTitle: true,
              backgroundColor: darkTheme.secondaryBackgroundColor,
              elevation: 0.0,
              leading: IconButton(
                splashColor: darkTheme.actionPressedColor,
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
                  _pokemonAvatar(state.pokemonInfo.frontImage),
                  Divider(
                    height: 60.0,
                    color: Colors.grey[800],
                  ),
                  _infoFieldName('Name:'),
                  _infoFieldProperty(state.pokemonInfo.name),
                  _infoFieldName('Height:'),
                  _infoFieldProperty(state.pokemonInfo.height.toString()),
                  _infoFieldName('Weight:'),
                  _infoFieldProperty(state.pokemonInfo.weight.toString()),
                  _infoFieldName('Types:'),
                  _typesList(
                    MediaQuery.of(context).size.width - 60.0,
                    state.pokemonInfo.types,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _pokemonAvatar(String imgNetworkLink) {
    return Center(
      child: CircleAvatar(
        backgroundColor: darkTheme.actionColor,
        child: imgNetworkLink.isNotEmpty
            ? Image.network(
                imgNetworkLink,
              )
            : null,
        radius: 40.0,
      ),
    );
  }

  Widget _infoFieldName(String fieldName) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Text(
        fieldName,
        style: TextStyle(
          color: darkTheme.textColor,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _infoFieldProperty(String? filedProperty) {
    return Text(
      filedProperty ?? 'unknown',
      style: TextStyle(
        color: darkTheme.actionColor,
        letterSpacing: 1.0,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _typesList(double boundWidth, List<String> types) {
    return SizedBox(
      height: 50.0,
      width: boundWidth,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(
              '#${types[index]}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 1.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        itemCount: types.length,
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
