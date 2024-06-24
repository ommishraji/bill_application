import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:bill_application/const.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
Color color1 = Colors.blue;
Color color2 = Colors.grey;
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String dropdownValue = 'Last Month';
  bool spin = false;
  bool isLogged = false;
  bool issignup = true;
  String forgotpassword = 'Forget Password?';
  String login = 'LOGIN';
  String signuptext = 'Don\'t have an Account?';
  String signup = 'Sign Up';
  String welcome = 'Welcome Back!';
  String welcomesub = 'Log into your account';
  String month = "March";
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  late String email , password;

  void loginfunction(){
    setState(() {
      forgotpassword = 'Forget Password?';
      login = 'LOGIN';
      signuptext = 'Don\'t have an Account?';
      signup = 'Sign Up';
      welcome = 'Welcome Back!';
      welcomesub = 'Log into your account';
    });
    issignup = true;
    controller2.clear();
    controller1.clear();
  }

  void signupfunction(){
    setState(() {
      forgotpassword = 'Verify Email via verification link';
      login = 'SIGN UP';
      signuptext = 'Already have an account?';
      signup = 'Login';
      welcome = 'Welcome!';
      welcomesub = 'Create a new account';
    });
    issignup = false;
    controller2.clear();
    controller1.clear();
  }

  Future<void> signupprocess() async{
    setState(() {
      spin = true;
    });
    try{
      UserCredential? newuser;
      newuser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = newuser.user!;
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verification Email sent to ${user.email}. Please verify to Proceed')));
      loginfunction();
      controller1.clear();
      controller2.clear();
      setState(() {
        spin = false;
      });
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register: $e')),
      );
      controller2.clear();
      setState(() {
        spin = false;
      });
    }
  }
  void loginprocess() async {
    setState(() {
      spin = true;
    });
    try{
      final fire = FirebaseAuth.instance;
      final user = await fire.signInWithEmailAndPassword(email: email, password: password);
      controller1.clear();
      controller2.clear();
      isLogged = true;
      setState(() {
        spin = false;
        welcome = 'Hello';
        welcomesub = fire.currentUser!.email!;
        welcomesub = welcomesub.substring(0,welcomesub.indexOf('@'));
      });
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
      controller2.clear();
      setState(() {
        spin = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height*1,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
          return  isLogged == false ?  logginscreen(context): utility(context);
          },
        ),
      ),
      bottomNavigationBar: bottomBar(),
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrangeAccent,
      unselectedItemColor: Colors.grey.shade400,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      backgroundColor: Colors.white,
      onTap: (value){

      },
      items: [
        const BottomNavigationBarItem(
            label: 'Dashboard',
            icon: Icon(Icons.speed_outlined),
        ),
        const BottomNavigationBarItem(
          label: 'usage',
        icon: Icon(Icons.data_usage_outlined),
        ),
        const BottomNavigationBarItem(
          label: 'Histroy',
          icon: Icon(Icons.history),
        ),
        const BottomNavigationBarItem(
          label: 'Support',
          icon: Icon(Icons.support_agent_outlined),
        ),
      ],
    );
  }

  Column utility(BuildContext context) {
    return Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height*.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.menu,
                          color: Colors.white,
                          size: 25,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.person_pin,
                              color: Colors.white,
                              size: 25,),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(Icons.notifications,
                              color: Colors.white,
                              size: 25,),
                            ],
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                        radius: 45,
                      ),
                      title: Text(welcome,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),),
                      subtitle: Text(welcomesub,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25
                      ),),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height*.605,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Divider(
                        thickness: 4,
                        color: Colors.black,
                        indent: MediaQuery.of(context).size.width*.43,
                        endIndent: MediaQuery.of(context).size.width*.43,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 15),
                      child: Text(
                        'Quick Actions',
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: (){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text(
                                        'No API provided to fetch bill amount and add payment gateway'
                                    )
                                    )
                                );
                              },
                              child: Image.asset('images/1.png',
                              width: 75,
                              height: 75,)),
                          InkWell(
                              onTap: (){
                                weblaunch('https://forms.gle/L1mGCutYimyQWXyn8');
                              },
                              child: Image.asset('images/2.png',
                                width: 75,
                                height: 75,)),
                          InkWell(
                              onTap: (){
                                weblaunch('https://forms.gle/DrRWQduf7uyJhmPF7');
                              },
                              child: Image.asset('images/3.png',
                                width: 75,
                                height: 75,)),
                          InkWell(
                              onTap: (){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('No information provided about services in the assignment pdf')));
                              },
                              child: Image.asset('images/4.png',
                                width: 75,
                                height: 75,)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: (){
                                weblaunch('https://forms.gle/gNna1uK12R5q1Ytv6');
                              },
                              child: Image.asset('images/5.png',
                                width: 75,
                                height: 75,)),
                          InkWell(
                              onTap: (){
                                weblaunch('https://forms.gle/foeSGrxSALZRk5ar9');
                              },
                              child: Image.asset('images/6.png',
                                width: 75,
                                height: 75,)),
                          InkWell(
                              onTap: (){
                                weblaunch('https://forms.gle/QRjEMCq5B3EThrWZ8');
                              },
                              child: Image.asset('images/7.png',
                                width: 75,
                                height: 75,)),
                          InkWell(
                              onTap: (){
                                weblaunch('https://forms.gle/FNYEZzhsdrwHuYDo7');
                              },
                              child: Image.asset('images/8.png',
                                width: 75,
                                height: 75,)),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Text('Gas | ',
                              style: TextStyle(
                                fontSize: 20,
                              ),),
                              Text('SA1234567',
                              style: TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontSize: 20
                              ),),
                            ],
                          ),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.expand_circle_down_outlined,
                                color: Colors.grey,
                                size: 20,),
                                style: const TextStyle(
                                    color: Colors.grey
                                ),
                                underline: Container(
                                  height: 0,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                    color1 == Colors.blue ? color1 = Colors.red: color1 = Colors.blue;
                                    color2 == Colors.grey ? color2 = Colors.blue: color2 = Colors.grey;
                                    if(newValue == 'Last Month')
                                      month = 'April';
                                    else if(newValue == 'Last 2 Back')
                                      month = 'March';
                                    else
                                      month = 'Feb';
                                  });
                                },
                                items: <String>['Last Month', 'Last 2 Back', 'Last 3 Back   ']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, left: 18),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height*.11,
                        width: MediaQuery.of(context).size.width*.9,
                        child: Material(
                          elevation: 15,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 3),
                                    child: SizedBox(
                                      height: 10,
                                      width: 45,
                                      child: CustomPaint(
                                        painter: HalfCirclePainter(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Bills',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20
                                          ),),
                                        Text('20 $month 2020',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Text(
                                  '43\$',
                                  style: TextStyle(
                                    color: Colors.yellow.shade800,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              )
            ],
          );
  }

  Stack logginscreen(BuildContext context) {
    return Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height*.3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, right: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(welcome,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            ),),
                          Text(welcomesub,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            ),)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height*.7,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    ),
                  )
                ],
              ),
              //overlay container
              Positioned(
                top: MediaQuery.sizeOf(context).height*.27,
                left: MediaQuery.sizeOf(context).width*.1,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery
                            .sizeOf(context)
                            .height * .4,
                      width: MediaQuery
                            .sizeOf(context)
                            .width * .8,
                      child: ModalProgressHUD(
                        inAsyncCall: spin,
                        child: Material(
                            elevation: 10,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextField(
                                    controller: controller1,
                                    onChanged: (value){
                                      email = value;
                                    },
                                    decoration: boxkadecoration1.copyWith(hintText: 'Enter the Email ID'),
                                  ),
                                  TextField(
                                    controller: controller2,
                                    obscureText: true,
                                    onChanged: (value){
                                      password = value;
                                    },
                                    decoration: boxkadecoration1.copyWith(hintText: 'Password'),
                                  ),
                                  TextButton(onPressed: (){
                                    //Impliment forget password solution
                                  }, child: Text(forgotpassword)),
                                  Container(
                                    height: 40,
                                    width: 500,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.deepOrange,
                                    ),
                                    child: TextButton(onPressed: (){
                                      setState(() {
                                        issignup == true? loginprocess(): signupprocess();
                                      });
                                    }, child: Text(login,
                                    style: const TextStyle(
                                      color: Colors.white
                                    ),)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          signuptext,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(onPressed: (){
                          issignup == true ? signupfunction():loginfunction();
                        },
                            child: Text(signup),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          );
  }
  void weblaunch(String link) async {
    Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 3);

    // Draw blue half
    paint.color = color1;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      3.14,
      false,
      paint,
    );
    // Draw grey half
    paint.color = color2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14,
      3.14,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}