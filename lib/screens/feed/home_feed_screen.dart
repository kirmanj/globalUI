import 'package:flutter/material.dart';
import '../../widgets/ui_blocks.dart'; // keeps your BottomNav (and SearchBarField if you have it)

// ================= BRAND GRADIENT =================
const Color kGradientStart = Color(0xFF010669);
const Color kGradientEnd = Color(0xFF012DF0);
const LinearGradient kBrandGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kGradientStart, kGradientEnd],
);

// Simple helper so missing assets don't crash during dev
Widget _img(
  String? asset, {
  double? w,
  double? h,
  BoxFit fit = BoxFit.cover,
  Alignment alignment = Alignment.center, // NEW
  BorderRadius? br,
}) {
  Widget ph() => Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      borderRadius: br ?? BorderRadius.zero,
      gradient: kBrandGradient,
    ),
    alignment: Alignment.center,
    child: const Icon(Icons.image, color: Colors.white70, size: 28),
  );

  return ClipRRect(
    borderRadius: br ?? BorderRadius.zero,
    child:
        (asset == null || asset.isEmpty)
            ? ph()
            : Image.asset(
              asset,
              width: w,
              height: h,
              fit: fit,
              alignment: alignment, // NEW
              errorBuilder: (_, __, ___) => ph(),
            ),
  );
}

Widget _placeholder({double? w, double? h, BorderRadius? br}) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      borderRadius: br ?? BorderRadius.zero,
      gradient: kBrandGradient,
    ),
    alignment: Alignment.center,
    child: const Icon(Icons.image, color: Colors.white70, size: 28),
  );
}

// ================= SCREEN =================
class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});
  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  int _tab = 0;
  int _selectedCategory = 0;

  // Featured banners (carousel)
  final List<Map<String, String>> _featured = const [
    {
      'title': 'Summer Sports Camp 2025',
      'subtitle': 'Register now and get 20% off',
      'img': 'assets/images/basketball1.jpg',
      'cta': 'Register',
    },
    {
      'title': 'Elite Volley Ball Training',
      'subtitle': 'Limited seats — book today',
      'img': 'assets/images/volley.jpg',
      'cta': 'Book',
    },
  ];

  final List<String> _categories = const [
    'Players',
    'Coaches',
    'Sports Clubs',
    'Medical',
    'Stores',
    'Agents',
    'Academies',
    'Camps',
  ];

  // Data placeholders — replace images later
  final List<Map<String, String>> _players = const [
    {
      'name': 'Fawaz Al Soqoor',
      'sport': 'Football',
      'img': 'assets/images/Fawaz Al Soqoor.png',
      'club': 'Al Nassr',
      'position': 'Forward',
      'nation': 'Portugal',
      'foot': 'Right',
      'age': '39',
      'rating': '4.9',
      'views': '12.3k',
    },
    {
      'name': 'Alvaro Merdan',
      'sport': 'Basketball',
      'img': 'assets/images/Alvaro Merdan.png',
      'club': 'Memphis Grizzlies',
      'position': 'Guard',
      'nation': 'USA',
      'foot': 'Right',
      'age': '26',
      'rating': '4.7',
      'views': '3.3k',
    },
    {
      'name': 'Al gunam',
      'sport': 'Football',
      'img': 'assets/images/Al gunam.png',
      'club': 'Inter Miami',
      'position': 'Forward',
      'nation': 'Argentina',
      'foot': 'Left',
      'age': '37',
      'rating': '4.9',
      'views': '43k',
    },
    {
      'name': 'Yanick Carasco',
      'sport': 'Handball',
      'img': 'assets/images/Yanick Carasco.png',
      'club': 'Barça Handbol',
      'position': 'Left Wing',
      'nation': 'Spain',
      'foot': 'Left',
      'age': '28',
      'rating': '4.6',
      'views': '22.2k',
    },
    {
      'name': 'Hussein Al Amiri',
      'sport': 'Football',
      'img': 'assets/images/Hussein Al Amiri.png',
      'club': 'Real Madrid',
      'position': 'Forward',
      'nation': 'France',
      'foot': 'Right',
      'age': '26',
      'rating': '4.8',
      'views': '10.2k',
    },
    {
      'name': 'Ibañez',
      'sport': 'Handball',
      'img': 'assets/images/Ibañez.png',
      'club': 'Paris SG',
      'position': 'Forward',
      'nation': 'France',
      'foot': 'Right',
      'age': '40',
      'rating': '4.7',
      'views': '43k',
    },
  ];

  final List<Map<String, String>> _coaches = const [
    {
      'name': 'James Williams',
      'meta': 'Football Coach • 25 clients',
      'img': 'assets/images/coach 1.jpg',
      'rating': '4.8',
    },
    {
      'name': 'Massoud Mirral',
      'meta': 'Tennis Coach • 18 clients',
      'img': 'assets/images/Coach 2.jpg',
      'rating': '4.7',
    },
  ];

  final List<Map<String, String>> _clubs = const [
    {
      'title': 'Al Naser Club',
      'meta': 'Football Club',
      'img': 'assets/images/al nasser s.jpg',
    },
    {
      'title': 'Al-Hilal Club',
      'meta': 'Football Club',
      'img': 'assets/images/Al Hilal s.avif',
    },
  ];

  final List<Map<String, String>> _camps = const [
    {
      'title': 'Football Elite Training',
      'date': 'Jun 15 - Jul 10',
      'country': 'Germany',
      'img': 'assets/images/football .jpeg',
    },
    {
      'title': 'Summer Basketball Camp',
      'date': 'Aug 1 - Aug 20',
      'country': 'UAE',
      'img': 'assets/images/basket ball.jpeg',
    },
  ];

  final List<Map<String, String>> _academies = const [
    {
      'title': 'Abdu Dhabi Training School',
      'meta': 'Swimming • Soccer ',
      'img': 'assets/images/Abdu Dhabi training course indoor academy.jpeg',
    },
    {
      'title': 'Premier Basket Ball Academy',
      'meta': 'Volley Ball • Hand Ball',
      'img': 'assets/images/basket ball training.jpg',
    },
  ];

  final List<Map<String, String>> _medical = const [
    {
      'name': 'James Williams',
      'meta': 'Sport Nutrition',
      'img': 'assets/images/Dr. Muchael.jpg',
      'rating': '4.8',
    },
    {
      'name': 'Emily Parker',
      'meta': 'Performance Testing • 18 clients',
      'img': 'assets/images/bohdanka.jpg',
      'rating': '4.7',
    },
  ];

  final List<Map<String, String>> _stores = const [
    {
      'title': 'Go Sports',
      'meta': 'Sport equipment',
      'img': 'assets/images/Go Sports.jpg',
    },
    {
      'title': 'Sun Sand Sports',
      'meta': 'Sport equipment',
      'img': 'assets/images/Sun-Sand-Sports.jpg',
    },
    {
      'title': 'ORE',
      'meta': 'Sport equipment',
      'img': 'assets/images/ORE.webp',
    },
  ];

  final List<Map<String, String>> _agents = const [
    {
      'name': 'James Williams',
      'meta': 'Football Agent • 25 clients',
      'img': 'assets/images/avatars/agent1.png',
      'rating': '4.8',
    },
    {
      'name': 'Emily Parker',
      'meta': 'Basketball Agent • 18 clients',
      'img': 'assets/images/avatars/agent2.png',
      'rating': '4.7',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        index: _tab,
        onTap: (i) {
          setState(() => _tab = i);
          switch (i) {
            case 0:
              break;
            case 1:
              Navigator.pushNamed(context, '/messagesList');
              break;
            case 2:
              Navigator.pushNamed(context, '/favoritesEmpty');
              break;
            case 3:
              Navigator.pushNamed(context, '/profileEmpty');
              break;
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search
              const _SearchBar(hint: 'Search for sports, coaches, clubs...'),
              const SizedBox(height: 16),

              // Categories (gradient chips like the wizard)
              Text(
                'Categories',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, i) {
                    final selected = i == _selectedCategory;
                    return _GradientChip(
                      label: _categories[i],
                      selected: selected,
                      onTap: () => setState(() => _selectedCategory = i),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Featured carousel
              _FeaturedCarousel(items: _featured),

              const SizedBox(height: 16),
              _SectionHeader(
                title: 'Top Players',
                onViewAll: () => Navigator.pushNamed(context, '/playersList'),
              ),
              const SizedBox(height: 8),
              _PlayersVerticalCards(items: _players),

              const SizedBox(height: 16),
              _SectionHeader(
                title: 'Top Coaches',
                onViewAll: () => Navigator.pushNamed(context, '/coachesList'),
              ),
              const SizedBox(height: 8),
              _PeopleCardsScroller(items: _coaches, actionLabel: 'Contact'),

              const SizedBox(height: 16),
              _SectionHeader(
                title: 'Sports Clubs',
                onViewAll: () => Navigator.pushNamed(context, '/clubsList'),
              ),
              const SizedBox(height: 8),
              _ImageTileScroller(items: _clubs),

              const SizedBox(height: 16),
              _SectionHeader(
                title: 'Sports Camping',
                onViewAll: () => Navigator.pushNamed(context, '/campsList'),
              ),
              const SizedBox(height: 8),
              _LargeImageCardsScroller(
                items: _camps,
                trailingMeta: true,
                actionLabel: 'Book',
              ),

              const SizedBox(height: 16),
              _SectionHeader(
                title: 'Medical Staff',
                onViewAll: () => Navigator.pushNamed(context, '/medicalList'),
              ),
              const SizedBox(height: 8),
              _PeopleCardsScroller(items: _medical, actionLabel: 'Contact'),

              const SizedBox(height: 16),
              _SectionHeader(
                title: 'Sports Store',
                onViewAll: () => Navigator.pushNamed(context, '/storesList'),
              ),
              const SizedBox(height: 8),
              _ImageCardScroller(items: _stores),

              const SizedBox(height: 16),
              _SectionHeader(
                title: 'Sports Academy',
                onViewAll: () => Navigator.pushNamed(context, '/academiesList'),
              ),
              const SizedBox(height: 8),
              _LargeImageCardsScroller(items: _academies),

              const SizedBox(height: 16),
              _SectionHeader(
                title: 'Sports Agents',
                onViewAll: () => Navigator.pushNamed(context, '/agentsList'),
              ),
              const SizedBox(height: 8),
              _PeopleCardsScroller(items: _agents, actionLabel: 'Contact'),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= REUSABLE WIDGETS =================

// Search (keeps your look; swap to your SearchBarField if you have it)
class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.hint});
  final String hint;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 44,
      child: Row(
        children: [
          const Icon(Icons.search_rounded),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search ",
                  hintStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.tune_rounded), onPressed: () {}),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onViewAll});
  final String title;
  final VoidCallback onViewAll;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(onPressed: onViewAll, child: const Text('View all')),
      ],
    );
  }
}

class _GradientChip extends StatelessWidget {
  const _GradientChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (selected) {
      return InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            gradient: kBrandGradient,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      );
    }
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: kGradientEnd.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(999),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ===== Featured carousel (with overlay text & CTA)
class _FeaturedCarousel extends StatefulWidget {
  const _FeaturedCarousel({required this.items});
  final List<Map<String, String>> items;
  @override
  State<_FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<_FeaturedCarousel> {
  final _pc = PageController(viewportFraction: 0.92);
  int _ix = 0;
  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            controller: _pc,
            itemCount: widget.items.length,
            onPageChanged: (i) => setState(() => _ix = i),
            itemBuilder: (_, i) {
              final it = widget.items[i];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  children: [
                    _img(
                      it['img'],
                      br: BorderRadius.circular(18),
                      fit: BoxFit.cover,
                    ),
                    // dark scrim
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    // text
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            it['title']!,
                            style: t.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            it['subtitle']!,
                            style: t.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.white,
                                foregroundColor: kGradientEnd,
                              ),
                              onPressed: () {},
                              child: Text(it['cta']!),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.items.length, (i) {
            final active = i == _ix;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: active ? 22 : 8,
              decoration: BoxDecoration(
                color: active ? kGradientEnd : Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ----- NEW: Players vertical cards scroller
// ---- compact stat pill used below
class _StatPill extends StatelessWidget {
  const _StatPill({required this.icon, required this.label, this.maxWidth});

  final IconData icon;
  final String label;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Colors.white),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );

    if (maxWidth != null) {
      content = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: content,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        border: Border.all(color: Colors.white.withOpacity(0.45)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: content,
    );
  }
}

class _PlayersVerticalCards extends StatelessWidget {
  const _PlayersVerticalCards({required this.items});
  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return SizedBox(
      height: 390, // +12px cushion to prevent bottom overflow on some devices
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final it = items[i];
          return ConstrainedBox(
            constraints: const BoxConstraints.tightFor(
              width: 190,
            ), // narrower card
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0.7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SQUARE image; top-centered so heads stay visible
                  AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: _img(
                            it['img'],
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        // bottom scrim
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.55),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        // name + chips (Wrap so it never overflows)
                        Positioned(
                          left: 10,
                          right: 10,
                          bottom: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                it['name'] ?? 'Unknown',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: t.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: [
                                  _MiniChip(
                                    label: it['position'] ?? '-',
                                    filled: true,
                                  ),
                                  _MiniChip(label: it['sport'] ?? '-'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Details — gradient background + white content
                  Container(
                    decoration: const BoxDecoration(
                      gradient: kBrandGradient,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(
                      12,
                      8,
                      12,
                      10,
                    ), // slightly tighter padding
                    child: IconTheme(
                      data: const IconThemeData(color: Colors.white),
                      child: DefaultTextStyle.merge(
                        style: t.bodyMedium?.copyWith(color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _InfoRow(
                                    icon: Icons.shield_rounded,
                                    text: it['club'] ?? '—',
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 6),
                                  _InfoRow(
                                    icon: Icons.flag_rounded,
                                    text: it['nation'] ?? '—',
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 6),
                                  _InfoRow(
                                    icon: Icons.sports_soccer_sharp,
                                    text: 'Foot: ${it['foot'] ?? '—'}',
                                    dense: true,
                                    color: Colors.white,
                                  ),

                                  const SizedBox(height: 6),
                                  _InfoRow(
                                    icon: Icons.date_range,
                                    text: 'Age: ${it['age'] ?? '—'}',
                                    dense: true,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: OverflowBar(
                                alignment: MainAxisAlignment.end,

                                spacing: 8,
                                overflowSpacing: 8,
                                children: [
                                  // rating (short)
                                  _StatPill(
                                    icon: Icons.star_rounded,
                                    label: it['rating'] ?? '—',
                                  ),
                                  // views (short, just the number; cap width)
                                  _StatPill(
                                    icon: Icons.remove_red_eye_rounded,
                                    label: (it['views'] ?? '—'),
                                    maxWidth:
                                        78, // keep it compact on narrow cards
                                  ),
                                  // compact button
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      minimumSize: const Size(
                                        0,
                                        30,
                                      ), // compact height
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      // TODO: push player profile
                                    },
                                    child: const Text(
                                      'Profile',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.text,
    this.dense = false,
    this.color,
  });
  final IconData icon;
  final String text;
  final bool dense;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final base =
        dense
            ? Theme.of(context).textTheme.bodySmall
            : Theme.of(context).textTheme.bodyMedium;
    final style = base?.copyWith(color: color ?? base?.color);
    return Row(
      children: [
        Icon(
          icon,
          size: dense ? 12 : 12,
          color: color?.withOpacity(0.9) ?? Colors.black54,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.label, this.filled = false});
  final String label;
  final bool filled;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: filled ? kBrandGradient : null,
        color: filled ? null : Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(999),
        border:
            filled ? null : Border.all(color: Colors.white.withOpacity(0.45)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}

// ===== People cards (coach/medical/agents) with action button & rating
class _PeopleCardsScroller extends StatelessWidget {
  const _PeopleCardsScroller({required this.items, this.actionLabel});
  final List<Map<String, String>> items;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return SizedBox(
      height: actionLabel == null ? 120 : 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final it = items[i];
          return SizedBox(
            width: 270,
            child: Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: _img(
                            it['img'],
                            w: 48,
                            h: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                it['name'] ?? 'Unknown',
                                style: t.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                it['meta']!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: t.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        if (it['rating'] != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  it['rating']!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    if (actionLabel != null)
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: kGradientEnd,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                          ),
                          child: Text(actionLabel!),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ===== Small image tiles (clubs)
class _ImageTileScroller extends StatelessWidget {
  const _ImageTileScroller({required this.items});
  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final it = items[i];
          return SizedBox(
            width: 220,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _img(
                    it['img'],
                    h: 100,
                    w: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          it['title']!,
                          style: t.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          it['meta']!,
                          style: t.bodySmall?.copyWith(color: Colors.black54),
                        ),
                      ],
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

// ===== Stores (card with image & meta)
class _ImageCardScroller extends StatelessWidget {
  const _ImageCardScroller({required this.items});
  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final it = items[i];
          return SizedBox(
            width: 160,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _img(it['img'], h: 110, w: 160, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          it['title']!,
                          style: t.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          it['meta']!,
                          style: t.bodySmall?.copyWith(color: Colors.black54),
                        ),
                      ],
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

// ===== Large image cards (camps/academies)
class _LargeImageCardsScroller extends StatelessWidget {
  const _LargeImageCardsScroller({
    required this.items,
    this.trailingMeta = false,
    this.actionLabel,
  });
  final List<Map<String, String>> items;
  final bool trailingMeta;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final it = items[i];
          return SizedBox(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  _img(
                    it['img'],
                    w: 300,
                    h: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.55),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                it['title']!,
                                style: t.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              if (trailingMeta) ...[
                                const SizedBox(height: 4),
                                Text(
                                  '${it['date']}  •  ${it['country']}',
                                  style: t.bodySmall?.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (actionLabel != null)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: kGradientEnd,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(0, 36),
                            ),
                            onPressed: () {},
                            child: Text(actionLabel!),
                          ),
                      ],
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
