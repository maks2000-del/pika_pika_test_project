import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pika_pika_test_project/core_ui/widgets/no_data_screen.dart';
import 'package:pika_pika_test_project/presentation/app/app_themes.dart';
import 'package:pika_pika_test_project/presentation/pages/main/bloc/home_bloc.dart';

import '../../../core_ui/widgets/loading_screen.dart';
import '../../app/app_themes.dart';

import 'bloc/detailed_info_bloc.dart';

class DetailedInfoPage extends StatelessWidget {
  final DetailedInfoBloc detailedInfoBloc;

  const DetailedInfoPage({
    Key? key,
    required this.detailedInfoBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => detailedInfoBloc,
      child: BlocBuilder<DetailedInfoBloc, DetailedInfoState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: darkTheme.primaryBackgroundColor,
            appBar: AppBar(
              title: Text(
                'General info ${state.connection == ConnectivityResult.none ? '(offline)' : ''}',
              ),
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
            body: state.status == FetchStatus.initial
                ? const LoadingPage()
                : state.status == FetchStatus.failure
                    ? const NoDataScreen(textToPrint: 'no data on the device')
                    : _body(context, state),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, DetailedInfoState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PokemonAvatar(
            imgNetworkLink: state.pokemonInfo.frontImage,
            isOnline: state.connection != ConnectivityResult.none,
          ),
          Divider(
            height: 60.0,
            color: Colors.grey[800],
          ),
          const FiledName(name: 'Name:'),
          FieldProperty(
            property: state.pokemonInfo.name,
          ),
          const FiledName(name: 'Height:'),
          FieldProperty(
            property: state.pokemonInfo.height.toString(),
          ),
          const FiledName(name: 'Weight:'),
          FieldProperty(
            property: state.pokemonInfo.weight.toString(),
          ),
          const FiledName(name: 'Types:'),
          ListOfFields(
            boundWidth: MediaQuery.of(context).size.width - 60.0,
            types: state.pokemonInfo.types,
          ),
        ],
      ),
    );
  }
}

class PokemonAvatar extends StatelessWidget {
  final String imgNetworkLink;
  final bool isOnline;

  const PokemonAvatar({
    Key? key,
    required this.imgNetworkLink,
    required this.isOnline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: darkTheme.actionColor,
        child: isOnline && imgNetworkLink.isNotEmpty
            ? Image.network(
                imgNetworkLink,
              )
            : null,
        radius: 40.0,
      ),
    );
  }
}

class FiledName extends StatelessWidget {
  final String name;

  const FiledName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Text(
        name,
        style: TextStyle(
          color: darkTheme.textColor,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

class FieldProperty extends StatelessWidget {
  final String? property;

  const FieldProperty({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      property ?? 'unknown',
      style: TextStyle(
        color: darkTheme.actionColor,
        letterSpacing: 1.0,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ListOfFields extends StatelessWidget {
  final double boundWidth;
  final List<String> types;
  const ListOfFields({
    Key? key,
    required this.boundWidth,
    required this.types,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
