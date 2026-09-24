import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const SchoolApp());
}

class SchoolApp extends StatelessWidget {
  const SchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kharua Rajapur High School',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kharua Rajapur High School'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 115,
                    height: 115,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: ClipOval(
                      child: Image.asset(
                        'school_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'KHARUA RAJAPUR HIGH SCHOOL (HS)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Welcome to Our School App',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.15,
                children: [
                  _menu(context, '📢', 'Notice', Colors.orange, const NoticePage()),
                  _menu(context, '👨‍🏫', 'Teachers', Colors.blue, const TeachersPage()),
                  _menu(context, '👨‍🎓', 'Students', Colors.green, const StudentsPage()),
                  _menu(context, '📞', 'Contact', Colors.red, const ContactPage()),
                  _menu(context, '🏆', 'Sports', Colors.purple, const SportsPage()),
                  _menu(context, '📊', 'Results', Colors.teal, const ResultsPage()),
                  _menu(context, '🖼️', 'Gallery', Colors.indigo, const GalleryPage()),
                  _menu(context, '📅', 'Routine', Colors.brown, const RoutinePage()),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Icon(Icons.location_on, size: 45, color: Colors.red.shade600),
                    const SizedBox(height: 8),
                    const Text(
                      'School Location',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Kharua Rajapur, Bongaon,\nNorth 24 Parganas, West Bengal',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final url = Uri.parse(
                          'https://www.google.com/maps/search/?api=1&query=Kharua+Rajapur+High+School+North+24+Parganas',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(Icons.map),
                      label: const Text('Open Google Maps'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('© Kharua Rajapur High School',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _menu(BuildContext context, String icon, String title, Color color, Widget page) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => openPage(context, page),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 38)),
            const SizedBox(height: 8),
            Text(title,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  static const photos = [
    ('students_teachers.jpg', 'Students & Teachers'),
    ('rangoli_activity.jpg', 'Rangoli Activity'),
    ('school_programme.jpg', 'School Programme'),
    ('school_event.jpg', 'School Event'),
    ('rangoli_competition.jpg', 'Rangoli Competition'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Gallery'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.82,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final item = photos[index];
          return Card(
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PhotoViewer(
                      imagePath: item.$1,
                      title: item.$2,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: item.$1,
                      child: Image.asset(
                        item.$1,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Text(
                      item.$2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PhotoViewer extends StatelessWidget {
  final String imagePath;
  final String title;

  const PhotoViewer({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Hero(
          tag: imagePath,
          child: InteractiveViewer(
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

// The following pages keep the existing app structure.
class NoticePage extends StatelessWidget {
  const NoticePage({super.key});
  @override
  Widget build(BuildContext context) => _simplePage(
    context, 'School Notice', Colors.orange,
    const [
      _CardData(Icons.campaign, 'School Notice', 'Important school notices will appear here.'),
      _CardData(Icons.event, 'Upcoming Events', 'School events and programmes will be updated here.'),
    ],
  );
}

class TeachersPage extends StatelessWidget {
  const TeachersPage({super.key});
  @override
  Widget build(BuildContext context) => _simplePage(
    context, 'Teachers', Colors.blue,
    const [
      _CardData(Icons.person, 'Shankar Kumar Sarkar', 'Head Teacher'),
      _CardData(Icons.groups, 'Teaching Staff', 'School teaching staff information'),
    ],
  );
}

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});
  @override
  Widget build(BuildContext context) => _simplePage(
    context, 'Students', Colors.green,
    const [
      _CardData(Icons.school, 'Class 5', 'Students information'),
      _CardData(Icons.school, 'Class 6', 'Students information'),
      _CardData(Icons.school, 'Class 7', 'Students information'),
      _CardData(Icons.school, 'Class 8', 'Students information'),
      _CardData(Icons.school, 'Class 9', 'Students information'),
      _CardData(Icons.school, 'Class 10', 'Students information'),
    ],
  );
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact School'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.school, size: 80, color: Colors.blue),
            const SizedBox(height: 15),
            const Text('Kharua Rajapur High School (HS)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Head Teacher'),
              subtitle: Text('Shankar Kumar Sarkar'),
            ),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Address'),
              subtitle: Text(
                'Village + Post: Kharua Rajapur\n'
                'Police Station: Bongaon\n'
                'District: North 24 Parganas',
              ),
            ),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text('E-mail'),
              subtitle: Text('E-mail will be added later'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                final phone = Uri.parse('tel:9474199187');
                if (await canLaunchUrl(phone)) await launchUrl(phone);
              },
              icon: const Icon(Icons.phone),
              label: const Text('Call School'),
            ),
          ],
        ),
      ),
    );
  }
}

class SportsPage extends StatelessWidget {
  const SportsPage({super.key});
  @override
  Widget build(BuildContext context) => _simplePage(
    context, 'Sports & Events', Colors.purple,
    const [
      _CardData(Icons.sports_soccer, 'Football', 'School football events and competitions'),
      _CardData(Icons.sports, 'Annual Sports', 'Annual sports events and results'),
      _CardData(Icons.sports_handball, 'Kho-Kho', 'Kho-Kho competition information'),
    ],
  );
}

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});
  @override
  Widget build(BuildContext context) => _simplePage(
    context, 'School Results', Colors.teal,
    const [
      _CardData(Icons.assessment, 'Madhyamik Result', 'Result information will be updated here.'),
      _CardData(Icons.assessment, 'Higher Secondary Result', 'Result information will be updated here.'),
    ],
  );
}

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});
  @override
  Widget build(BuildContext context) => _simplePage(
    context, 'Class Routine', Colors.brown,
    const [
      _CardData(Icons.calendar_month, 'Class 5–6', 'Class routine will be added here.'),
      _CardData(Icons.calendar_month, 'Class 7–8', 'Class routine will be added here.'),
      _CardData(Icons.calendar_month, 'Class 9–10', 'Class routine will be added here.'),
    ],
  );
}

class _CardData {
  final IconData icon;
  final String title;
  final String subtitle;
  const _CardData(this.icon, this.title, this.subtitle);
}

Widget _simplePage(
  BuildContext context,
  String title,
  Color color,
  List<_CardData> items,
) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
      backgroundColor: color,
      foregroundColor: Colors.white,
    ),
    body: ListView(
      padding: const EdgeInsets.all(15),
      children: items
          .map((x) => Card(
                child: ListTile(
                  leading: Icon(x.icon),
                  title: Text(x.title),
                  subtitle: Text(x.subtitle),
                ),
              ))
          .toList(),
    ),
  );
}
