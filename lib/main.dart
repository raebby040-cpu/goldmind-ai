import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const GoldMindApp());

class GoldMindApp extends StatelessWidget {
  const GoldMindApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A1218),
        cardColor: const Color(0xFF13202A),
      ),
      home: const SplashScreen(),
    );
  }
}

// SPLASH
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNav()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0A1218), Color(0xFF10202E)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(width: 100, height: 100, decoration: BoxDecoration(color: const Color(0xFFC9A86A), borderRadius: BorderRadius.circular(25)), child: const Icon(Icons.trending_up, size: 60, color: Colors.black)),
          const SizedBox(height: 20),
          const Text('GoldMind AI', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const Text('XAUUSD Trading Assistant', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 40),
          const SizedBox(width: 200, child: LinearProgressIndicator(color: Color(0xFFC9A86A))),
          const SizedBox(height: 10),
          const Text('Loading...', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ])),
      ),
    );
  }
}

// MAIN NAVIGATION
class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override
  State<MainNav> createState() => _MainNavState();
}
class _MainNavState extends State<MainNav> {
  int idx = 0;
  final pages = [const DashboardPage(), const AnalysisPage(), const TradeSetupPage(), const HistoryPage(), const SettingsPage()];
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

// DASHBOARD
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _Wrap(title: 'GoldMind AI', children: [
      _Card(children: [
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
        const _AIBox(text: 'Trend is uptrend on H4 and H4. Price holding above EMA 50 & 200. Look for buy opportunities on pullbacks.'),
      ]),
    ]);
  }
}

// ANALYSIS
class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _Wrap(title: 'Market Analysis', children: [
      _Tabs(),
      const SizedBox(height: 12),
      _Card(children: [
        _Row2('Trend', '▲ Uptrend', Colors.green),
        _Row2('EMA 50', '2,473.21'),
        _Row2('EMA 200', '2,451.87'),
        _Row2('RSI (14)', '62.4 (Neutral)'),
        _Row2('ATR (14)', '18.7'),
        const Divider(),
        const Text('Key Levels', style: TextStyle(fontWeight: FontWeight.bold)),
        _Row2('Resistance 1', '2,505.00'),
        _Row2('Resistance 2', '2,520.00'),
        _Row2('Support 1', '2,470.00'),
        _Row2('Support 2', '2,455.00'),
      ]),
      _Card(children: [
        const Text('Technical Summary', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Price is above EMA 50 & 200. RSI is healthy and trending up. Look for buy setups on pullbacks to 2,470 - 2,480.', style: TextStyle(color: Colors.grey, fontSize: 13)),
      ]),
    ]);
  }
}

// TRADE SETUP
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
      return _Wrap(title: 'Active Trades', children: [
        _Card(color: const Color(0xFF1A2E1F), children: [
          Row(children: [const Icon(Icons.monetization_on, color: Color(0xFFC9A86A)), const SizedBox(width: 8), const Text('XAUUSD BUY 0.10 lot', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)), child: const Text('LIVE', style: TextStyle(fontSize: 10)))]),
          const SizedBox(height: 12),
          _Row2('Entry', '2,486.50'), _Row2('SL', '2,473.00'), _Row2('TP', '2,503.00'), _Row2('Current', '2,491.32'),
          const SizedBox(height: 6),
          const Text('+58.20 USD (+0.39%)', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: 0.6, color: Colors.green, backgroundColor: Colors.white10),
        ]),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: FilledButton(style: FilledButton.styleFrom(backgroundColor: Colors.white10), onPressed: () => setState(() => isActive = false), child: const Text('Close Trade'))),
        _Card(children: [
          const Text('Account Balance (Paper)'),
          const Text('10,000.00 USD', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('+48.20 USD', style: TextStyle(color: Colors.green)),
        ])
      ]);
    }
    return _Wrap(title: 'Trade Signal', children: [
      _Card(color: const Color(0xFF1A2E1F), children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)), child: const Row(children: [Icon(Icons.trending_up, color: Colors.white), SizedBox(width: 8), Text('BUY SETUP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])),
        const SizedBox(height: 12),
        _Row2('Entry Price', '2,486.50'), _Row2('Stop Loss (SL)', '2,473.00'), _Row2('Take Profit (TP1)', '2,503.00'), _Row2('Take Profit (TP2)', '2,520.00'),
        const Divider(),
        _Row2('Risk : Reward', '1 : 2.3'), _Row2('Position Size (Paper)', '0.10 lot'),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: FilledButton(style: FilledButton.styleFrom(backgroundColor: const Color(0xFF00C853)), onPressed: () => setState(() => isActive = true), child: const Text('Place Paper Trade'))),
      ]),
      _Card(children: [
        const Text('Reasoning', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('• Price above EMA 50 & 200\n• RSI turning up from 50\n• Strong support at 2,470', style: TextStyle(color: Colors.grey, fontSize: 13)),
      ]),
    ]);
  }
}

// HISTORY + INSIGHTS + MARKET + SETTINGS
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _Wrap(title: 'Trade History', children: [
      _Card(children: [
        _Hist('XAUUSD BUY', '+48.20', true), _Hist('XAUUSD SELL', '+32.10', true),
        _Hist('XAUUSD BUY', '-18.50', false), _Hist('XAUUSD SELL', '+67.40', true),
      ]),
      _Card(children: [
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

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _Wrap(title: 'Settings', children: [
      _Card(children: [
        _SetTile(Icons.swap_horiz, 'Trading Mode', 'Paper Trading'),
        _SetTile(Icons.percent, 'Risk Per Trade', '1%'),
        _SetTile(Icons.layers, 'Lot Size', '0.10'),
        _SetTile(Icons.notifications, 'Notifications', 'On'),
        _SetTile(Icons.dark_mode, 'Theme', 'Dark'),
        _SetTile(Icons.language, 'Language', 'English'),
        _SetTile(Icons.cable, 'MTS Connection', 'Not Connected', isError: true),
      ]),
      SizedBox(width: double.infinity, child: FilledButton(onPressed: () {}, child: const Text('Connect MT5'))),
      const SizedBox(height: 20),
      _Card(children: [
        Center(child: Column(children: [
          Container(width: 60, height: 60, decoration: BoxDecoration(color: const Color(0xFFC9A86A), borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.trending_up, color: Colors.black)),
          const SizedBox(height: 8),
          const Text('GoldMind AI v0.1'),
          const Text('Smarter Analysis. Better Trades.', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 10),
          const Text('✓ AI Market Analysis\n✓ Multi-Timeframe (H4/H1/M15)\n✓ EMA 50/200 + RSI + ATR\n✓ Support & Resistance\n✓ Auto Trade Execution (Paper)\n✓ Trade History & Performance', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ]))
      ])
    ]);
  }
}

// WIDGETS
class _Wrap extends StatelessWidget {
  final String title; final List<Widget> children;
  const _Wrap({required this.title, required this.children});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title), backgroundColor: const Color(0xFF0A1218)), body: ListView(padding: const EdgeInsets.all(16), children: children));
  }
}
class _Card extends StatelessWidget {
  final List<Widget> children; final Color? color;
  const _Card({required this.children, this.color});
  @override
  Widget build(BuildContext context) => Card(color: color, margin: const EdgeInsets.only(bottom: 12), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children)));
}
class _Row2 extends StatelessWidget {
  final String a, b; final Color? col;
  const _Row2(this.a, this.b, [this.col]);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(a, style: const TextStyle(color: Colors.grey, fontSize: 13)), Text(b, style: TextStyle(color: col, fontWeight: FontWeight.bold, fontSize: 13))]));
}
class _Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(children: [ _Tab('H4', true), _Tab('H1', false), _Tab('M15', false)]);
}
class _Tab extends StatelessWidget {
  final String t; final bool sel;
  const _Tab(this.t, this.sel);
  @override
  Widget build(BuildContext context) => Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), decoration: BoxDecoration(color: sel? const Color(0xFFC9A86A) : Colors.white10, borderRadius: BorderRadius.circular(20)), child: Text(t, style: TextStyle(color: sel? Colors.black : Colors.white, fontSize: 12)));
}
class _AIBox extends StatelessWidget {
  final String text; const _AIBox({required this.text});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFC9A86A).withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFC9A86A).withOpacity(0.3))), child: Row(children: [const Icon(Icons.auto_awesome, color: Color(0xFFC9A86A), size: 16), const SizedBox(width: 8), Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)))]));
}
class _Hist extends StatelessWidget {
  final String pair, pnl; final bool profit;
  const _Hist(this.pair, this.pnl, this.profit);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(pair, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), const Text('Aug 15, 2025', style: TextStyle(color: Colors.grey, fontSize: 10))]), Text(pnl, style: TextStyle(color: profit? Colors.green : Colors.red, fontWeight: FontWeight.bold))])),
}
class _SetTile extends StatelessWidget {
  final IconData icon; final String t, v; final bool isError;
  const _SetTile(this.icon, this.t, this.v, {this.isError = false});
  @override
  Widget build(BuildContext context) => ListTile(leading: Icon(icon, color: Colors.grey), title: Text(t, style: const TextStyle(fontSize: 14)), trailing: Text(v, style: TextStyle(fontSize: 12, color: isError? Colors.red : const Color(0xFFC9A86A))), contentPadding: EdgeInsets.zero);
}
class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.green..strokeWidth = 2..style = PaintingStyle.stroke;
    final path = Path(); path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.2, size.height * 0.6); path.lineTo(size.width * 0.4, size.height * 0.65);
    path.lineTo(size.width * 0.6, size.height * 0.4); path.lineTo(size.width * 0.8, size.height * 0.3);
    path.lineTo(size.width, size.height * 0.2); canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
