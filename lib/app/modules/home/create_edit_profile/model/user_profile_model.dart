class UserProfile {
  String phoneNumber = 'Unknown';
  bool isVarified = false;
  bool isAdmin = false;
  int varsion = 1;
  String userName = 'Unknown';
  String firmName = 'Unknown';
  String profilePicUrl = 'https://picsum.photos/200';
  String logoUrl = 'https://picsum.photos/200';
  String gstNo = 'Unknown';
  String userType = 'Clint';
  String accountNo = '';
  String bankName = '';
  String ifscCode = '';

  UserProfile({
    this.isVarified = false,
    this.phoneNumber = 'Unknown',
    this.isAdmin = false,
    this.varsion = 1,
    this.userName = 'Unknown',
    this.firmName = 'Unknown',
    this.profilePicUrl = 'https://picsum.photos/200',
    this.logoUrl = 'https://picsum.photos/200',
    this.gstNo = 'Unknown',
    this.userType = 'Clint',
    this.accountNo = '',
    this.bankName = '',
    this.ifscCode = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'isVarified': isVarified,
      'phoneNumber': phoneNumber,
      'isAdmin': isAdmin,
      'varsion': varsion,
      'userName': userName,
      'firmName': firmName,
      'profilePicUrl': profilePicUrl,
      'logoUrl': logoUrl,
      'gstNo': gstNo,
      'userType': userType,
      'accountNo': accountNo,
      'bankName': bankName,
      'ifscCode': ifscCode,
    };
  }

  UserProfile.toObject(Map<String, dynamic> map) {
    isVarified = map['isVarified'];
    phoneNumber = map['phoneNumber'];
    isAdmin = map['isAdmin'];
    varsion = map['varsion'];
    userName = map['userName'];
    firmName = map['firmName'];
    profilePicUrl = map['profilePicUrl'];
    logoUrl = map['logoUrl'];
    gstNo = map['gstNo'];
    userType = map['userType'];
    accountNo = map['accountNo'];
    bankName = map['bankName'];
    ifscCode = map['ifscCode'];
  }
}
