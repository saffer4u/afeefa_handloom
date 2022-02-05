class ClintProfile {
  final int varsion;
  final String userName;
  final String farmName;
  final String profilePicUrl;
  final String logoUrl;
  final String gstNo;
  final String userType;
  final String accountNo;
  final String bankName;
  final String ifscCode;

  ClintProfile({
    this.varsion = 1,
    this.userName = 'Unknown',
    this.farmName = 'Unknown',
    this.profilePicUrl = 'https://picsum.photos/200',
    this.logoUrl = 'https://picsum.photos/200',
    this.gstNo = 'Unknown',
    this.userType = 'clint',
    this.accountNo = "Unknown",
    this.bankName = 'Unknown',
    this.ifscCode = 'Unknown',
  });

  Map<String, dynamic> toMap() {
    return {
      'varsion': varsion,
      'userName': userName,
      'farmName': farmName,
      'profilePicUrl': profilePicUrl,
      'logoUrl': logoUrl,
      'gstNo': gstNo,
      'userType': userType,
      'accountNo': accountNo,
      'bankName': bankName,
      'ifscCode': ifscCode,

    };
  }
}
