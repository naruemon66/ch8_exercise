import 'package:flutter/material.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});
  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  String _savedEmail = '';
  String _savedPassword = '';
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ฟอร์มล็อกอิน')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'กรุณาป้อนข้อมูลเข้าสู่ระบบ:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'อีเมล',
                  hintText: 'you@example.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกอีเมลของคุณ';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'กรุณากรอกอีเมลให้ถูกต้อง';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    _savedEmail = value;
                  }
                },
              ),

              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'รหัสผ่าน',
                  hintText: 'ป้อนรหัสผ่านของคุณ',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาป้อนรหัสผ่านของคุณ';
                  }
                  if (value.length < 6) {
                    return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    _savedPassword = value;
                  }
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('ฟอร์มถูกต้อง! กำลังประมวณผลข้อมูล...'),
                      ),
                    );
                    print('_savedEmail: $_savedEmail');
                    print('_savedPassword: $_savedPassword');
                  } else {
                    print('ข้อมูลไม่ถูกต้อง');
                  }
                },
                child: const Text('ล็อกอิน'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
