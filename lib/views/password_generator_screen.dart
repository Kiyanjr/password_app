import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  State<PasswordGeneratorScreen> createState() => _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  double _length = 16;
  bool _incUpper = true;
  bool _incLower = true;
  bool _incNums = true;
  bool _incSymbols = true;
  String _generated = '';

  @override
  void initState() {
    super.initState();
    _generate();
  }

  void _generate() {
    const upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lower = 'abcdefghijklmnopqrstuvwxyz';
    const nums = '0123456789';
    const syms = '!@#\$%^&*()_+<>?';

    String pool = '';
    if (_incUpper) pool += upper;
    if (_incLower) pool += lower;
    if (_incNums) pool += nums;
    if (_incSymbols) pool += syms;

    if (pool.isEmpty) {
      setState(() => _generated = 'Select at least one option');
      return;
    }

    final rnd = Random();
    String res = '';
    for (int i = 0; i < _length; i++) {
      res += pool[rnd.nextInt(pool.length)];
    }
    setState(() => _generated = res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Password Generator', style: TextStyle(color: Colors.white, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _generated,
                      style: const TextStyle(color: Colors.greenAccent, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white70),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _generated));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('🟢 Strong Password', style: TextStyle(color: Colors.greenAccent, fontSize: 13)),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Password Length', style: TextStyle(color: Colors.white70, fontSize: 14)),
                Text('${_length.toInt()}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
            Slider(
              value: _length,
              min: 6,
              max: 32,
              activeColor: Colors.blue,
              inactiveColor: Colors.white24,
              onChanged: (val) {
                setState(() => _length = val);
                _generate();
              },
            ),
            const Divider(color: Colors.white24),
            SwitchListTile(
              title: const Text('Include Uppercase Letters', style: TextStyle(color: Colors.white70, fontSize: 14)),
              value: _incUpper,
              activeColor: Colors.blue,
              onChanged: (val) {
                setState(() => _incUpper = val);
                _generate();
              },
            ),
            SwitchListTile(
              title: const Text('Include Lowercase Letters', style: TextStyle(color: Colors.white70, fontSize: 14)),
              value: _incLower,
              activeColor: Colors.blue,
              onChanged: (val) {
                setState(() => _incLower = val);
                _generate();
              },
            ),
            SwitchListTile(
              title: const Text('Include Numbers', style: TextStyle(color: Colors.white70, fontSize: 14)),
              value: _incNums,
              activeColor: Colors.blue,
              onChanged: (val) {
                setState(() => _incNums = val);
                _generate();
              },
            ),
            SwitchListTile(
              title: const Text('Include Symbols', style: TextStyle(color: Colors.white70, fontSize: 14)),
              value: _incSymbols,
              activeColor: Colors.blue,
              onChanged: (val) {
                setState(() => _incSymbols = val);
                _generate();
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _generate,
                child: const Text('Generate New', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
