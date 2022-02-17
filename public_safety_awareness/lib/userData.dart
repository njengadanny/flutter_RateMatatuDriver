class UserData {
  final String fname;
  final String lname;
  final String email;

  UserData({required this.fname, required this.lname, required this.email});

  factory UserData.fromRTDB(Map<String, dynamic> data) {
    return UserData(
        fname: data['fname'] ?? 'first name',
        lname: data['lname']?? 'last name',
        email: data['email']?? 'email');
  }
  String fancyDisplay(){
    return 'full name: $fname \n last name: $lname, \n email $email';
  }
}