import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const RiskReadyApp());

class RiskReadyApp extends StatelessWidget {
  const RiskReadyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RiskReady',
      theme: ThemeData(
        colorSchemeSeed: Colors.red,
        brightness: Brightness.light,
        useMaterial3: true,
        cardTheme: const CardThemeData(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.red,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class Contact {
  final String name;
  final String number;
  final String note;
  Contact({required this.name, required this.number, this.note = ''});
}

class Guide {
  final String title;
  final List<String> steps;
  Guide({required this.title, required this.steps});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Set<String> _favorites = {};
  String _selectedCity = 'All';
  List<String> _cities = [
    'All',
    'Panabo City',
    'Davao Oriental',
    'Mabini',
    'Tagum City',
    'Davao City'
  ];

  final List<Contact> contacts = [
    Contact(name: 'Municipality of Boston', number: '0952 579 9960', note: 'Davao Oriental'),
    Contact(name: 'Municipality of Cateel', number: '0938 286 7027', note: 'Davao Oriental'),
    Contact(name: 'Municipality of Baganga', number: '0953 211 9619', note: 'Davao Oriental'),
    Contact(name: 'Municipality of Caraga', number: '0970 379 9649', note: 'Davao Oriental'),
    Contact(name: 'Municipality of Manay', number: '0998 554 1866', note: 'Davao Oriental'),
    Contact(name: 'City of Mati - CDRRMO', number: '0912 345 4666', note: 'Davao Oriental'),
    Contact(name: 'Municipality of Banaybanay', number: '0963 379 7788', note: 'Davao Oriental'),
    Contact(name: 'Municipality of Lupon', number: '0910 147 5098', note: 'Davao Oriental'),
    Contact(name: 'Municipality of San Isidro', number: '0933 819 5314', note: 'Davao Oriental'),
    Contact(name: 'Municipality of Governor Generoso', number: '0926 824 8700', note: 'Davao Oriental'),
    Contact(name: 'Municipality of Tarragona', number: '0905 426 1364', note: 'Davao Oriental'),
    Contact(name: 'PDRRMO', number: '0948 838 6060', note: 'Davao Oriental'),
    Contact(name: 'PDDRMO (Globe)', number: '0909 349 4645', note: 'Mabini'),
    Contact(name: 'PDDRMO (Smart)', number: '0995 891 9697', note: 'Mabini'),
    Contact(name: 'Mabini LGU', number: '0999 302 0973', note: 'Mabini'),
    Contact(name: 'Red Cross Representative - Davao de Oro', number: '0906 319 1697', note: 'Mabini'),
    Contact(name: 'PNP — Globe', number: '0926 717 1522', note: 'Tagum City'),
    Contact(name: 'Fire Protection (Mobile)', number: '0926 717 1538', note: 'Tagum City'),
    Contact(name: 'CDRRMO Rescue (Mobile)', number: '0927 531 3119', note: 'Tagum City'),
    Contact(name: 'Red Cross Chapter Administrator - Davao del Norte', number: '0947 891 3786', note: 'Tagum City'),
    Contact(name: 'PNP - Panabo', number: '0998 598 7104', note: 'Panabo City'),
    Contact(name: 'BFP - Panabo', number: '0928 458 7586', note: 'Panabo City'),
    Contact(name: 'CDRRMO - Panabo', number: '0930 238 5937', note: 'Panabo City'),
    Contact(name: 'Central 911 – Davao City', number: '082-296-9626', note: 'Davao City'),
    Contact(name: 'Team Davao Rescue', number: '0933 338 2012', note: 'Davao City'),
    Contact(name: 'PH Red Cross – Davao City', number: '082-227-6650', note: 'Davao City'),
  ];

  final List<Guide> guides = [
    Guide(title: 'CPR (Adult)', steps: [
      'Check scene safety and responsiveness.',
      'Call emergency services and get an AED if available.',
      'Check breathing and pulse for no more than 10 seconds.',
      'Start chest compressions at 100–120/min, depth 5–6 cm.',
      'Place the heel of one hand on the center of the chest, other hand on top, arms straight.',
      'Perform 30 compressions followed by 2 rescue breaths (if trained).',
      'Continue CPR until help arrives, the person moves/breathes, or you are too exhausted.',
      'If untrained, perform hands-only CPR (continuous compressions).',
    ]),
    Guide(title: 'Choking (Adult)', steps: [
      'Ask if they are choking.',
      'If they can cough or speak, encourage coughing.',
      'If unable to breathe or speak, perform 5 back blows between the shoulder blades.',
      'Then perform 5 abdominal thrusts (Heimlich maneuver).',
      'Alternate 5 back blows and 5 abdominal thrusts until the object is expelled or they become unresponsive.',
      'If unconscious, begin CPR and check the mouth for obstruction after each cycle.',
      'For obese or pregnant victims, perform chest thrusts instead of abdominal thrusts.',
    ]),
    Guide(title: 'Bleeding Control', steps: [
      'Apply direct pressure using a clean cloth or sterile dressing.',
      'Keep the injured part elevated above the heart if possible.',
      'If a dressing becomes soaked, add more layers instead of removing the original.',
      'If an object is embedded, do not remove it—apply pressure around it.',
      'If severe bleeding, apply a tourniquet above the wound (trained personnel only).',
      'Monitor for signs of shock: pale skin, rapid pulse, weakness.',
      'Lay the person flat, elevate legs (if no injury), and keep them warm.',
      'Seek emergency care immediately.',
    ]),
    Guide(title: 'Burns', steps: [
      'Remove the person from the source of the burn safely.',
      'Cool the burn under cool (not cold) running water for 10–20 minutes.',
      'Remove tight clothing or jewelry near the burn (not stuck to the skin).',
      'Cover the burn with a sterile, non-stick dressing or clean cloth.',
      'Do not apply creams, oils, or ice.',
      'For large or deep burns, or if on face/genitals, seek emergency medical help.',
    ]),
    Guide(title: 'Fractures and Sprains', steps: [
      'Do not move the injured area unless absolutely necessary.',
      'Support the limb with a splint or sling in the position found.',
      'Apply a cold pack to reduce swelling (avoid direct contact with skin).',
      'If an open fracture, cover the wound with a sterile dressing.',
      'Do not try to push bones back into place.',
      'Seek medical attention immediately.',
    ]),
    Guide(title: 'Shock', steps: [
      'Recognize signs: pale, cool, clammy skin; weak pulse; confusion or fainting.',
      'Lay the person flat on their back.',
      'Elevate the legs about 12 inches unless there’s injury or discomfort.',
      'Keep the person warm and comfortable.',
      'Do not give food or water.',
      'Call emergency services immediately.',
    ]),
    Guide(title: 'Heatstroke and Hypothermia', steps: [
      'For Heatstroke: Move person to a cool area, remove excess clothing.',
      'Cool the body with damp cloths or fan air while misting with water.',
      'Give small sips of water if conscious and able to drink.',
      'For Hypothermia: Move to a warm, dry place; remove wet clothing.',
      'Warm gradually using blankets or body heat.',
      'Do not use direct heat or hot water bottles.',
      'Seek medical attention immediately for severe cases.',
    ]),
    Guide(title: 'Poisoning', steps: [
      'Check the scene for safety before assisting.',
      'Do not induce vomiting unless told by medical professionals.',
      'Try to identify the poison (container, label, or smell).',
      'Call poison control or emergency services immediately.',
      'If the poison is on the skin, rinse with running water for 15–20 minutes.',
      'If inhaled, move the person to fresh air immediately.',
      'If ingested, do not give anything to eat or drink unless instructed by professionals.',
    ]),
  ];

  final List<Map<String, String>> tips = [
    {
      'title': 'Create a family emergency plan.',
      'info': 'Identify safe meeting places, emergency contacts, and how to communicate if separated.'
    },
    {
      'title': 'Prepare a 72-hour kit with essentials.',
      'info': 'Include food, water, medicine, flashlight, batteries, first aid supplies, and important documents.'
    },
    {
      'title': 'Know evacuation routes.',
      'info': 'Familiarize yourself with local evacuation areas and practice your route regularly.'
    },
    {
      'title': 'Learn basic first aid and CPR.',
      'info': 'Take a certified course to confidently respond to medical emergencies while waiting for help.'
    },
    {
      'title': 'Store emergency contacts.',
      'info': 'Keep local emergency numbers, family contacts, and hospital hotlines saved in your phone and written down.'
    },
    {
      'title': 'Secure your home.',
      'info': 'Anchor heavy furniture, know how to shut off gas and electricity, and store breakables safely.'
    },
    {
      'title': 'Stay informed.',
      'info': 'Monitor weather alerts, news updates, and official advisories using reliable sources or apps.'
    },
    {
      'title': 'Plan for pets.',
      'info': 'Include pet food, leashes, carriers, and vaccination records in your emergency kit.'
    },
    {
      'title': 'Practice emergency drills.',
      'info': 'Regularly simulate evacuation or earthquake drills with family members to build confidence.'
    },
    {
      'title': 'Check your emergency supplies every 6 months.',
      'info': 'Replace expired food, water, and batteries to ensure your kit is always ready.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favorites') ?? <String>[];
    setState(() => _favorites = favs.toSet());
  }

  Future<void> _toggleFavorite(String key) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favorites.contains(key)) {
        _favorites.remove(key);
      } else {
        _favorites.add(key);
      }
    });
    await prefs.setStringList('favorites', _favorites.toList());
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildContactsPage(),
      _buildGuidesPage(),
      _buildTipsPage(),
      _buildFavoritesPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('RiskReady'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Change theme from system settings.')),
            ),
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.phone), label: 'Contacts'),
          NavigationDestination(icon: Icon(Icons.healing), label: 'First Aid'),
          NavigationDestination(icon: Icon(Icons.info), label: 'Tips'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Favorites'),
        ],
        indicatorColor: Colors.redAccent,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Contact'),
        backgroundColor: Colors.red,
        onPressed: () => _showAddContactDialog(context),
      )
          : null,
    );
  }

  Widget _buildContactsPage() {
    final TextEditingController searchController = TextEditingController();
    String searchQuery = '';

    return StatefulBuilder(
      builder: (context, setLocalState) {
        // Filter contacts based on both city and search query
        final filteredContacts = contacts.where((c) {
          final matchesCity = _selectedCity == 'All' || c.note == _selectedCity;
          final matchesSearch = c.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              c.note.toLowerCase().contains(searchQuery.toLowerCase());
          return matchesCity && matchesSearch;
        }).toList()
          ..sort((a, b) => a.name.compareTo(b.name));

        return Column(
          children: [
            // 🏙 City filter row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCity,
                      decoration: const InputDecoration(
                        labelText: 'Filter by City',
                        border: OutlineInputBorder(),
                      ),
                      items: _cities
                          .map((city) =>
                          DropdownMenuItem(value: city, child: Text(city)))
                          .toList(),
                      onChanged: (value) => setState(() => _selectedCity = value!),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_location_alt, color: Colors.redAccent),
                    tooltip: 'Add City',
                    onPressed: _showAddCityDialog,
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search contacts...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      setLocalState(() => searchQuery = '');
                    },
                  )
                      : null,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (value) => setLocalState(() => searchQuery = value),
              ),
            ),

            const SizedBox(height: 8),

            // Contacts list
            Expanded(
              child: filteredContacts.isEmpty
                  ? const Center(
                child: Text('No contacts found.'),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: filteredContacts.length,
                itemBuilder: (context, idx) {
                  final c = filteredContacts[idx];
                  final key = 'contact:${c.name}:${c.number}';
                  final isFav = _favorites.contains(key);
                  return Card(
                    child: ListTile(
                      title: Text(c.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),
                      subtitle: Text('${c.number} — ${c.note}'),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(Icons.local_phone, color: Colors.white),
                      ),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            icon: Icon(isFav
                                ? Icons.star
                                : Icons.star_border,
                                color: Colors.red),
                            onPressed: () => _toggleFavorite(key),
                          ),
                          IconButton(
                            icon: const Icon(Icons.call, color: Colors.green),
                            onPressed: () => _launchCaller(c.number),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.grey),
                            onPressed: () => _confirmDeleteContact(c),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGuidesPage() => ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: guides.length,
    itemBuilder: (context, i) {
      final g = guides[i];
      final key = 'guide:${g.title}';
      final isFav = _favorites.contains(key);
      return Card(
        child: ExpansionTile(
          title: Text(g.title),
          trailing: IconButton(
            icon: Icon(isFav ? Icons.star : Icons.star_border,
                color: Colors.red),
            onPressed: () => _toggleFavorite(key),
          ),
          children: g.steps
              .asMap()
              .entries
              .map((e) => ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.red.shade100,
                child: Text('${e.key + 1}',
                    style: const TextStyle(color: Colors.red))),
            title: Text(e.value),
          ))
              .toList(),
        ),
      );
    },
  );

  Widget _buildTipsPage() => ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: tips.length,
    itemBuilder: (context, i) => Card(
      child: ListTile(
        leading: Icon(Icons.lightbulb_outline, color: Colors.amber[600]),
        title: Text(tips[i]['title'] ?? ''),
        subtitle: Text(tips[i]['info'] ?? ''),
      ),
    ),
  );

 Widget _buildFavoritesPage() {
  final favContacts = contacts
      .where((c) => _favorites.contains('contact:${c.name}:${c.number}'))
      .toList();
  final favGuides =
      guides.where((g) => _favorites.contains('guide:${g.title}')).toList();

  if (favContacts.isEmpty && favGuides.isEmpty) {
    return const Center(
      child: Text('No favorites yet. Tap the star icon to save one.'),
    );
  }

  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      if (favContacts.isNotEmpty)
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text('Contacts',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
      ...favContacts.map(
        (c) => Card(
          child: ListTile(
            title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${c.number} — ${c.note}'),
            leading: const CircleAvatar(
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.local_phone, color: Colors.white),
            ),
            onTap: () => _launchCaller(c.number), // 👈 Makes it clickable to call
            trailing: IconButton(
              icon: const Icon(Icons.star, color: Colors.red),
              onPressed: () => _toggleFavorite('contact:${c.name}:${c.number}'),
            ),
          ),
        ),
      ),
      if (favGuides.isNotEmpty)
        const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 8),
          child: Text('Guides',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
      ...favGuides.map(
        (g) => Card(
          child: ExpansionTile(
            title: Text(g.title),
            trailing: IconButton(
              icon: const Icon(Icons.star, color: Colors.red),
              onPressed: () => _toggleFavorite('guide:${g.title}'),
            ),
            children: g.steps
                .asMap()
                .entries
                .map(
                  (e) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red.shade100,
                      child: Text('${e.key + 1}',
                          style: const TextStyle(color: Colors.red)),
                    ),
                    title: Text(e.value),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    ],
  );
}



  Future<void> _launchCaller(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Cannot launch dialer.')));
    }
  }

  void _showAddContactDialog(BuildContext context) {
    final nameCtl = TextEditingController();
    final numCtl = TextEditingController();
    String? selectedCity = _selectedCity == 'All' ? null : _selectedCity;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: numCtl,
              decoration: const InputDecoration(labelText: 'Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedCity,
              hint: const Text('Select City (optional)'),
              items: _cities
                  .where((city) => city != 'All')
                  .map((city) =>
                  DropdownMenuItem(value: city, child: Text(city)))
                  .toList(),
              onChanged: (value) => selectedCity = value,
              decoration: const InputDecoration(
                labelText: 'City (optional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add'),
            onPressed: () {
              final name = nameCtl.text.trim();
              final number = numCtl.text.trim();

              if (name.isNotEmpty && number.isNotEmpty) {
                setState(() {
                  contacts.add(Contact(
                    name: name,
                    number: number,
                    note: selectedCity ?? 'Uncategorized', // 🟢 default if no city
                  ));
                });
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please enter name and number.')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showGuideDetails(Guide guide) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(guide.title),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: guide.steps
              .asMap()
              .entries
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text('${e.key + 1}. ${e.value}'),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}


  void _showAddCityDialog() {
    final cityCtl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add City'),
        content: TextField(
          controller: cityCtl,
          decoration: const InputDecoration(labelText: 'City Name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton.icon(
            icon: const Icon(Icons.add_location_alt),
            label: const Text('Add'),
            onPressed: () {
              final newCity = cityCtl.text.trim();
              if (newCity.isNotEmpty && !_cities.contains(newCity)) {
                setState(() {
                  _cities.add(newCity);
                  _selectedCity = newCity;
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _confirmDeleteContact(Contact contact) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text('Are you sure you want to delete "${contact.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text('Delete'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                contacts.remove(contact);
                _favorites.remove('contact:${contact.name}:${contact.number}');
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}