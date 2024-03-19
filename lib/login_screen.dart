import 'package:api_parsing/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginValidation extends StatefulWidget {
  const LoginValidation({super.key});

  @override
  State<LoginValidation> createState() => _LoginValidationState();
}

class _LoginValidationState extends State<LoginValidation> {
  final _formField = GlobalKey<FormState>();

  bool passwordToggle = false;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome ! ! !',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formField,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  'E-Com',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 29,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 29,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 29.0, right: 29),
                  child: TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter UserName',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.deepOrange,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Username';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 29,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 29.0, right: 29),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: passwordToggle,
                    decoration: InputDecoration(
                        hintText: 'Enter Password',
                        prefixIcon: Icon(
                          Icons.password_sharp,
                          color: Colors.deepOrange,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                          ),
                        ),
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              passwordToggle = !passwordToggle;
                            });
                          },
                          child: Icon(passwordToggle
                              ? Icons.visibility_off_sharp
                              : Icons.visibility_sharp),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                      if (_passwordController.text.length < 6) {
                        return 'Password should contain more than 6 characters';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 29,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepOrange)),
                  onPressed: () {
                    getUser();
                    print('Sign In button Clicked');
                    // if (_formField.currentState!.validate()) {
                    //   print('Success');
                    //    _userNameController.clear();
                    //    _passwordController.clear();
                    // }
                  },
                  icon: Icon(
                    Icons.login_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        indent: 19,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(
                        'or',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        endIndent: 19,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepOrange),
                  ),
                  onPressed: () {
                    print('Create account button clicked');
                  },
                  child: Text(
                    'Create an Account',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 250, top: 45),
                  child: InkWell(
                    onTap: () {
                      print('help clicked');
                    },
                    child: Text(
                      'Help',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 250, top: 15),
                  child: Text(
                    'English (UK)',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getUser() async {
    if (_userNameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      final response = await http.post(Uri.parse('https://reqres.in/api/login'),
          body: ({
            'email': _userNameController.text,
            'password': _passwordController.text
          }));
      if (response.statusCode == 200) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => WelcomeScreen()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid Credentials')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Black filed not field')));
    }
  }
}
