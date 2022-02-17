import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';
import 'splash_screen.dart';
import 'header_widget.dart';

import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';
import 'registration_page.dart';
import 'provider.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {

  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  

  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${user.displayName ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email: ${user.email ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Created: ${DateFormat('MM/dd/yyyy').format(user.metadata.creationTime)}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        showSignOut(context, user.isAnonymous),
      ],
    );
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return RaisedButton(
        child: Text("Sign In To Save Your Data"),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    } else {
      return RaisedButton(
        child: Text("Sign Out"),
        onPressed: () async {
          try {
            await Provider.of(context).auth.signOut();
          } catch (e) {
            print(e);
          }
        },
      );
    }
  }
}
//   State<StatefulWidget> createState() {
//     return _ProfilePageState();
//   }
// }

// class _ProfilePageState extends State<ProfilePage> {
//   double _drawerIconSize = 24;
//   double _drawerFontSize = 17;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Profile Page",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         elevation: 0.5,
//         iconTheme: const IconThemeData(color: Colors.white),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: <Color>[
//                 Theme.of(context).primaryColor,
//                 Theme.of(context).accentColor,
//               ])),
//         ),
//         actions: [
//           Container(
//             margin: const EdgeInsets.only(
//               top: 16,
//               right: 16,
//             ),
//             child: Stack(
//               children: <Widget>[
//                 const Icon(Icons.notifications),
//                 Positioned(
//                   right: 0,
//                   child: Container(
//                     padding: const EdgeInsets.all(1),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 12,
//                       minHeight: 12,
//                     ),
//                     child: const Text(
//                       '5',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 8,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//       drawer: Drawer(
//         child: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   stops: const [
//                 0.0,
//                 1.0
//               ],
//                   colors: [
//                 Theme.of(context).primaryColor.withOpacity(0.2),
//                 Theme.of(context).accentColor.withOpacity(0.5),
//               ])),
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     stops: [0.0, 1.0],
//                     colors: [
//                       Theme.of(context).primaryColor,
//                       Theme.of(context).accentColor,
//                     ],
//                   ),
//                 ),
//                 child: Container(
//                   alignment: Alignment.bottomLeft,
//                   child: const Text(
//                     "FlutterTutorial.Net",
//                     style: TextStyle(
//                         fontSize: 25,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.screen_lock_landscape_rounded,
//                   size: _drawerIconSize,
//                   color: Theme.of(context).accentColor,
//                 ),
//                 title: Text(
//                   'Splash Screen',
//                   style: TextStyle(
//                       fontSize: 17, color: Theme.of(context).accentColor),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               SplashScreen(title: "Splash Screen")));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.login_rounded,
//                     size: _drawerIconSize,
//                     color: Theme.of(context).accentColor),
//                 title: Text(
//                   'Login Page',
//                   style: TextStyle(
//                       fontSize: _drawerFontSize,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const LoginPage()),
//                   );
//                 },
//               ),
//               Divider(
//                 color: Theme.of(context).primaryColor,
//                 height: 1,
//               ),
//               ListTile(
//                 leading: Icon(Icons.person_add_alt_1,
//                     size: _drawerIconSize,
//                     color: Theme.of(context).accentColor),
//                 title: Text(
//                   'Registration Page',
//                   style: TextStyle(
//                       fontSize: _drawerFontSize,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => RegistrationPage()),
//                   );
//                 },
//               ),
//               Divider(
//                 color: Theme.of(context).primaryColor,
//                 height: 1,
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.password_rounded,
//                   size: _drawerIconSize,
//                   color: Theme.of(context).accentColor,
//                 ),
//                 title: Text(
//                   'Forgot Password Page',
//                   style: TextStyle(
//                       fontSize: _drawerFontSize,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ForgotPasswordPage()),
//                   );
//                 },
//               ),
//               Divider(
//                 color: Theme.of(context).primaryColor,
//                 height: 1,
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.verified_user_sharp,
//                   size: _drawerIconSize,
//                   color: Theme.of(context).accentColor,
//                 ),
//                 title: Text(
//                   'Verification Page',
//                   style: TextStyle(
//                       fontSize: _drawerFontSize,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ForgotPasswordVerificationPage()),
//                   );
//                 },
//               ),
//               Divider(
//                 color: Theme.of(context).primaryColor,
//                 height: 1,
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.logout_rounded,
//                   size: _drawerIconSize,
//                   color: Theme.of(context).accentColor,
//                 ),
//                 title: Text(
//                   'Logout',
//                   style: TextStyle(
//                       fontSize: _drawerFontSize,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 onTap: () {
//                   SystemNavigator.pop();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Container(
//               height: 100,
//               child: const HeaderWidget(100, false, Icons.house_rounded),
//             ),
//             Container(
//               alignment: Alignment.center,
//               margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
//               padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       border: Border.all(width: 5, color: Colors.white),
//                       color: Colors.white,
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 20,
//                           offset: Offset(5, 5),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.person,
//                       size: 80,
//                       color: Colors.grey.shade300,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text(
//                     'Mr. Donald Trump',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text(
//                     'Former President',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           padding:
//                               const EdgeInsets.only(left: 8.0, bottom: 4.0),
//                           alignment: Alignment.topLeft,
//                           child: const Text(
//                             "User Information",
//                             style: TextStyle(
//                               color: Colors.black87,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                             ),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                         Card(
//                           child: Container(
//                             alignment: Alignment.topLeft,
//                             padding: const EdgeInsets.all(15),
//                             child: Column(
//                               children: <Widget>[
//                                 Column(
//                                   children: <Widget>[
//                                     ...ListTile.divideTiles(
//                                       color: Colors.grey,
//                                       tiles: [
//                                         const ListTile(
//                                           contentPadding: EdgeInsets.symmetric(
//                                               horizontal: 12, vertical: 4),
//                                           leading: Icon(Icons.my_location),
//                                           title: Text("Location"),
//                                           subtitle: Text("USA"),
//                                         ),
//                                         const ListTile(
//                                           leading: Icon(Icons.email),
//                                           title: Text("Email"),
//                                           subtitle:
//                                               Text("donaldtrump@gmail.com"),
//                                         ),
//                                         const ListTile(
//                                           leading: Icon(Icons.phone),
//                                           title: Text("Phone"),
//                                           subtitle: Text("99--99876-56"),
//                                         ),
//                                         const ListTile(
//                                           leading: Icon(Icons.person),
//                                           title: Text("About Me"),
//                                           subtitle: Text(
//                                               "This is a about me link and you can khow about me in this section."),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
