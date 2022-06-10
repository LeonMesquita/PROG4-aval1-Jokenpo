class Player {
  int matchesWon;
  String selectedPlay;
  int selectedStones;

  Player(
      {this.matchesWon = 0, this.selectedPlay = "", this.selectedStones = 0});

  void setPlay(play) {
    selectedPlay = play;
  }

  String getPlay() {
    return selectedPlay;
  }

  void incrementPoints() {
    matchesWon++;
    selectedStones = 0;
  }

  void incrementStones() {
    selectedStones++;
  }

  bool playedTwoStones() {
    if (selectedStones >= 2) {
      selectedStones = 0;
      return true;
    } else {
      return false;
    }
  }

  String getPoints() {
    return matchesWon.toString();
  }
}
