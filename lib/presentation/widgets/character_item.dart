import 'package:breakingbad/constants/my_colors.dart';
import 'package:breakingbad/constants/strings.dart';
import 'package:breakingbad/data/models/charactersModel.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: MyColors.myWhite,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, characterDetailesScreen,
              arguments: character);
        },
        child: GridTile(
          footer: Hero(
            tag: character.id!,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                '${character.name}',
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            width: 150,
            height: 200,
            color: MyColors.myGrey,
            child: character.image!.isNotEmpty
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/animationLoadingIndicator.gif',
                    image: character.image!,
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/4.jpg'),
          ),
        ),
      ),
    );
  }
}
