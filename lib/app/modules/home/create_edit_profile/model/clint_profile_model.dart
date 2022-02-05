class ClintProfileModel {
  final int varsion;
  final String userName;
  final String firmName;
  final String profilePicUrl;
  final String logoUrl;
  final String gstNo;
  final String userType;
  final String accountNo;
  final String bankName;
  final String ifscCode;

  ClintProfileModel({
    this.varsion = 1,
    this.userName = 'Unknown',
    this.firmName = 'Unknown',
    this.profilePicUrl = 'https://picsum.photos/200',
    this.logoUrl = 'https://picsum.photos/200',
    this.gstNo = 'Unknown',
    this.userType = 'clint',
    this.accountNo = "Unknown",
    this.bankName = 'Unknown',
    this.ifscCode = 'Unknown',
  });
}
