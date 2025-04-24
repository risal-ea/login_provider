import 'package:flutter/material.dart';
import 'package:login_provider/account_model.dart';
import 'package:provider/provider.dart';

class LoginHome extends StatelessWidget {
  const LoginHome({super.key});

  @override
  Widget build(BuildContext context) {
    // final account = Provider.of<Account>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<Account>(builder: (context, account, child){

          if(!account.isLoaded){
            return const Center(child: CircularProgressIndicator(),);
          }

          return Column(
            children: [
              TextField(
                controller: account.username,
                decoration: InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: account.password,
                decoration: InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 10),

              Selector<Account, bool>(
                selector: (_, provider) => provider.remember,
                builder: (_, remember, __) {
                  return Row(
                    children: [
                      Checkbox(
                        value: remember,
                        onChanged: (val) {
                          context.read<Account>().toggleRemember(val ?? false);
                        },
                      ),
                      const Text("Remember me"),
                    ],
                  );
                },
              ),

              ElevatedButton(
                onPressed: () async{
                  final account  = context.read<Account>();
                  await account.saveCredentials();

                  final email = account.username.text;
                  final pass = account.password.text;
                  final remember = account.remember;

                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                      content: Text(
                        'Email: ${email}, Password: ${pass}, remeber: ${remember}',
                      ),
                    ),
                  );
                },
                child: Text("Login"),
              ),
            ],
          );
        }),
      ),
    );
  }
}
