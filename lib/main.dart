// GoldMind AI - Full Premium Version - Build #20 FIXED
import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const GoldMindApp());

class GoldMindApp extends StatelessWidget {
  const GoldMindApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoldMind AI',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A1218),
        cardColor: const Color(0xFF13202A),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNav()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF0A1218), Color(0xFF10202E)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(width: 100, height: 100, decoration: BoxDecoration(color: const Color(0xFFC9A86A), borderRadius: BorderRadius.circular(25)), child: const Icon(Icons.trending_up, size: 60, color: Colors.black)),
          const SizedBox(height: 20),
          const Text('GoldMind AI', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const Text('XAUUSD Trading Assistant', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 40),
          const SizedBox(width: 200, child: LinearProgressIndicator(color: Color(0xFFC9A86A))),
          const SizedBox(height: 10),
          const Text('Loading...', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ]),
      ),
    );
  }
}

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int idx = 0;
  final List<Widget> pages = [const DashboardPage(), const AnalysisPage(), const TradeSetupPage(), const HistoryPage(), const SettingsPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[idx],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF0F1D28),
        selectedIndex: idx,
        onDestinationSelected: (i) => setState(() => idx = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.analytics), label: 'Analysis'),
          NavigationDestination(icon: Icon(Icons.swap_horiz), label: 'Trade'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MyWrap(title: 'GoldMind AI', children: [
      MyCard(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('XAUUSD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Gold Spot / US Dollar', style: TextStyle(color: Colors.grey, fontSize: 12)),
            SizedBox(height: 8),
            Text('2,491.32', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('+12.46 (+0.50%)', style: TextStyle(color: Colors.green, fontSize: 12)),
          ]),
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: const Text('Bullish', style: TextStyle(color: Colors.green)))
        ]),
        const SizedBox(height: 16),
        Container(height: 120, decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12)), child: CustomPaint(painter: ChartPainter(), size: const Size(double.infinity, 120))),
        const SizedBox(height: 12),
        const AIBox(text: 'Trend is uptrend on H4 and H1. Price holding above EMA 50 & 200. Look for buy opportunities on pullbacks.'),
      ]),
    ]);
  }
}

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MyWrap(title: 'Market Analysis', children: [
      const TabsRow(),
      const SizedBox(height: 12),
      MyCard(children: [
        Row2(a: 'Trend', b: '▲ Uptrend', col: Colors.green),
        Row2(a: 'EMA 50', b: '2,473.21'),
        Row2(a: 'EMA 200', b: '2,451.87'),
        Row2(a: 'RSI (14)', b: '62.4 (Neutral)'),
        Row2(a: 'ATR (14)', b: '18.7'),
        const Divider(),
        const Text('Key Levels', style: TextStyle(fontWeight: FontWeight.bold)),
        Row2(a: 'Resistance 1', b: '2,505.00'),
        Row2(a: 'Resistance 2', b: '2,520.00'),
        Row2(a: 'Support 1', b: '2,470.00'),
        Row2(a: 'Support 2', b: '2,455.00'),
      ]),
      MyCard(children: [
        const Text('Technical Summary', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Price is above EMA 50 & 200. RSI is healthy and trending up. Look for buy setups on pullbacks to 2,470 - 2,480.', style: TextStyle(color: Colors.grey, fontSize: 13)),
      ]),
    ]);
  }
}

class TradeSetupPage extends StatefulWidget {
  const TradeSetupPage({super.key});
  @override
  State<TradeSetupPage> createState() => _TradeSetupPageState();
}

class _TradeSetupPageState extends State<TradeSetupPage> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return MyWrap(title: 'Active Trades', children: [
        MyCard(color: const Color(0xFF1A2E1F), children: [
          Row(children: [const Icon(Icons.monetization_on, color: Color(0xFFC9A86A)), const SizedBox(width: 8), const Text('XAUUSD BUY 0.10 lot', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)), child: const Text('LIVE', style: TextStyle(fontSize: 10)))]),
          const SizedBox(height: 12),
          Row2(a: 'Entry', b: '2,486.50'), Row2(a: 'SL', b: '2,473.00'), Row2(a: 'TP', b: '2,503.00'), Row2(a: 'Current', b: '2,491.32'),
          const SizedBox(height: 6),
          const Text('+58.20 USD (+0.39%)', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const LinearProgressIndicator(value: 0.6, color: Colors.green, backgroundColor: Colors.white10),
        ]),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: FilledButton(style: FilledButton.styleFrom(backgroundColor: Colors.white10), onPressed: () => setState(() => isActive = false), child: const Text('Close Trade'))),
        MyCard(children: [
          const Text('Account Balance (Paper)'),
          const Text('10,000.00 USD', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('+48.20 USD', style: TextStyle(color: Colors.green)),
        ])
      ]);
    }
    return MyWrap(title: 'Trade Signal', children: [
      MyCard(color: const Color(0xFF1A2E1F), children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)), child: const Row(children: [Icon(Icons.trending_up, color: Colors.white), SizedBox(width: 8), Text('BUY SETUP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])),
        const SizedBox(height: 12),
        Row2(a: 'Entry Price', b: '2,486.50'), Row2(a: 'Stop Loss (SL)', b: '2,473.00'), Row2(a: 'Take Profit (TP1)', b: '2,503.00'), Row2(a: 'Take Profit (TP2)', b: '2,520.00'),
        const Divider(),
        Row2(a: 'Risk : Reward', b: '1 : 2.3'), Row2(a: 'Position Size (Paper)', b: '0.10 lot'),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: FilledButton(style: FilledButton.styleFrom(backgroundColor: const Color(0xFF00C853)), onPressed: () => setState(() => isActive = true), child: const Text('Place Paper Trade'))),
      ]),
      MyCard(children: [
        const Text('Reasoning', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('• Price above EMA 50 & 200\n• RSI turning up from 50\n• Strong support at 2,470', style: TextStyle(color: Colors.grey, fontSize: 13)),
      ]),
    ]);
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MyWrap(title: 'Trade History', children: [
      MyCard(children: [
        HistRow(pair: 'XAUUSD BUY', pnl: '+48.20', profit: true),
        HistRow(pair: 'XAUUSD SELL', pnl: '+32.10', profit: true),
        HistRow(pair: 'XAUUSD BUY', pnl: '-18.50', profit: false),
        HistRow(pair: 'XAUUSD SELL', pnl: '+67.40', profit: true),
      ]),
      MyCard(children: [
        const Row(children: [Icon(Icons.lightbulb, color: Color(0xFFC9A86A)), SizedBox(width: 8), Text('GoldMind AI', style: TextStyle(fontWeight: FontWeight.bold))]),
        const SizedBox(height: 8),
        const Text('Based on current market conditions, the probability of a bullish move in XAUUSD is high (72%) in the next 6-12 hours.', style: TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 12),
        const Text('Key Insights', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('✓ Trend: Uptrend (H1 & H4)\n✓ Momentum: Strong\n✓ RSI: Not overbought\n✓ Volume: Increasing\n✓ Key Level: 2,503 (resistance)', style: TextStyle(fontSize: 12, color: Colors.grey)),
      ]),
    ]);
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String risk = '1%';
  String lot = '0.10';
  bool notif = true;
  @override
  Widget build(BuildContext context) {
    return MyWrap(title: 'Settings', children: [
      MyCard(children: [
        SetTile(icon: Icons.swap_horiz, t: 'Trading Mode', v: 'Paper Trading', onTap: () {}),
        SetTile(icon: Icons.percent, t: 'Risk Per Trade', v: risk, onTap: () { setState(() => risk = risk == '1%'? '2%' : '1%'); }),
        SetTile(icon: Icons.layers, t: 'Lot Size', v: lot, onTap: () { setState(() => lot = lot == '0.10'? '0.20' : '0.10'); }),
        SetTile(icon: Icons.notifications, t: 'Notifications', v: notif? 'On' : 'Off', onTap: () { setState(() => notif =!notif); }),
        SetTile(icon: Icons.dark_mode, t: 'Theme', v: 'Dark', onTap: () {}),
        SetTile(icon: Icons.language, t: 'Language', v: 'English', onTap: () {}),
        SetTile(icon: Icons.cable, t: 'MTS Connection', v: 'Not Connected', isError: true, onTap: () {}),
      ]),
      SizedBox(width: double.infinity, height: 50, child: FilledButton(
        style: FilledButton.styleFrom(backgroundColor: const Color(0xFF1E3A5F)),
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('MT5 Integration - Coming Soon!'))),
        child: const Text('Connect MT5', style: TextStyle(fontWeight: FontWeight.bold)),
      )),
    ]);
  }
}

// REUSABLE WIDGETS - ALL FIXED
class MyWrap extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const MyWrap({required this.title, required this.children, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title), backgroundColor: const Color(0xFF0A1218)), body: ListView(padding: const EdgeInsets.all(16), children: children));
  }
}

class MyCard extends StatelessWidget {
  final List<Widget> children;
  final Color? color;
  const MyCard({required this.children, this.color, super.key});
  @override
  Widget build(BuildContext context) => Card(color: color, margin: const EdgeInsets.only(bottom: 12), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children)));
}

class Row2 extends StatelessWidget {
  final String a;
  final String b;
  final Color? col;
  const Row2({required this.a, required this.b, this.col, super.key});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(a, style: const TextStyle(color: Colors.grey, fontSize: 13)), Text(b, style: TextStyle(color: col, fontWeight: FontWeight.bold, fontSize: 13))]));
}

class TabsRow extends StatelessWidget {
  const TabsRow({super.key});
  @override
  Widget build(BuildContext context) => const Row(children: [TabItem(t: 'H4', sel: true), TabItem(t: 'H1', sel: false), TabItem(t: 'M15', sel: false)]);
}

class TabItem extends StatelessWidget {
  final String t;
  final bool sel;
  const TabItem({required this.t, required this.sel, super.key});
  @override
  Widget build(BuildContext context) => Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), decoration: BoxDecoration(color: sel? const Color(0xFFC9A86A) : Colors.white10, borderRadius: BorderRadius.circular(20)), child: Text(t, style: TextStyle(color: sel? Colors.black : Colors.white, fontSize: 12)));
}

class AIBox extends StatelessWidget {
  final String text;
  const AIBox({required this.text, super.key});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFC9A86A).withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFC9A86A).withOpacity(0.3))), child: Row(children: [const Icon(Icons.auto_awesome, color: Color(0xFFC9A86A), size: 16), const SizedBox(width: 8), Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)))]));
}

class HistRow extends StatelessWidget {
  final String pair;
  final String pnl;
  final bool profit;
  const HistRow({required this.pair, required this.pnl, required this.profit, super.key});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(pair, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), const Text('Aug 15, 2025', style: TextStyle(color: Colors.grey, fontSize: 10))]), Text(pnl, style: TextStyle(color: profit? Colors.green : Colors.red, fontWeight: FontWeight.bold))]));
}

class SetTile extends StatelessWidget {
  final IconData icon;
  final String t;
  final String v;
  final bool isError;
  final VoidCallback onTap;
  const SetTile({required this.icon, required this.t, required this.v, this.isError = false, required this.onTap, super.key});
  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: Colors.white54, size: 20),
    title: Text(t, style: const TextStyle(fontSize: 14)),
    subtitle: Text(v, style: TextStyle(fontSize: 12, color: isError? Colors.red : const Color(0xFFC9A86A))),
    trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
    onTap: onTap,
    contentPadding: EdgeInsets.zero,
  );
}

class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.green..strokeWidth = 2..style = PaintingStyle.stroke;
    final Path path = Path();
    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.2, size.height * 0.6);
    path.lineTo(size.width * 0.4, size.height * 0.65);
    path.lineTo(size.width * 0.6, size.height * 0.4);
    path.lineTo(size.width * 0.8, size.height * 0.3);
    path.lineTo(size.width, size.height * 0.2);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
