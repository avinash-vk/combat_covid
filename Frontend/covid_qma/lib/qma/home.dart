import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  //const Login({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {  

  String temptext='lo';
  String facetext='ko';
  bool isface =  false;
  bool istemp = false;
  String facetime = '';
  String temptime = '';
  String temptex,facetex;
  Future<void> fun() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pno = prefs.getString('PhoneNumber');
    prefs.setBool('Logged-in_$pno', true);
    facetime = prefs.getString("last-face-log")!=null?prefs.getString("last-face-log").substring(0,19):"You haven't logged this yet.";
    temptime = prefs.getString("last-temp-log")!=null?prefs.getString("last-temp-log").substring(0,19):"You haven't logged this yet.";;
    isface = prefs.getBool('FTIME')!=null?prefs.getBool('FTIME'):false;
    istemp = prefs.getBool('TTIME')!=null?prefs.getBool('TTIME'):false;
    temptex  = 'You last logged your temperature at:';
    facetex = 'You last logged your face at:';
    print("$isface,$istemp");
    if (isface == false)
      if (facetime !="You haven't logged this yet." )
        facetex = "Log your face ASAP.Last logged at:";
      else
        facetex = '';

    if (istemp == false)
      if (temptime !="You haven't logged this yet." )
        temptex = "Log your temperature ASAP.Last logged at:";
      else  
        temptex = '';
    setState(() {
      isface = isface;
      istemp = istemp;
      facetext = "$facetex $facetime";
      temptext = "$temptex $temptime";
    });
  }

  @override
  void initState(){
    fun();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar:  AppBar(
      backgroundColor: Colors.amber,
        title: Text(
          'home',
           style:TextStyle(
             fontSize:30,
             letterSpacing: 2.0,
           ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text(
                'Quarantine management app',
                style:TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              )
            ),
            ListTile(leading: Icon(Icons.account_circle),
                title:Text('Dashboard'),
                onTap: () {
                      Navigator.pushNamed(context, '/dashboard');
                },
            ),
            ListTile(leading: Icon(Icons.notifications),
                title:Text('location'),
                onTap: () {
                      Navigator.pushNamed(context, '/location');
                },
            ), 
            ListTile(leading: Icon(Icons.notifications),
                title:Text('Log out'),
                onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('PhoneNumber');
                      Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route)=> false);
                },
            ),
          ]
        ),
      ),

      body: 
      RefreshIndicator(
        onRefresh: fun,
        child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child:Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 40, 40),
          child: Column(children: <Widget>[
            Text(
              facetext,
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            Icon(
            (isface==(false))?Icons.backspace:Icons.check_circle,
            color:(isface!=(false)? Colors.green:Colors.red)
            ),
            SizedBox(height: 10),
            RaisedButton(onPressed: (){
              Navigator.pushNamed(context, '/face-login');
            },
              color: Colors.amber,
              child : Text(
                'Login Face'
              ),
            ), 

            Divider(
              height: 90,
              color: Colors.grey,
            ),

            Text(
              temptext,
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            Icon(
            (istemp==(false))?Icons.backspace:Icons.check_circle,
            color:(istemp!=(false)? Colors.green:Colors.red)
            ),
            SizedBox(height: 10),
            RaisedButton(onPressed: (){
              Navigator.pushNamed(context, '/temp-login');
            },
              color: Colors.amber,
              child : Text(
                'Login Temperature'
              ),
            ), 

            Divider(
              height: 90,
              color: Colors.grey,
            ),

            Text(
              'Inform if you had close contact with a person rightly: ',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(onPressed: (){
              Navigator.pushNamed(context, '/contact-person');
            },
              color: Colors.amber,
              child : Text(
                'Inform contact'
              ),
            ), 

            Divider(
              height: 90,
              color: Colors.grey,
            ),
          ],)  
      ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/distress');
          },
        child: Icon(Icons.add_alarm),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}