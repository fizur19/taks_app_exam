class ResponsObject {
  final int statuscode;
  final dynamic responsbody;
  final bool issucsees;
  final String? errormsg;
  ResponsObject({
    required this.statuscode,
    required this.responsbody,
    required this.issucsees,
    this.errormsg = '',
  });
}
