class Graph {
  String? Id;
  String? Month;
  String? AmmountOfNewReferrals;
  String? AmmountOfApprovedReferrals;

  Graph(this.Id, this.Month, this.AmmountOfNewReferrals,
      this.AmmountOfApprovedReferrals);

  factory Graph.fromJson(Map<String, dynamic> json) {
    return Graph(
      json['Id'] as String?,
      json['Month'] as String?,
      json['AmmountOfNewReferrals'] as String?,
      json['AmmountOfApprovedReferrals'] as String?,

    );
  }
}
