List<List<int>> scoreFormat({
  required bool is1game,
  required int yours1gameNumber,
  required int yours2gameNumber,
  required int yours3gameNumber,
  required int opponents1gameNumber,
  required int opponents2gameNumber,
  required int opponents3gameNumber,
}) {
  var yourScore = <int>[];
  var opponentsScore = <int>[];

  // 点数のバリデーション
  if (is1game) {
    yourScore = [
      yours1gameNumber,
    ];
    opponentsScore = [
      opponents1gameNumber,
    ];
  } else {
    yourScore = [
      yours1gameNumber,
      yours2gameNumber,
      yours3gameNumber,
    ];

    opponentsScore = [
      opponents1gameNumber,
      opponents2gameNumber,
      opponents3gameNumber,
    ];

    if (yours1gameNumber > opponents1gameNumber &&
        yours2gameNumber > opponents2gameNumber) {
      yourScore.removeLast();
      opponentsScore.removeLast();
    }

    if (yours1gameNumber < opponents1gameNumber &&
        yours2gameNumber < opponents2gameNumber) {
      yourScore.removeLast();
      opponentsScore.removeLast();
    }
  }
  return [yourScore, opponentsScore];
}

String partnerFormat({
  required bool isSingles,
  required String partnerId,
}) {
  var partner = '';

  if (isSingles) {
    partner = '';
  } else {
    partner = partnerId;
  }

  return partner;
}

List<String> opponentsFormat({
  required bool isSingles,
  required String firstOpponentId,
  required String secondOpponentId,
}) {
  var opponents = <String>[];

  if (isSingles) {
    opponents = [firstOpponentId];
  } else {
    opponents = [
      firstOpponentId,
      secondOpponentId,
    ];
  }

  return opponents;
}

bool isWinnerValidation({
  required bool is1game,
  required List<int> yourScore,
  required List<int> opponentsScore,
}) {
  if (is1game) {
    if (yourScore[0] > opponentsScore[0]) {
      return true;
    } else {
      return false;
    }
  } else {
    if (yourScore[0] > opponentsScore[0] &&
        (yourScore[1] > opponentsScore[1] ||
            yourScore[2] > opponentsScore[2])) {
      return true;
    } else {
      return false;
    }
  }
}
