import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: LogInForm(),
          ),
        ),
      ),
    );
  }
}

class LogInForm extends StatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  // Hard coding this for now, may make this configurable for a larger release,
  // but i'll probably still want to distribute a build with this set by default
  // and another that allows this to be configured. CI go brr
  final _hostTextController = TextEditingController(
      text: "https://lis-hac.eschoolplus.powerschool.com/HomeAccess");
  final _userTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final double _formProgress = 0;

  bool logInLock = false;
    final storage = FlutterSharedStorage();
    // Map<String, String> allValues = await storage.re();


  @override
  Widget build(BuildContext context) {

    Navigator.of(context).pushNamed('/grades');
    void _onSubmit() {
      if (logInLock) {
        return;
      }
      logInLock = true;
      try {
        login(_hostTextController.value.text, _userTextController.value.text,
            _passwordTextController.value.text);
        Navigator.of(context).pushNamed('/grades');
      } catch (e) {
        // TODO: Display errors
      }
      logInLock = false;
    }

    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: _formProgress),
          Text('Log in', style: Theme.of(context).textTheme.headline4),
          Text(
              "This information is only used to retrieve data from HAC and is only saved on your local device. Visit yac.jasonaa.me/security for more details."),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
                controller: _hostTextController,
                decoration: InputDecoration(hintText: 'Host'),
                readOnly: false),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _userTextController,
              decoration: InputDecoration(hintText: 'Username/Email'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordTextController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: _onSubmit,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

// returns true if login was successful
Future<void> login(String host, String user, String pass) async {
  // should throw an exception if unsuccessful, this is caught + handled in the widget
  await getClassGrades(host, user, pass);
  const storage = FlutterSecureStorage();
  await storage.write(key: 'hac_host', value: host);
  await storage.write(key: 'hac_user', value: user);
  await storage.write(key: 'hac_pass', value: pass);
  return;
}

Future<Map<String, Object>> getClassGrades(
    String host, String user, String pass) async {
  return {};
}
