import 'package:breakingbad/business_logic/cubit/characters_cubit.dart';
import 'package:breakingbad/constants/my_colors.dart';
import 'package:breakingbad/data/models/charactersModel.dart';
import 'package:breakingbad/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;

  late List<Character> filteredCharacters;
  bool isSearch = false;
  final TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ال يو اي طلب من الكيوبيت انه يديله الداتا
    BlocProvider.of<CharactersCubit>(context).getAllUsersFromReop();
  }

  // Widgets related to Search
  Widget buildSarchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find Your Actor...',
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
        border: InputBorder.none,
      ),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCaracter) {
        addSearchedForItemsToSearchedList(searchedCaracter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCaracter) {
    filteredCharacters = allCharacters
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchedCaracter))
        .toList();

    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearch) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearching,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  // كاني بقوله لما تبدا تسرش اعمل حاجة زي اب بار جديد ف بالتالي يظهر معاك السهم اللي بيرجع
  void startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));

    setState(() {
      isSearch = true;
    });
  }

  void stopSearch() {
    clearSearch();
    setState(() {
      isSearch = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  // Widgets related to ui
  Widget buildBlockWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          if (searchTextController.text.isNotEmpty &&
              filteredCharacters.isEmpty) {
            return noActorsFounded();
          } else {
            return buildLoadedListWidget();
          }
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget buildLoadedListWidget() {
    return Container(
      color: MyColors.myGrey,
      child: Column(
        children: [
          buildCharactersList(),
        ],
      ),
    );
  }

  Widget buildCharactersList() {
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3, //   width/height
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: searchTextController.text.isEmpty
              ? allCharacters.length
              : filteredCharacters.length,
          itemBuilder: (context, index) {
            return CharacterItem(
              character: searchTextController.text.isEmpty
                  ? allCharacters[index]
                  : filteredCharacters[index],
            );
          }),
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYelllow,
      ),
    );
  }

  Widget ordinaryAppBar() {
    return const Text(
      "Main Actors",
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget noActorsFounded() {
    return Center(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 200,
                width: 200,
                child:
                    Image.asset('assets/images/Animation - 1713880818520.gif')),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Sorry your actor not found😢',
              style: TextStyle(color: MyColors.myWhite, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/no_internt.png'),
            const Text(
              'Can\'t connect , check Internet......',
              style: TextStyle(fontSize: 22, color: MyColors.myGrey),
            ),
            Container()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        backgroundColor: MyColors.myYelllow,
        title: isSearch ? buildSarchField() : ordinaryAppBar(),
        actions: buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlockWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
