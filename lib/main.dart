import 'package:flutter/material.dart';

void main() {
  runApp(const GoldMindApp());
}

const gold = Color(0xFFFFC857);
const bg = Color(0xFF0B0F14);
const panel = Color(0xFF141A22);
const panel2 = Color(0xFF1C2530);
const green = Color(0xFF35D07F);
const red = Color(0xFFFF6B6B);
const muted = Color(0xFF9AA5B1);

class GoldMindApp extends StatelessWidget {
  const GoldMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoldMind AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(primary: gold),
        useMaterial3: true,
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final pages = const [
    DashboardPage(),
    AnalysisPage(),
    TradePage(),
    HistoryPage(),
    SettingsPage(),
  ];

  final labels = const ['Home','Analysis','Trade','History','Settings'];
  final icons = const [
    Icons.home_outlined,
    Icons.analytics_outlined,
    Icons.candlestick_chart,
    Icons.history,
    Icons.settings_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        indicatorColor: gold.withOpacity(.18),
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: List.generate(labels.length, (i) =>
          NavigationDestination(icon: Icon(icons[i]), label: labels[i])),
      ),
    );
  }
}

class PageWrap extends StatelessWidget {
  final String title;
  final Widget child;
  const PageWrap({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Icon(Icons.auto_graph, color: gold),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
        const Spacer(),
        const Icon(Icons.notifications_none, color: muted),
      ]),
      const SizedBox(height: 16),
      Expanded(child: child),
    ]),
  );
}

class CardBox extends StatelessWidget {
  final Widget child;
  const CardBox({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: panel,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.white.withOpacity(.06)),
    ),
    child: child,
  );
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) => PageWrap(
    title: 'GoldMind AI',
    child: ListView(children: [
      CardBox(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('XAUUSD', style: TextStyle(color: muted, fontSize: 15)),
        const SizedBox(height: 6),
        const Text('\$2,491.32', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        const Text('+12.46 (+0.50%)', style: TextStyle(color: green, fontWeight: FontWeight.bold)),
        const SizedBox(height: 18),
        Container(height: 115, decoration: BoxDecoration(
          color: panel2, borderRadius: BorderRadius.circular(12)),
          child: const Center(child: Icon(Icons.show_chart, color: gold, size: 72))),
      ])),
      const SizedBox(height: 14),
      const Text('MARKET BIAS', style: TextStyle(color: muted, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      CardBox(child: Row(children: [
        const Icon(Icons.trending_up, color: green, size: 36),
        const SizedBox(width: 12),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('BULLISH', style: TextStyle(fontSize: 21, color: green, fontWeight: FontWeight.w900)),
          Text('Higher timeframe trend is positive', style: TextStyle(color: muted)),
        ])),
      ])),
      const SizedBox(height: 14),
      const Text('MULTI-TIMEFRAME', style: TextStyle(color: muted, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Row(children: [
        Expanded(child: TrendTile('H4','BULLISH',green)),
        SizedBox(width: 8),
        Expanded(child: TrendTile('H1','BULLISH',green)),
        SizedBox(width: 8),
        Expanded(child: TrendTile('M15','PULLBACK',gold)),
      ]),
      const SizedBox(height: 14),
      CardBox(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          Icon(Icons.psychology, color: gold),
          SizedBox(width: 8),
          Text('AI MARKET INSIGHT', style: TextStyle(fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 10),
        const Text('Trend is bullish on H4 and H1. Price is near a pullback area. Wait for confirmation before a paper setup.'),
      ])),
    ]),
  );
}

class TrendTile extends StatelessWidget {
  final String tf, value;
  final Color color;
  const TrendTile(this.tf,this.value,this.color,{super.key});
  @override
  Widget build(BuildContext context) => CardBox(child: Column(children: [
    Text(tf, style: const TextStyle(color: muted)),
    const SizedBox(height: 6),
    Text(value, textAlign: TextAlign.center, style: TextStyle(fontSize: 12,color: color,fontWeight: FontWeight.bold)),
  ]));
}

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});
  @override
  Widget build(BuildContext context) => PageWrap(
    title: 'Market Analysis',
    child: ListView(children: [
      const SectionTitle('TECHNICAL INDICATORS'),
      const SizedBox(height: 8),
      const CardBox(child: Column(children: [
        MetricRow('EMA 50','2,473.21','UPTREND',green),
        Divider(color: Colors.white12),
        MetricRow('EMA 200','2,451.87','UPTREND',green),
        Divider(color: Colors.white12),
        MetricRow('RSI (14)','62.4','NEUTRAL',gold),
        Divider(color: Colors.white12),
        MetricRow('ATR (14)','18.7','VOLATILITY',muted),
      ])),
      const SizedBox(height: 14),
      const SectionTitle('KEY LEVELS'),
      const SizedBox(height: 8),
      const CardBox(child: Column(children: [
        MetricRow('Resistance 1','2,505.00','',red),
        Divider(color: Colors.white12),
        MetricRow('Resistance 2','2,520.00','',red),
        Divider(color: Colors.white12),
        MetricRow('Support 1','2,470.00','',green),
        Divider(color: Colors.white12),
        MetricRow('Support 2','2,455.00','',green),
      ])),
      const SizedBox(height: 14),
      CardBox(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('TECHNICAL SUMMARY', style: TextStyle(color: gold,fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text('Price remains above EMA 50 and EMA 200. Momentum is positive, while RSI is not yet at an extreme level.'),
      ])),
    ]),
  );
}

class MetricRow extends StatelessWidget {
  final String a,b,c; final Color color;
  const MetricRow(this.a,this.b,this.c,this.color,{super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(children: [
      Expanded(child: Text(a, style: const TextStyle(color: muted))),
      Text(b, style: const TextStyle(fontWeight: FontWeight.bold)),
      if(c.isNotEmpty) ...[const SizedBox(width: 8), Text(c, style: TextStyle(color: color,fontSize: 11,fontWeight: FontWeight.bold))],
    ]),
  );
}

class TradePage extends StatefulWidget {
  const TradePage({super.key});
  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  bool paperOpen=false;
  @override
  Widget build(BuildContext context) => PageWrap(
    title: 'Trade Setup',
    child: ListView(children: [
      CardBox(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.arrow_upward, color: green),
          const SizedBox(width: 8),
          Text('BUY SETUP', style: TextStyle(color: green,fontWeight: FontWeight.w900,fontSize: 22)),
          const Spacer(),
          const Text('PAPER', style: TextStyle(color: gold,fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 14),
        const SetupRow('Entry Price','2,486.50'),
        const SetupRow('Stop Loss (SL)','2,473.00', red),
        const SetupRow('Take Profit (TP)','2,503.00', green),
        const SetupRow('Risk : Reward','1 : 2.3', gold),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, child: FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: paperOpen?panel2:green,foregroundColor: Colors.black,padding: const EdgeInsets.all(15)),
          onPressed: ()=>setState(()=>paperOpen=!paperOpen),
          icon: Icon(paperOpen?Icons.close:Icons.play_arrow),
          label: Text(paperOpen?'CLOSE PAPER TRADE':'OPEN PAPER TRADE'),
        )),
      ])),
      const SizedBox(height: 14),
      CardBox(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('AI REASONING', style: TextStyle(color: gold,fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text('• H4 and H1 trends are bullish\n• Price remains above major moving averages\n• Recent pullback is near support\n• Stop is below the invalidation zone'),
      ])),
      const SizedBox(height: 12),
      const Text('Demo only. This screen does not connect to a broker.', style: TextStyle(color: muted,fontSize: 12)),
    ]),
  );
}

class SetupRow extends StatelessWidget {
  final String a,b; final Color? color;
  const SetupRow(this.a,this.b,[this.color],{super.key});
  @override
  Widget build(BuildContext context)=>Padding(
    padding: const EdgeInsets.symmetric(vertical: 9),
    child: Row(children:[Text(a,style:const TextStyle(color:muted)),const Spacer(),Text(b,style:TextStyle(color:color??Colors.white,fontWeight:FontWeight.bold))]));
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context)=>PageWrap(
    title:'Trade History',
    child:ListView(children:[
      CardBox(child: Column(children:[
        const Row(children:[
          Expanded(child: Stat('Trades','12')),
          Expanded(child: Stat('Wins','7')),
          Expanded(child: Stat('P/L','+\$48.20',green)),
        ]),
        const SizedBox(height: 12),
        Divider(color: Colors.white12),
        ...const [
          HistoryRow('XAUUSD','BUY','+\$48.20',green),
          HistoryRow('XAUUSD','SELL','+\$32.10',green),
          HistoryRow('XAUUSD','BUY','-\$18.50',red),
          HistoryRow('XAUUSD','SELL','+\$67.40',green),
          HistoryRow('XAUUSD','BUY','-\$12.30',red),
        ]
      ]))
    ])
  );
}

class Stat extends StatelessWidget {
  final String a,b; final Color? color;
  const Stat(this.a,this.b,[this.color],{super.key});
  @override
  Widget build(BuildContext context)=>Column(children:[Text(a,style:const TextStyle(color:muted,fontSize:12)),const SizedBox(height:5),Text(b,style:TextStyle(fontWeight:FontWeight.bold,color:color))]);
}

class HistoryRow extends StatelessWidget {
  final String symbol,type,pnl; final Color color;
  const HistoryRow(this.symbol,this.type,this.pnl,this.color,{super.key});
  @override
  Widget build(BuildContext context)=>Padding(
    padding:const EdgeInsets.symmetric(vertical:11),
    child:Row(children:[
      const CircleAvatar(radius:16,backgroundColor:panel2,child:Icon(Icons.monetization_on,color:gold,size:17)),
      const SizedBox(width:10),
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(symbol,style:const TextStyle(fontWeight:FontWeight.bold)),Text('Paper trade',style:const TextStyle(color:muted,fontSize:12))])),
      Column(crossAxisAlignment:CrossAxisAlignment.end,children:[Text(type,style:TextStyle(color:type=='BUY'?green:red,fontWeight:FontWeight.bold)),Text(pnl,style:TextStyle(color:color,fontWeight:FontWeight.bold))])
    ]));
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState()=>_SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  bool notifications=true;
  @override
  Widget build(BuildContext context)=>PageWrap(
    title:'Settings',
    child:ListView(children:[
      CardBox(child:Column(children:[
        ListTile(leading:const Icon(Icons.shield_outlined,color:gold),title:const Text('Trading Mode'),subtitle:const Text('Paper Trading'),trailing:const Icon(Icons.chevron_right)),
        const Divider(color:Colors.white12),
        ListTile(leading:const Icon(Icons.percent,color:gold),title:const Text('Risk Per Trade'),subtitle:const Text('Demo setting: 1%'),trailing:const Icon(Icons.chevron_right)),
        const Divider(color:Colors.white12),
        SwitchListTile(value:notifications,onChanged:(v)=>setState(()=>notifications=v),title:const Text('Notifications'),secondary:const Icon(Icons.notifications,color:gold)),
        const Divider(color:Colors.white12),
        const ListTile(leading:Icon(Icons.link,color:gold),title:Text('MT5 Connection'),subtitle:Text('Not connected — planned integration')),
      ])),
      const SizedBox(height:14),
      CardBox(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        const Text('ABOUT',style:TextStyle(color:gold,fontWeight:FontWeight.bold)),
        const SizedBox(height:8),
        const Text('GoldMind AI v0.1'),
        const SizedBox(height:6),
        const Text('XAUUSD paper analysis prototype',style:TextStyle(color:muted)),
      ]))
    ])
  );
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text,{super.key});
  @override
  Widget build(BuildContext context)=>Text(text,style:const TextStyle(color:muted,fontWeight:FontWeight.bold,fontSize:12));
}
