import 'package:breakingbad/constants/my_colors.dart';
import 'package:breakingbad/data/models/charactersModel.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character actor;
  const CharacterDetailsScreen({super.key, required this.actor});

  Widget builSliverAppBar() {
    return SliverAppBar(
      iconTheme: const IconThemeData(color: MyColors.myYelllow),
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          actor.name!,
          style: const TextStyle(
            color: MyColors.myYelllow,
          ),
        ),
        background: Hero(
          tag: actor.id!,
          child: Image.network(
            actor.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYelllow,
      height: 30,
      thickness: 2,
      endIndent: endIndent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          builSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('Name : ', actor.name!),
                    buildDivider(269),
                    characterInfo(
                        'Date of birth : ', actor.birthYear.toString()),
                    buildDivider(216),
                    if (actor.deathYear != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          characterInfo(
                              'Date of death : ', actor.deathYear.toString()),
                          buildDivider(216),
                        ],
                      ),
                    characterInfo('Nationality : ', actor.nationality!),
                    buildDivider(230),
                    characterInfo('His Movies : ', actor.knownFor!.join(' / ')),
                    buildDivider(230),
                    characterInfo('Awards : ', actor.awards!.join(' / ')),
                    buildDivider(260),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 400,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
