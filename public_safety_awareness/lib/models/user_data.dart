// class UserData {
//     UserData({
//       required this.fname,
//       required this.lname,
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
//       required this.email,
//     });
  
//     String fname;
//     String lname;
//     String email;
  
//     Map<String, Object> toMap() {
//       return {
//         'fname': fname,
//         'lname': lname,
//         'email': email,
//       };
//     }
  
//     static UserData? fromMap(Map value) {
//       if (value == null) {
//         return null;
//       }
  
//       return UserData(
//         fname: value['fname'],
//         lname: value['lname'],
//         email: value['email'],
//       );
//     }
  
//     @override
//     String toString() {
//       return ('{id: $fname, name: $lname, status: $email}');
//     }
//   }