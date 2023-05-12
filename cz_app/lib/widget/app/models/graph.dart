class Graph {
  double id;
  double month;
  double ammountOfNewReferrals;
  double ammountOfApprovedReferrals;

  Graph(this.id, this.month, this.ammountOfNewReferrals,
      this.ammountOfApprovedReferrals);

  factory Graph.fromJson(Map<String, dynamic> json) {
    return Graph(
      json['id'] as double,
      json['month'] as double,
      json['ammountOfNewReferrals'] as double,
      json['ammountOfApprovedReferrals'] as double,
    );
  }
}
