// ignore_for_file: unused_catch_clause

import 'package:flutter/services.dart';
import 'package:games_services/games_services.dart';

void main() async {
  // #docregion signIn
  try {
    await GamesServices.signIn();
  } on PlatformException catch (e) {
    // ... deal with failures ...
  }
  // #enddocregion signIn

  // #docregion unlock
  await GamesServices.unlock(
    achievement: Achievement(
      androidID: 'your android id',
      iOSID: 'your ios id',
    ),
  );
  // #enddocregion unlock

  // #docregion showAchievements
  await GamesServices.showAchievements();
  // #enddocregion showAchievements

  // #docregion submitScore
  await GamesServices.submitScore(
    score: Score(
      iOSLeaderboardID: 'some_id_from_app_store',
      androidLeaderboardID: 'sOmE_iD_fRoM_gPlAy',
      value: 100,
    ),
  );
  // #enddocregion submitScore

  // #docregion showLeaderboards
  await GamesServices.showLeaderboards(
    iOSLeaderboardID: 'some_id_from_app_store',
    androidLeaderboardID: 'sOmE_iD_fRoM_gPlAy',
  );
  // #enddocregion showLeaderboards
}
