# pokedex_app
## Description

The app replicates the Pokedex from the Pokemon game series. In the base version, the user will be able to see a list of all pokemons, and when clicking on any of them, open a list of details.

## Technical aspects of the app:
- Application written in Flutter programming tool, in Dart language.
- BLoC package (version 8.0.0) used to separate logic and UI.
- Using a RESTful API from https://pokeapi.co/ to get and proccess data the to display it in a readable way to the user.
- Rich commentary and consistent application structure to make the code easier to understand.

## File structure:
**/repos** - contains project repositories and models,  
**/screens** - contains folders for each screen,  
**/screens/screenname** - folder with UI and logic for particular screen, contains:
- screenname_event.dart,
- screenname_state.dart,
- screenname_bloc.dart,
- views folder.

## To do:
The basic application is scheduled to be completed by the end of November 24, 2021.
Then I'll be working on the enhanced version with a search engine and filtering by tags.
