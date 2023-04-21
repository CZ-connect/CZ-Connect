class Graph {
  int Id;
  int Month;
  int AmmountOfNewReferrals;
  int AmmountOfApprovedReferrals;

  Graph(this.Id, this.Month, this.AmmountOfNewReferrals,
      this.AmmountOfApprovedReferrals);

  factory Graph.fromJson(Map<String, dynamic> json) {
    return Graph(
      json['id'] as int,
      json['month'] as int,
      json['ammountOfNewReferrals'] as int,
      json['ammountOfApprovedReferrals'] as int,

    );
  }
}
