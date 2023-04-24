class Graph {
  double Id;
  double Month;
  double AmmountOfNewReferrals;
  double AmmountOfApprovedReferrals;

  Graph(this.Id, this.Month, this.AmmountOfNewReferrals,
      this.AmmountOfApprovedReferrals);

  factory Graph.fromJson(Map<String, dynamic> json) {
    return Graph(
      json['id'] as double,
      json['month'] as double,
      json['ammountOfNewReferrals'] as double,
      json['ammountOfApprovedReferrals'] as double,

    );
  }
}
