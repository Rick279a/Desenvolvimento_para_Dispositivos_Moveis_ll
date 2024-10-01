import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'home_screen.dart';

const users = {
  'ricardo@gmail.com': '439279',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Usuário não existe';
      }
      if (users[data.name] != data.password) {
        return 'Senha incorreta';
      }
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Estoque de Carros',
      logo: const AssetImage('imagens/Logo.webp'),
      theme: LoginTheme(
        primaryColor: Colors.blue[900]!,
        accentColor: Colors.lightBlue[200]!,
        errorColor: Colors.redAccent,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        buttonTheme: const LoginButtonTheme(
          splashColor: Colors.blueAccent,
          backgroundColor: Colors.blue,
          highlightColor: Colors.lightBlue,
        ),
        cardTheme: CardTheme(
          color: Colors.blue[100],
          elevation: 5,
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
      onLogin: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      },
      onRecoverPassword: _recoverPassword,
      hideForgotPasswordButton: true,
    );
  }
}
