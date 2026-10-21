import 'package:web/web.dart' as web;

import 'package:flutter/material.dart';

void main() => runApp(const PortfolioApp());

const ink = Color(0xFF101828);
const muted = Color(0xFF667085);
const violet = Color(0xFF7758F5);
const canvas = Color(0xFFF7F7FB);
final _projectsKey = GlobalKey();
final _aboutKey = GlobalKey();
final _contactKey = GlobalKey();

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Portfólio | Seu Nome',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: canvas,
          colorScheme: ColorScheme.fromSeed(seedColor: violet),
          fontFamily: 'Arial',
        ),
        home: const PortfolioPage(),
      );
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 760;
    return Scaffold(
      body: SelectionArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _nav(context, compact)),
            SliverToBoxAdapter(child: _hero(context, compact)),
            SliverToBoxAdapter(key: _projectsKey, child: _projectVisual(context, compact)),
            SliverToBoxAdapter(key: _aboutKey, child: _content(context, compact)),
            SliverToBoxAdapter(key: _contactKey, child: _footer(context, compact)),
          ],
        ),
      ),
    );
  }

  Widget _nav(BuildContext context, bool compact) => Container(
        decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFE9EAF0)))),
        padding: EdgeInsets.symmetric(horizontal: compact ? 22 : 72, vertical: 19),
        child: Row(children: [
          Container(width: 34, height: 34, decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(11)), child: const Icon(Icons.code_rounded, color: Colors.white, size: 20)),
          const SizedBox(width: 11),
          const Text('SEU NOME', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.1, color: ink)),
          const Spacer(),
          if (!compact) ...[
            _navLink('Projetos', _projectsKey),
            _navLink('Sobre', _aboutKey),
            _navLink('Contato', _contactKey),
          ] else const Text('PORTFÓLIO', style: TextStyle(fontSize: 11, color: muted, letterSpacing: 1.5, fontWeight: FontWeight.w700)),
        ]),
      );

  Widget _navLink(String text, GlobalKey key) => Padding(
        padding: const EdgeInsets.only(left: 28),
        child: TextButton(onPressed: () => _scrollTo(key), child: Text(text, style: const TextStyle(color: muted, fontWeight: FontWeight.w600))),
      );

  Widget _hero(BuildContext context, bool compact) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Padding(
            padding: EdgeInsets.fromLTRB(compact ? 22 : 30, compact ? 54 : 76, compact ? 22 : 30, 25),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(spacing: 8, runSpacing: 8, children: const [
                _Tag('FRONT-END'), _Tag('FLUTTER'), _Tag('OUT 2026', pale: true),
              ]),
              const SizedBox(height: 25),
              Text('Dashboard de e-commerce\nem tempo real', style: TextStyle(fontSize: compact ? 36 : 58, height: 1.08, letterSpacing: -2.5, fontWeight: FontWeight.w800, color: ink)),
              const SizedBox(height: 18),
              ConstrainedBox(constraints: const BoxConstraints(maxWidth: 760), child: const Text('Uma experiência web para acompanhar vendas, pedidos e desempenho da loja em um só lugar — com foco em clareza, velocidade e decisões melhores.', style: TextStyle(fontSize: 17, height: 1.65, color: muted))),
              const SizedBox(height: 25),
              Wrap(spacing: 12, runSpacing: 12, children: [
                _action('Ver código no GitHub', Icons.north_east_rounded, dark: true, onTap: () => web.window.open('https://github.com/SEU-USUARIO/SEU-REPOSITORIO', '_blank')),
                _action('Conhecer o projeto', Icons.arrow_downward_rounded, onTap: () => _scrollTo(_projectsKey)),
              ]),
            ]),
          ),
        ),
      );

  Widget _projectVisual(BuildContext context, bool compact) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: compact ? 20 : 30, vertical: 22),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(compact ? 17 : 30),
              decoration: BoxDecoration(color: const Color(0xFF17152B), borderRadius: BorderRadius.circular(24), boxShadow: const [BoxShadow(color: Color(0x1A24204A), blurRadius: 35, offset: Offset(0, 16))]),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [const _Dot(Color(0xFFFF6B72)), SizedBox(width: 7), const _Dot(Color(0xFFFFC857)), SizedBox(width: 7), const _Dot(Color(0xFF57D6A0)), const Spacer(), const Text('LOJA / VISÃO GERAL', style: TextStyle(color: Color(0xFFAAA6C4), fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.w700))]),
                const SizedBox(height: 25),
                Wrap(alignment: WrapAlignment.spaceBetween, runSpacing: 15, children: [
                  const Text('Visão geral', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7), decoration: BoxDecoration(color: const Color(0xFF28243F), borderRadius: BorderRadius.circular(9)), child: const Text('●  Atualizado agora', style: TextStyle(color: Color(0xFF68E0B2), fontSize: 11))),
                ]),
                const SizedBox(height: 18),
                LayoutBuilder(builder: (context, box) {
                  final cols = box.maxWidth < 600 ? 2 : 4;
                  final cardWidth = (box.maxWidth - (cols - 1) * 12) / cols;
                  return Wrap(spacing: 12, runSpacing: 12, children: [
                    _metric('Vendas totais', 'R\$ 48.295', '+12,8%', cardWidth),
                    _metric('Pedidos', '1.284', '+8,2%', cardWidth),
                    _metric('Ticket médio', 'R\$ 186,40', '+4,1%', cardWidth),
                    _metric('Conversão', '3,64%', '+0,6%', cardWidth),
                  ]);
                }),
                const SizedBox(height: 17),
                Container(height: compact ? 138 : 190, width: double.infinity, padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: const Color(0xFF211E39), borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Receita ao longo do tempo', style: TextStyle(color: Color(0xFFC9C5DD), fontSize: 12)), const Spacer(), SizedBox(height: compact ? 65 : 110, child: CustomPaint(painter: _ChartPainter(), child: const SizedBox.expand()))])),
              ]),
            ),
          ),
        ),
      );

  Widget _content(BuildContext context, bool compact) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Padding(
            padding: EdgeInsets.fromLTRB(compact ? 22 : 30, 44, compact ? 22 : 30, 48),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('DO DESAFIO À SOLUÇÃO', style: TextStyle(color: violet, fontSize: 11, letterSpacing: 1.7, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Text('Dados importantes,\nsem complicação.', style: TextStyle(color: ink, fontSize: compact ? 30 : 40, height: 1.12, letterSpacing: -1.2, fontWeight: FontWeight.w800)),
              const SizedBox(height: 25),
              LayoutBuilder(builder: (context, box) {
                final stacked = box.maxWidth < 700;
                final cards = [
                  _infoCard(Icons.bolt_rounded, 'O desafio', 'Lojistas precisavam acompanhar as vendas e os pedidos sem atualizar a página manualmente, perdendo tempo e oportunidades.'),
                  _infoCard(Icons.auto_awesome_rounded, 'A solução', 'Um painel responsivo com indicadores fáceis de ler, visualização de tendências e uma experiência pensada para consulta rápida.'),
                ];
                return stacked ? Column(children: [cards[0], const SizedBox(height: 14), cards[1]]) : Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Expanded(child: cards[0]), const SizedBox(width: 14), Expanded(child: cards[1])]);
              }),
              const SizedBox(height: 42),
              const Text('TECNOLOGIAS', style: TextStyle(color: violet, fontSize: 11, letterSpacing: 1.7, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              Wrap(spacing: 10, runSpacing: 10, children: const [_Tech('Flutter'), _Tech('Dart'), _Tech('Material 3'), _Tech('GitHub Pages')]),
              const SizedBox(height: 42),
              const Text('O QUE FAZ A DIFERENÇA', style: TextStyle(color: violet, fontSize: 11, letterSpacing: 1.7, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              LayoutBuilder(builder: (context, box) {
                final n = box.maxWidth < 600 ? 1 : 3;
                final w = (box.maxWidth - 14 * (n - 1)) / n;
                return Wrap(spacing: 14, runSpacing: 14, children: [
                  _feature(Icons.devices_rounded, 'UI responsiva', 'Layout adaptável para celular, tablet e desktop.', w),
                  _feature(Icons.query_stats_rounded, 'Indicadores visuais', 'Métricas e tendências apresentadas com clareza.', w),
                  _feature(Icons.speed_rounded, 'Navegação simples', 'Informação organizada para encontrar o essencial rápido.', w),
                ]);
              }),
              const SizedBox(height: 42),
              Container(width: double.infinity, padding: EdgeInsets.all(compact ? 20 : 28), decoration: BoxDecoration(color: const Color(0xFFEEECFF), borderRadius: BorderRadius.circular(20)), child: Wrap(spacing: 22, runSpacing: 14, children: const [
                SizedBox(width: 300, child: _Result('RESULTADO', 'Uma interface de demonstração pronta para apresentar conceitos de monitoramento de e-commerce.')),
                SizedBox(width: 300, child: _Result('APRENDIZADO', 'Prática com layout responsivo, componentes reutilizáveis e publicação de Flutter Web.')),
              ])),
            ]),
          ),
        ),
      );

  Widget _footer(BuildContext context, bool compact) => Container(
        color: ink,
        padding: EdgeInsets.symmetric(horizontal: compact ? 22 : 72, vertical: 38),
        child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1060), child: Wrap(alignment: WrapAlignment.spaceBetween, crossAxisAlignment: WrapCrossAlignment.center, runSpacing: 18, children: [
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('VAMOS CRIAR ALGO?', style: TextStyle(color: Color(0xFFB5A8FF), fontSize: 11, letterSpacing: 1.6, fontWeight: FontWeight.w800)), SizedBox(height: 9), Text('Disponível para novos desafios.', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w700))]),
          Wrap(spacing: 10, children: [_action('E-mail', Icons.mail_outline_rounded, onTap: () => web.window.open('mailto:SEU-EMAIL@EXEMPLO.COM', '_self')), _action('LinkedIn', Icons.open_in_new_rounded, onTap: () => web.window.open('https://www.linkedin.com/in/SEU-PERFIL/', '_blank'))]),
        ]))),
      );

  Widget _action(String label, IconData icon, {bool dark = false, required VoidCallback onTap}) => OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 17),
        label: Text(label),
        style: OutlinedButton.styleFrom(foregroundColor: dark ? Colors.white : ink, backgroundColor: dark ? ink : Colors.white, side: BorderSide(color: dark ? ink : const Color(0xFFE1E2E9)), padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      );

  Widget _metric(String label, String value, String change, double width) => Container(width: width, padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF211E39), borderRadius: BorderRadius.circular(13)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: Color(0xFFAAA6C4), fontSize: 10)), const SizedBox(height: 10), Text(value, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)), const SizedBox(height: 6), Text('↗ $change', style: const TextStyle(color: Color(0xFF68E0B2), fontSize: 10, fontWeight: FontWeight.w600))]));

  Widget _infoCard(IconData icon, String title, String body) => Container(width: double.infinity, padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE9EAF0))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: violet), const SizedBox(height: 13), Text(title, style: const TextStyle(color: ink, fontSize: 18, fontWeight: FontWeight.w800)), const SizedBox(height: 8), Text(body, style: const TextStyle(color: muted, height: 1.6))]));

  Widget _feature(IconData icon, String title, String body, double width) => Container(width: width, padding: const EdgeInsets.all(19), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFFE9EAF0))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFF0EDFF), borderRadius: BorderRadius.circular(11)), child: Icon(icon, color: violet)), const SizedBox(height: 15), Text(title, style: const TextStyle(color: ink, fontWeight: FontWeight.w800)), const SizedBox(height: 6), Text(body, style: const TextStyle(color: muted, height: 1.5, fontSize: 13))]));

  void _scrollTo(GlobalKey key) {
    final target = key.currentContext;
    if (target != null) { Scrollable.ensureVisible(target, duration: const Duration(milliseconds: 450), curve: Curves.easeInOut); }
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text, {this.pale = false});
  final String text;
  final bool pale;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7), decoration: BoxDecoration(color: pale ? const Color(0xFFEEECFF) : const Color(0xFFE9E6FF), borderRadius: BorderRadius.circular(7)), child: Text(text, style: const TextStyle(color: violet, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: .8)));
}

class _Tech extends StatelessWidget {
  const _Tech(this.label);
  final String label;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11), decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE3E4EC)), borderRadius: BorderRadius.circular(10)), child: Text(label, style: const TextStyle(color: ink, fontWeight: FontWeight.w700, fontSize: 13)));
}

class _Result extends StatelessWidget {
  const _Result(this.label, this.body);
  final String label, body;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: violet, fontWeight: FontWeight.w800, fontSize: 10, letterSpacing: 1.5)), const SizedBox(height: 8), Text(body, style: const TextStyle(color: ink, height: 1.55, fontWeight: FontWeight.w500))]);
}

class _Dot extends StatelessWidget {
  const _Dot(this.color);
  final Color color;
  @override
  Widget build(BuildContext context) => Container(width: 9, height: 9, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()..color = const Color(0xFF35314E)..strokeWidth = 1;
    for (var i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    final points = <Offset>[
      Offset(0, size.height * .76), Offset(size.width * .13, size.height * .62),
      Offset(size.width * .25, size.height * .68), Offset(size.width * .38, size.height * .40),
      Offset(size.width * .51, size.height * .50), Offset(size.width * .64, size.height * .28),
      Offset(size.width * .77, size.height * .37), Offset(size.width * .89, size.height * .13),
      Offset(size.width, size.height * .20),
    ];
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) { path.lineTo(points[i].dx, points[i].dy); }
    final fill = Path.from(path)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
    canvas.drawPath(fill, Paint()..shader = const LinearGradient(colors: [Color(0x667B62FF), Color(0x007B62FF)], begin: Alignment.topCenter, end: Alignment.bottomCenter).createShader(Offset.zero & size));
    canvas.drawPath(path, Paint()..color = const Color(0xFF9B87FF)..strokeWidth = 3..style = PaintingStyle.stroke..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
