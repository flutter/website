import 'package:flutter/material.dart';

void main() {
  runApp(const MaherTelecomApp());
}

class MaherTelecomApp extends StatelessWidget {
  const MaherTelecomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ماهر للاتصالات',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff1565C0),
        scaffoldBackgroundColor: const Color(0xffF5F7FB),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MainScreen(),
      ),
    );
  }
}

// =========================
// التطبيق الرئيسي
// =========================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    ServicesPage(),
    OrdersPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.bolt_outlined),
            selectedIcon: Icon(Icons.bolt),
            label: 'الخدمات',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'طلباتي',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            builder: (_) => const AssistantPage(),
          );
        },
        child: const Icon(Icons.smart_toy_outlined),
      ),
    );
  }
}

// =========================
// نموذج المنتج
// =========================

class Product {
  final String name;
  final String price;
  final String category;
  final String description;
  final IconData icon;

  const Product({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.icon,
  });
}

const List<Product> products = [
  Product(
    name: 'Samsung Galaxy S24 Ultra',
    price: 'السعر حسب المتوفر',
    category: 'هواتف',
    description:
        'هاتف Samsung Galaxy S24 Ultra. سيتم لاحقاً ربط الصور والمواصفات والأسعار الحقيقية من لوحة التحكم.',
    icon: Icons.smartphone,
  ),
  Product(
    name: 'iPhone',
    price: 'السعر حسب المتوفر',
    category: 'هواتف',
    description:
        'أجهزة iPhone بموديلات مختلفة. التفاصيل والأسعار ستضاف من لوحة الإدارة.',
    icon: Icons.phone_iphone,
  ),
  Product(
    name: 'هاتف مستعمل',
    price: 'السعر حسب الحالة',
    category: 'مستعمل',
    description:
        'هواتف مستعملة بحالات مختلفة مع إمكانية إضافة صور الجهاز ومواصفاته.',
    icon: Icons.phone_android,
  ),
  Product(
    name: 'شاحن Type-C',
    price: 'السعر حسب المنتج',
    category: 'شواحن',
    description:
        'شواحن Type-C بمواصفات مختلفة.',
    icon: Icons.bolt,
  ),
  Product(
    name: 'سماعة لاسلكية',
    price: 'السعر حسب المنتج',
    category: 'سماعات',
    description:
        'سماعات لاسلكية للاستخدام اليومي.',
    icon: Icons.headphones,
  ),
  Product(
    name: 'سبيكر',
    price: 'السعر حسب المنتج',
    category: 'سبيكرات',
    description:
        'سبيكرات صوتية بمقاسات ومواصفات مختلفة.',
    icon: Icons.speaker,
  ),
];

// =========================
// الرئيسية
// =========================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final filtered = products.where((product) {
      if (search.trim().isEmpty) return true;

      final value = search.toLowerCase();

      return product.name.toLowerCase().contains(value) ||
          product.category.toLowerCase().contains(value);
    }).toList();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xff1565C0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.phone_android,
                      color: Colors.white,
                      size: 29,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ماهر للاتصالات',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'متجر الأجهزة والخدمات الرقمية',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const AlertDialog(
                          title: Text('الإشعارات'),
                          content: Text(
                            'لا توجد إشعارات جديدة حالياً.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_none,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'ابحث عن هاتف أو شاحن أو سماعة...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff0D47A1),
                      Color(0xff1976D2),
                    ],
                  ),
                ),
                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ماهر للاتصالات',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'كل ما تحتاجه لهاتفك في مكان واحد',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SectionTitle(title: 'التصنيفات'),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 105,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14),
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryCard(
                    icon: Icons.smartphone,
                    title: 'هواتف',
                  ),
                  CategoryCard(
                    icon: Icons.phone_android,
                    title: 'مستعمل',
                  ),
                  CategoryCard(
                    icon: Icons.bolt,
                    title: 'شواحن',
                  ),
                  CategoryCard(
                    icon: Icons.headphones,
                    title: 'سماعات',
                  ),
                  CategoryCard(
                    icon: Icons.speaker,
                    title: 'سبيكرات',
                  ),
                  CategoryCard(
                    icon: Icons.shield_outlined,
                    title: 'حماية',
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SectionTitle(
              title: search.isEmpty
                  ? 'منتجات مميزة'
                  : 'نتائج البحث',
            ),
          ),

          if (filtered.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Text(
                    'لم نجد منتجاً مطابقاً للبحث.',
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate:
                    SliverChildBuilderDelegate(
                  (context, index) {
                    return ProductCard(
                      product: filtered[index],
                    );
                  },
                  childCount: filtered.length,
                ),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: .68,
                ),
              ),
            ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}

// =========================
// التصنيفات
// =========================

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(left: 10),
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xff1565C0),
              size: 29,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// عنوان القسم
// =========================

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        22,
        18,
        12,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// =========================
// بطاقة المنتج
// =========================

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailsPage(
                product: product,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xffEEF3F9),
                child: Icon(
                  product.icon,
                  size: 70,
                  color: const Color(0xff1565C0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff1565C0),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.price,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// تفاصيل المنتج
// =========================

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المنتج'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: const Color(0xffEEF3F9),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              product.icon,
              size: 120,
              color: const Color(0xff1565C0),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.price,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xff1565C0),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'الوصف',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 30),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    'تم تسجيل طلبك بشكل تجريبي.',
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
            label: const Text('اطلب الآن'),
          ),
        ],
      ),
    );
  }
}

// =========================
// الخدمات
// =========================

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'الخدمات الرقمية',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'اختر الخدمة التي تريدها',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 22),

          ServiceCard(
            icon: Icons.phone_android,
            title: 'تعبئة الرصيد',
            subtitle: 'سيرياتيل و MTN وخطوط أخرى',
            onTap: () {
              _showService(context, 'تعبئة الرصيد');
            },
          ),

          ServiceCard(
            icon: Icons.sim_card,
            title: 'الرصيد التركي',
            subtitle: 'Turkcell و Vodafone و Türk Telekom',
            onTap: () {
              _showService(context, 'الرصيد التركي');
            },
          ),

          ServiceCard(
            icon: Icons.sports_esports,
            title: 'شحن الألعاب',
            subtitle: 'شحن ألعاب وتطبيقات',
            onTap: () {
              _showService(context, 'شحن الألعاب');
            },
          ),

          ServiceCard(
            icon: Icons.apps,
            title: 'شحن التطبيقات',
            subtitle: 'خدمات رقمية',
            onTap: () {
              _showService(context, 'شحن التطبيقات');
            },
          ),

          ServiceCard(
            icon: Icons.tv,
            title: 'اشتراكات الشاشة',
            subtitle: 'باقات واشتراكات',
            onTap: () {
              _showService(context, 'اشتراكات الشاشة');
            },
          ),

          ServiceCard(
            icon: Icons.build,
            title: 'صيانة الهواتف',
            subtitle: 'سوفتوير وتصليح وصيانة',
            onTap: () {
              _showService(context, 'صيانة الهواتف');
            },
          ),
        ],
      ),
    );
  }

  void _showService(
    BuildContext context,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: const Text(
          'هذه الخدمة جاهزة في الواجهة.\n\n'
          'في المرحلة القادمة سنربطها بالسيرفر '
          'ونضيف تنفيذ الطلب الحقيقي.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding:
            const EdgeInsets.all(10),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor:
              const Color(0xffE7F0FF),
          child: Icon(
            icon,
            color: const Color(0xff1565C0),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_back_ios_new,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}

// =========================
// الطلبات
// =========================

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'طلباتي',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(24),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 75,
                  color: Colors.grey,
                ),
                SizedBox(height: 15),
                Text(
                  'لا توجد طلبات حالياً',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'عند إنشاء طلب سيظهر هنا.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =========================
// الحساب
// =========================

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'حسابي',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(22),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  child: Icon(
                    Icons.person,
                    size: 35,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عميل ماهر',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'مرحباً بك في ماهر للاتصالات',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          AccountItem(
            icon: Icons.person_outline,
            title: 'بيانات الحساب',
            onTap: () {},
          ),

          AccountItem(
            icon: Icons.notifications_none,
            title: 'الإشعارات',
            onTap: () {},
          ),

          AccountItem(
            icon: Icons.language,
            title: 'اللغة',
            onTap: () {},
          ),

          AccountItem(
            icon: Icons.currency_exchange,
            title: 'العملة',
            onTap: () {},
          ),

          AccountItem(
            icon: Icons.support_agent,
            title: 'الدعم والتواصل',
            onTap: () {},
          ),

          AccountItem(
            icon: Icons.info_outline,
            title: 'حول التطبيق',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const AccountItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin:
          const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xff1565C0),
        ),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_back_ios_new,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}

// =========================
// مساعد ماهر
// =========================

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() =>
      _AssistantPageState();
}

class _AssistantPageState
    extends State<AssistantPage> {
  final TextEditingController controller =
      TextEditingController();

  String message =
      'مرحباً بك 👋\nأنا مساعد ماهر. كيف يمكنني مساعدتك؟';

  void send() {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      message =
          'استلمت رسالتك:\n\n$text\n\n'
          'سيتم ربط المساعد لاحقاً '
          'بالمنتجات والطلبات والخدمات الحقيقية.';
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 18,
        right: 18,
        top: 10,
        bottom:
            MediaQuery.of(context)
                    .viewInsets
                    .bottom +
                18,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '🤖 مساعد ماهر',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xffEEF3F9),
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: Text(
              message,
              style: const TextStyle(
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'اكتب سؤالك...',
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(16),
              ),
              suffixIcon: IconButton(
                onPressed: send,
                icon: const Icon(Icons.send),
              ),
            ),
            onSubmitted: (_) => send(),
          ),
        ],
      ),
    );
  }
}
