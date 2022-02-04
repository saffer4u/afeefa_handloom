class ProfileModel {
  final int varsion;
  final String? userName;
  final String? firmName;
  final String? profilePicUrl;
  final String? logoUrl;
  final String? gstNo;
  final String? userType;
  final String? accountNo;
  final String? bankName;
  final String? ifscCode;

  ProfileModel({
    required this.varsion,
    this.userName,
    this.firmName,
    this.profilePicUrl,
    this.logoUrl,
    this.gstNo,
    this.userType,
    this.accountNo,
    this.bankName,
    this.ifscCode,
  });
}
