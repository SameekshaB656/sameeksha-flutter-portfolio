import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyPortfolioApp());

const bg = Color(0xFF080B14);

const panel = Color(0xFF111827);

const panel2 = Color(0xFF151E30);

const cyan = Color(0xFF67E8F9);

const purple = Color(0xFFA78BFA);

const muted = Color(0xFF9AA8BD);

class MyPortfolioApp extends StatelessWidget {

   const MyPortfolioApp({super.key});

   @override

   Widget build(BuildContext context) => MaterialApp(

      title: 'My Portfolio | Sameeksha',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark, scaffoldBackgroundColor: bg,

         colorScheme: ColorScheme.fromSeed(seedColor: cyan, brightness: Brightness.dark),

         inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: panel2,

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),

            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF263248))),

            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: cyan))),

      ),

      home: const LoginPage(),

   );

}

class LoginPage extends StatefulWidget {

   const LoginPage({super.key});

   @override State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

   final rollController = TextEditingController();

   @override void dispose() { rollController.dispose(); super.dispose(); }

   void login() {

      if (rollController.text.trim().isEmpty) {

         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your roll number.'))); return;

      }

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => DashboardPage(rollNo: rollController.text.trim())));

   }

   @override Widget build(BuildContext context) {

      final wide = MediaQuery.sizeOf(context).width > 760;

      return Scaffold(body: Container(decoration: const BoxDecoration(gradient: RadialGradient(center: Alignment(-.8,-.8), radius: 1.5, colors: [Color(0xFF172342), bg, bg])),

         child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 980), child:

            Container(decoration: BoxDecoration(color: const Color(0xD9101726), borderRadius: BorderRadius.circular(28), border: Border.all(color: const Color(0xFF29364B)), boxShadow: [BoxShadow(color: cyan.withValues(alpha: .08), blurRadius: 50)]), child: Flex(direction: wide ? Axis.horizontal : Axis.vertical, children: [

               if (wide) Expanded(child: _loginWelcome()) else _loginWelcome(),

               Expanded(child: Padding(padding: const EdgeInsets.all(34), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

                  const Text('Sign in to my portfolio', style: TextStyle(fontSize: 30, height: 1.2, fontWeight: FontWeight.w800)),

                  const SizedBox(height: 28), const Text('Roll number', style: TextStyle(color: muted)), const SizedBox(height: 8),

                  TextField(controller: rollController, textInputAction: TextInputAction.done, onSubmitted: (_) => login(), decoration: const InputDecoration(prefixIcon: Icon(Icons.badge_outlined), hintText: 'Enter your roll number')),

                  const SizedBox(height: 24),

                  SizedBox(height: 52, child: FilledButton.icon(onPressed: login, icon: const Icon(Icons.arrow_forward_rounded), label: const Text('Open my portfolio'), style: FilledButton.styleFrom(backgroundColor: cyan, foregroundColor: bg, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), textStyle: const TextStyle(fontWeight: FontWeight.bold)))),

                  const SizedBox(height: 16), const Text('Enter your roll number to continue.', style: TextStyle(color: muted, fontSize: 12)),

               ])))

            ]))

         )))));

   }

   Widget _loginWelcome() => Container(padding: const EdgeInsets.all(36), child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [

      Container(width: 58, height: 58, decoration: BoxDecoration(gradient: const LinearGradient(colors: [cyan, purple]), borderRadius: BorderRadius.circular(18)), child: const Icon(Icons.auto_awesome_rounded, color: bg, size: 30)),

      const SizedBox(height: 28), const Text('MY PORTFOLIO', style: TextStyle(color: cyan, letterSpacing: 4, fontSize: 12, fontWeight: FontWeight.bold)),

      const SizedBox(height: 12), const Text('A little about\nmy journey.', style: TextStyle(fontSize: 40, height: 1.12, fontWeight: FontWeight.w900)),

      const SizedBox(height: 18), const Text('Learning, building, and turning ideas into useful digital experiences.', style: TextStyle(color: muted, fontSize: 15, height: 1.7)),

      const SizedBox(height: 30), CircleAvatar(radius: 38, backgroundColor: const Color(0xFF26364A), child: ClipOval(child: Image.asset('assets/profile.jpeg', width: 76, height: 76, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Center(child: Text('SB', style: TextStyle(fontSize: 25, color: cyan, fontWeight: FontWeight.bold)))))),

      const SizedBox(height: 12), const Text('Sameeksha Badugu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Text('Computer Science & Engineering', style: TextStyle(color: muted, fontSize: 12)),

   ]));

}

class DashboardPage extends StatefulWidget {

   final String rollNo;

   const DashboardPage({super.key, required this.rollNo});

   @override State<DashboardPage> createState() => _DashboardPageState();

}

class _DashboardPageState extends State<DashboardPage> {

   int selected = 0;

   final PageController achievementController = PageController();

   Timer? timer;

   int achievementIndex = 0;

   final sections = const [

      ('Overview', Icons.grid_view_rounded), ('Academics', Icons.school_outlined), ('Certifications', Icons.workspace_premium_outlined), ('Activities', Icons.emoji_events_outlined), ('Achievements', Icons.auto_awesome_outlined),

   ];

   @override void initState() { super.initState(); timer = Timer.periodic(const Duration(seconds: 5), (_) { if (!mounted) return; achievementIndex = (achievementIndex + 1) % 4; if (achievementController.hasClients) achievementController.animateToPage(achievementIndex, duration: const Duration(milliseconds: 550), curve: Curves.easeInOut); }); }

   @override void dispose() { timer?.cancel(); achievementController.dispose(); super.dispose(); }

   @override Widget build(BuildContext context) {

      final width = MediaQuery.sizeOf(context).width;

      final compact = width < 720;

      return Scaffold(body: Row(children: [

         if (!compact) Container(width: 238, decoration: const BoxDecoration(color: Color(0xFF0D1320), border: Border(right: BorderSide(color: Color(0xFF202B3D)))), child: _sidebar()),

         Expanded(child: Column(children: [

            Container(height: 76, padding: const EdgeInsets.symmetric(horizontal: 22), decoration: const BoxDecoration(color: Color(0xCC0D1320), border: Border(bottom: BorderSide(color: Color(0xFF202B3D)))), child: Row(children: [

               if (compact) IconButton(onPressed: () => showModalBottomSheet(context: context, backgroundColor: panel, builder: (_) => _mobileMenu()), icon: const Icon(Icons.menu_rounded)),

               Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(sections[selected].$1, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19)), const Text('Your learning journey, in one place', style: TextStyle(color: muted, fontSize: 12))])),

               CircleAvatar(backgroundColor: const Color(0xFF26364A), child: ClipOval(child: Image.asset('assets/profile.jpeg', width: 40, height: 40, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Center(child: Text('SB', style: TextStyle(color: cyan, fontWeight: FontWeight.bold)))))),

            ])),

            Expanded(child: SingleChildScrollView(padding: EdgeInsets.all(compact ? 16 : 30), child: _content(compact))),

         ]))

      ]));

   }

   Widget _sidebar() => Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Row(children: [Container(width: 38, height: 38, decoration: BoxDecoration(gradient: const LinearGradient(colors: [cyan,purple]), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.auto_awesome, color: bg)), const SizedBox(width: 11), const Text('My Portfolio', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17))]),

      const SizedBox(height: 34), const Text('WORKSPACE', style: TextStyle(color: muted, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)), const SizedBox(height: 12),

      ...List.generate(sections.length, (i) => _navItem(i)), const Spacer(),

      Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF263248))), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.lightbulb_outline, color: cyan), SizedBox(height: 10), Text('Keep building.', style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 4), Text('Every project is progress.', style: TextStyle(color: muted, fontSize: 11))])),

      const SizedBox(height: 14), ListTile(leading: const Icon(Icons.logout_rounded, color: Color(0xFFFCA5A5)), title: const Text('Logout', style: TextStyle(color: Color(0xFFFCA5A5))), contentPadding: const EdgeInsets.symmetric(horizontal: 10), onTap: _logout),

   ]));

   Widget _navItem(int i) => Padding(padding: const EdgeInsets.only(bottom: 6), child: InkWell(borderRadius: BorderRadius.circular(12), onTap: () => setState(() => selected = i), child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13), decoration: BoxDecoration(color: selected == i ? const Color(0xFF1A2B3E) : Colors.transparent, borderRadius: BorderRadius.circular(12), border: Border.all(color: selected == i ? const Color(0xFF2C5261) : Colors.transparent)), child: Row(children: [Icon(sections[i].$2, size: 19, color: selected == i ? cyan : muted), const SizedBox(width: 12), Text(sections[i].$1, style: TextStyle(color: selected == i ? Colors.white : muted, fontWeight: selected == i ? FontWeight.bold : FontWeight.normal)), if (selected == i) const Spacer(), if (selected == i) const Icon(Icons.chevron_right, size: 17, color: cyan)]))));

   Widget _mobileMenu() => SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, children: [...List.generate(sections.length, (i) => ListTile(leading: Icon(sections[i].$2, color: selected == i ? cyan : muted), title: Text(sections[i].$1), onTap: () { setState(() => selected = i); Navigator.pop(context); })), ListTile(leading: const Icon(Icons.logout, color: Colors.redAccent), title: const Text('Logout'), onTap: () { Navigator.pop(context); _logout(); })])));

   void _logout() => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false);

   Widget _content(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      if (selected == 0) ..._overview(compact),

      if (selected == 1) _academics(),

      if (selected == 2) _certifications(),

      if (selected == 3) _activities(),

      if (selected == 4) _achievements(compact),

      const SizedBox(height: 30), const Center(child: Text('Designed with Flutter Web   •   Sameeksha Badugu', style: TextStyle(color: Color(0xFF65748B), fontSize: 11))),

   ]);

   List<Widget> _overview(bool compact) => [

      Container(width: double.infinity, padding: const EdgeInsets.all(26), decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1C3550), Color(0xFF191B36), panel]), border: Border.all(color: const Color(0xFF30445D))), child: Wrap(alignment: WrapAlignment.spaceBetween, crossAxisAlignment: WrapCrossAlignment.center, spacing: 20, runSpacing: 20, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('HELLO, I’M', style: TextStyle(color: cyan, fontSize: 11, letterSpacing: 3, fontWeight: FontWeight.bold)), const SizedBox(height: 10), const Text('Sameeksha\nBadugu', style: TextStyle(fontSize: 36, height: 1.05, fontWeight: FontWeight.w900)), const SizedBox(height: 12), const SizedBox(width: 400, child: Text('Computer Science student • Aspiring Full Stack Developer', style: TextStyle(color: muted, height: 1.6))), const SizedBox(height: 18), Wrap(spacing: 10, children: [_pill('Java'), _pill('React.js'), _pill('SQL'), _pill('PySpark')])]), CircleAvatar(radius: 52, backgroundColor: const Color(0xFF27364C), child: ClipOval(child: Image.asset('assets/profile.jpeg', width: 104, height: 104, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Center(child: Text('SB', style: TextStyle(color: cyan, fontSize: 34, fontWeight: FontWeight.w900)))))) ])),

      const SizedBox(height: 24), _sectionTitle('At a glance', 'A few milestones from my journey'), const SizedBox(height: 14),

      GridView.count(crossAxisCount: compact ? 2 : 4, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: compact ? 1.4 : 1.55, children: [_stat('8.48 / 10','B.Tech CGPA',Icons.school_outlined,cyan), _stat('140+','LeetCode solved',Icons.code_rounded,purple), _stat('600+','CodeChef solved',Icons.terminal_rounded,cyan), _stat('4th place','TripPulse showcase',Icons.emoji_events_outlined,purple)]),

      const SizedBox(height: 26), _sectionTitle('Featured projects', 'Things I have been building'), const SizedBox(height: 14),

      _project('TripPulse — Urban Mobility Analytics', 'A Bronze–Silver–Gold data pipeline with data-quality checks and Power BI dashboards for trip operations, demand, surge patterns, and payment reliability.', 'Databricks   •   PySpark   •   SQL   •   Power BI', Icons.route_rounded, cyan, url: 'https://github.com/geethika626/bvrith-de-c1-team02-trippulse-urban-mobility-analytics'),

      _project('Password Breach & Strength Checker', 'A privacy-focused password checker using the k-anonymity model and Pwned Passwords API. The actual password is never transmitted.', 'HTML   •   CSS   •   JavaScript   •   API', Icons.shield_outlined, purple, url: 'https://github.com/SameekshaB656'),

      _project('To-Do Application', 'A responsive React application to add, edit, delete, and manage tasks with reusable components and state management.', 'React.js   •   JavaScript   •   CSS', Icons.check_circle_outline, cyan, url: 'https://github.com/SameekshaB656'),

      const SizedBox(height: 24), _sectionTitle('About me', 'Curious by nature. Consistent by choice.'), const SizedBox(height: 10), const Text('I am a Computer Science and Engineering student at BVRIT Hyderabad College of Engineering for Women. I enjoy solving algorithmic problems, building web applications, and exploring data engineering workflows.', style: TextStyle(color: muted, height: 1.8)),

      const SizedBox(height: 22), _sectionTitle('Connect', 'Let’s build something meaningful'), const SizedBox(height: 12), Wrap(spacing: 10, runSpacing: 10, children: [_linkChip('Email', 'sameeksha.badugu@gmail.com', Icons.mail_outline), _linkChip('GitHub', 'github.com/SameekshaB656', Icons.code), _linkChip('LinkedIn', 'linkedin.com/in/sameeksha-badugu/', Icons.work_outline)]),

   ];

   Widget _academics() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_sectionTitle('Academic details', 'Education at a glance'), const SizedBox(height: 16), Container(width: double.infinity, decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF263248))), child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(columns: const [DataColumn(label: Text('Course')), DataColumn(label: Text('Institution')), DataColumn(label: Text('Year')), DataColumn(label: Text('Result'))], rows: const [DataRow(cells: [DataCell(Text('B.Tech — CSE')), DataCell(Text('BVRIT Hyderabad College of Engineering for Women')), DataCell(Text('2024–2028')), DataCell(Text('8.48 / 10 CGPA'))]), DataRow(cells: [DataCell(Text('Intermediate')), DataCell(Text('Sri Chaitanya Junior College, Hyderabad')), DataCell(Text('2022–2024')), DataCell(Text('98.6%'))]), DataRow(cells: [DataCell(Text('SSC')), DataCell(Text('Dr. KKR’s Gowtham Concept School, Hyderabad')), DataCell(Text('2021–2022')), DataCell(Text('10 / 10 CGPA'))])])))]);

   Widget _certifications() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_sectionTitle('Course certifications', 'Skills I have invested in'), const SizedBox(height: 16), _project('Frontend Development', 'Infosys Springboard • Completed February 2026. Hands-on learning in HTML, CSS, and JavaScript.', 'HTML5   •   CSS3   •   JavaScript', Icons.workspace_premium_outlined, cyan), const SizedBox(height: 12), _sectionTitle('Technical skills', 'Tools and technologies'), const SizedBox(height: 12), Wrap(spacing: 10, runSpacing: 10, children: ['Java','Python','C','SQL','OOP','Data Structures','Algorithms','HTML5','CSS3','JavaScript','React.js','Node.js','MySQL','Git','GitHub','Tableau','Excel','Databricks','PySpark','Power BI'].map((s) => _pill(s)).toList())]);

   Widget _activities() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_sectionTitle('Extracurricular activities', 'Learning beyond the classroom'), const SizedBox(height: 16), _activity(Icons.groups_2_outlined, 'Class Representative', '2025 – Present', 'Supporting class communication and coordination.'), _activity(Icons.code_rounded, 'Competitive Programming', 'Ongoing', 'Solved 140+ problems on LeetCode and 600+ on CodeChef.'), _activity(Icons.lightbulb_outline, 'Smart India Hackathon', 'September 2025', 'Qualified for the second round of the national-level hackathon.'), _activity(Icons.laptop_chromebook_outlined, 'Google Big Code', 'March 2026', 'Participated in Google’s coding competition.'), _activity(Icons.analytics_outlined, 'Data Engineering Training', '2026', 'Worked on TripPulse, an urban mobility analytics platform.')]);

Widget _achievements(bool compact) {

   return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

         _sectionTitle(

            'Achievements',

            'Small wins. Steady progress.',

         ),

         const SizedBox(height: 16),

         Container(

            height: compact ? 310 : 350,

            decoration: BoxDecoration(

               borderRadius: BorderRadius.circular(22),

               gradient: const LinearGradient(

                  colors: [

                     Color(0xFF19364A),

                     Color(0xFF262044),

                  ],

               ),

               border: Border.all(

                  color: const Color(0xFF34465F),

               ),

            ),

            child: PageView(

               controller: achievementController,

               onPageChanged: (i) {

                  setState(() => achievementIndex = i);

               },

               children: [

                  _achievementSlide(

                     Icons.emoji_events_rounded,

                     '4th Place',

                     'Zenaiz Data Engineering Training Project Showcase',

                     'Presented TripPulse with the team at BVRIT Hyderabad.',

                     cyan,

                  ),

                  _achievementSlide(

                     Icons.code_rounded,

                     '600+ Problems',

                     'CodeChef',

                     'Practicing algorithms and strengthening problem-solving skills.',

                     purple,

                  ),

                  _achievementSlide(

                     Icons.terminal_rounded,

                     '140+ Problems',

                     'LeetCode',

                     'Consistent practice in data structures and algorithms.',

                     cyan,

                  ),

                  _achievementSlide(

                     Icons.military_tech_outlined,

                     '983 Peak Rating',

                     'Codeforces',

                     'Participating in competitive programming contests.',

                     purple,

                  ),

               ],

            ),

         ),

         const SizedBox(height: 12),

         Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: List.generate(

               4,

               (i) => AnimatedContainer(

                  duration: const Duration(milliseconds: 250),

                  margin: const EdgeInsets.symmetric(horizontal: 4),

                  width: achievementIndex == i ? 24 : 7,

                  height: 7,

                  decoration: BoxDecoration(

                     color: achievementIndex == i

                           ? cyan

                           : const Color(0xFF39465A),

                     borderRadius: BorderRadius.circular(8),

                  ),

               ),

            ),

         ),

      ],

   );

}

   Widget _achievementSlide(IconData icon, String big, String title, String description, Color color) => Padding(padding: const EdgeInsets.all(28), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 70, height: 70, decoration: BoxDecoration(color: color.withValues(alpha: .12), borderRadius: BorderRadius.circular(22)), child: Icon(icon, color: color, size: 36)), const SizedBox(height: 18), Text(big, textAlign: TextAlign.center, style: TextStyle(color: color, fontSize: 30, fontWeight: FontWeight.w900)), const SizedBox(height: 8), Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 8), ConstrainedBox(constraints: const BoxConstraints(maxWidth: 430), child: Text(description, textAlign: TextAlign.center, style: const TextStyle(color: muted, height: 1.6)))]));

   Widget _sectionTitle(String title, String subtitle) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)), const SizedBox(height: 5), Text(subtitle, style: const TextStyle(color: muted, fontSize: 13))]);

   Widget _pill(String text) => Container(padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7), decoration: BoxDecoration(color: const Color(0xFF192538), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF304057))), child: Text(text, style: const TextStyle(color: Color(0xFFBDD7E8), fontSize: 11, fontWeight: FontWeight.w600)));

   Widget _stat(String value, String label, IconData icon, Color color) => Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF263248))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: color, size: 21), const Spacer(), Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)), const SizedBox(height: 4), Text(label, style: const TextStyle(color: muted, fontSize: 11))]));

   Widget _project(String title, String description, String stack, IconData icon, Color color, {String? url}) => Container(width: double.infinity, margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFF263248))), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 44, height: 44, decoration: BoxDecoration(color: color.withValues(alpha: .1), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: color)), const SizedBox(width: 15), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(description, style: const TextStyle(color: muted, height: 1.65, fontSize: 13)), const SizedBox(height: 10), Text(stack, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)), if (url != null) Align(alignment: Alignment.centerLeft, child: TextButton.icon(onPressed: () => _openLink(url), icon: const Icon(Icons.open_in_new_rounded, size: 16), label: const Text('View source on GitHub'), style: TextButton.styleFrom(foregroundColor: color, padding: EdgeInsets.zero)))]))]));

   Future<void> _openLink(String url) async {
      final uri = Uri.parse(url);
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && mounted) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open this link. Please try again.')));
      }
   }

   Widget _activity(IconData icon, String title, String date, String description) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF263248))), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: cyan, size: 24), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), const SizedBox(height: 3), Text(date, style: const TextStyle(color: purple, fontSize: 11)), const SizedBox(height: 7), Text(description, style: const TextStyle(color: muted, height: 1.5, fontSize: 13))]))]));

   Widget _linkChip(String label, String value, IconData icon) => InkWell(onTap: () => _openLink(label == 'Email' ? 'mailto:$value' : (value.startsWith('http') ? value : 'https://$value')), borderRadius: BorderRadius.circular(12), child: Container(padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF263248))), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: cyan, size: 17), const SizedBox(width: 8), Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)), const SizedBox(width: 6), const Icon(Icons.open_in_new_rounded, size: 13, color: muted)])));

}
