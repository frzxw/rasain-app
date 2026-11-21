import 'package:flutter/foundation.dart';

import '../models/community_post.dart';
import '../models/pantry_item.dart';
import '../models/recipe.dart';
import '../models/user_profile.dart';

/// Bundled Indonesian recipes, pantry items, and posts for demo mode.
class DemoData {
  static const String userId = 'demo-user';

  static UserProfile get user => UserProfile(
    id: userId,
    name: 'Fariz',
    email: 'demo@rasain.app',
    bio: 'Masak dari bahan yang masih ada di dapur.',
    savedRecipesCount: 1,
    postsCount: 1,
  );

  static String image(String file) {
    const assetPath = 'public/assets/images/';
    final full = '$assetPath$file';
    if (!kIsWeb) return full;

    final base = Uri.base;
    final directory =
        base.path.endsWith('/')
            ? base.path
            : base.path.replaceFirst(RegExp(r'[^/]*$'), '');
    final origin = base.replace(path: directory, query: '', fragment: '');
    return origin.resolve('assets/$full').toString();
  }

  static List<Recipe> recipes() {
    return [
      _recipe(
        id: 'demo-nasi-goreng',
        name: 'Nasi Goreng Kampung',
        slug: 'nasi-goreng-kampung',
        image: 'recipe/1.png',
        rating: 4.8,
        reviews: 128,
        cost: '18000',
        minutes: '20',
        servings: 2,
        difficulty: 'Mudah',
        saved: true,
        categories: const ['Makanan Utama', 'Sarapan', 'Dari Pantry'],
        description:
            'Nasi sisa semalam, telur, dan kecap. Cukup untuk makan malam tanpa belanja lagi.',
        ingredients: const [
          ['Nasi putih', '2', 'piring'],
          ['Telur', '2', 'butir'],
          ['Kecap manis', '2', 'sdm'],
          ['Bawang merah', '3', 'siung'],
          ['Cabai rawit', '4', 'buah'],
          ['Daun bawang', '1', 'batang'],
        ],
        steps: const [
          ['Iris bawang merah dan cabai. Sisihkan daun bawang.', 0],
          ['Tumis bawang sampai harum, masukkan cabai.', 3],
          ['Pecahkan telur, orak-arik, lalu masukkan nasi.', 5],
          ['Beri kecap, aduk sampai nasi panas dan berwarna rata.', 4],
          ['Taburi daun bawang. Angkat.', 0],
        ],
      ),
      _recipe(
        id: 'demo-rendang',
        name: 'Rendang Daging',
        slug: 'rendang-daging',
        image: 'recipe/2.png',
        rating: 4.9,
        reviews: 86,
        cost: '75000',
        minutes: '180',
        servings: 4,
        difficulty: 'Sulit',
        categories: const ['Makanan Utama', 'Tradisional', 'Pedas'],
        description:
            'Daging sapi dimasak lama dengan santan dan bumbu sampai bumbu meresap dan kuah mengering.',
        ingredients: const [
          ['Daging sapi', '500', 'gram'],
          ['Santan kental', '500', 'ml'],
          ['Serai', '2', 'batang'],
          ['Daun jeruk', '4', 'lembar'],
          ['Cabai merah', '8', 'buah'],
          ['Bawang merah', '6', 'siung'],
        ],
        steps: const [
          ['Haluskan cabai dan bawang. Tumis sampai wangi.', 8],
          ['Masukkan daging, aduk sampai berubah warna.', 5],
          ['Tuang santan, serai, dan daun jeruk. Masak dengan api kecil.', 120],
          ['Aduk sesekali sampai santan berminyak dan daging empuk.', 40],
        ],
      ),
      _recipe(
        id: 'demo-soto',
        name: 'Soto Lamongan',
        slug: 'soto-lamongan',
        image: 'recipe/3.png',
        rating: 4.6,
        reviews: 64,
        cost: '28000',
        minutes: '50',
        servings: 4,
        difficulty: 'Sedang',
        categories: const ['Makanan Utama', 'Tradisional', 'Dari Pantry'],
        description:
            'Kuah kuning dengan ayam suwir, telur, dan koya. Hangat, cocok saat bahan protein masih ada.',
        ingredients: const [
          ['Ayam', '400', 'gram'],
          ['Telur rebus', '2', 'butir'],
          ['Kunyit', '2', 'cm'],
          ['Serai', '1', 'batang'],
          ['Soun', '50', 'gram'],
          ['Daun bawang', '2', 'batang'],
        ],
        steps: const [
          ['Rebus ayam sampai empuk, lalu suwir. Sisihkan kaldunya.', 25],
          ['Tumis bumbu halus dengan serai sampai harum.', 6],
          ['Masukkan kaldu, masak sampai kuah berwarna kuning.', 10],
          ['Sajikan dengan soun, telur, dan daun bawang.', 0],
        ],
      ),
      _recipe(
        id: 'demo-gado',
        name: 'Gado-Gado',
        slug: 'gado-gado',
        image: 'recipe/4.png',
        rating: 4.7,
        reviews: 91,
        cost: '22000',
        minutes: '35',
        servings: 3,
        difficulty: 'Mudah',
        categories: const ['Tradisional', 'Dari Pantry'],
        description:
            'Sayuran rebus dengan saus kacang. Berguna saat kulkas isinya sisa belanjaan.',
        ingredients: const [
          ['Tahu', '2', 'potong'],
          ['Tauge', '100', 'gram'],
          ['Kacang tanah', '80', 'gram'],
          ['Cabai rawit', '3', 'buah'],
          ['Kecap manis', '1', 'sdm'],
          ['Telur rebus', '2', 'butir'],
        ],
        steps: const [
          ['Goreng tahu sampai kulitnya kokoh. Rebus telur.', 10],
          ['Haluskan kacang, cabai, dan sedikit air.', 5],
          ['Masak saus kacang dengan kecap sampai mengental.', 8],
          ['Susun sayuran dan tahu, siram saus.', 0],
        ],
      ),
      _recipe(
        id: 'demo-sate',
        name: 'Sate Madura',
        slug: 'sate-madura',
        image: 'recipe/5.png',
        rating: 4.5,
        reviews: 73,
        cost: '40000',
        minutes: '45',
        servings: 3,
        difficulty: 'Sedang',
        categories: const ['Makanan Utama', 'Pedas'],
        description:
            'Tusukan daging dengan bumbu kacang yang lebih manis. Panggang sampai pinggirannya kering.',
        ingredients: const [
          ['Daging sapi', '300', 'gram'],
          ['Kecap manis', '3', 'sdm'],
          ['Kacang tanah', '100', 'gram'],
          ['Bawang merah', '4', 'siung'],
          ['Cabai merah', '3', 'buah'],
        ],
        steps: const [
          ['Potong daging, rendam dengan kecap.', 15],
          ['Tusuk daging, panggang sambil dioles kecap.', 12],
          ['Haluskan kacang dan cabai untuk saus.', 8],
          ['Sajikan sate dengan saus dan bawang iris.', 0],
        ],
      ),
      _recipe(
        id: 'demo-martabak',
        name: 'Martabak Manis',
        slug: 'martabak-manis',
        image: 'recipe/6.png',
        rating: 4.4,
        reviews: 52,
        cost: '20000',
        minutes: '40',
        servings: 6,
        difficulty: 'Sedang',
        categories: const ['Jajanan', 'Resep Saya'],
        description:
            'Kue tebal dengan meses dan susu kental manis. Resep yang disimpan di profil demo.',
        ingredients: const [
          ['Tepung terigu', '200', 'gram'],
          ['Telur', '2', 'butir'],
          ['Gula pasir', '50', 'gram'],
          ['Susu cair', '200', 'ml'],
          ['Meses', '40', 'gram'],
        ],
        steps: const [
          ['Kocok telur dan gula, masukkan tepung dan susu.', 5],
          ['Diamkan adonan sampai muncul gelembung.', 20],
          ['Panggang di teflon tertutup sampai matang.', 8],
          ['Oles margarin, taburi meses, lipat.', 0],
        ],
      ),
      _recipe(
        id: 'demo-bakso',
        name: 'Bakso Sapi',
        slug: 'bakso-sapi',
        image: 'recipe/7.png',
        rating: 4.6,
        reviews: 110,
        cost: '32000',
        minutes: '60',
        servings: 4,
        difficulty: 'Sedang',
        categories: const ['Makanan Utama', 'Tradisional'],
        description:
            'Bola daging dengan kuah kaldu bening. Butuh waktu giling, hasilnya cukup untuk beberapa mangkuk.',
        ingredients: const [
          ['Daging sapi giling', '300', 'gram'],
          ['Tepung tapioka', '40', 'gram'],
          ['Bawang putih', '3', 'siung'],
          ['Kaldu sapi', '1', 'liter'],
          ['Mie kuning', '200', 'gram'],
        ],
        steps: const [
          ['Campur daging, tapioka, dan bawang. Uleni sampai lengket.', 10],
          ['Bentuk bola, rebus dalam air mendidih sampai mengapung.', 15],
          ['Didihkan kaldu, masukkan bakso dan mie.', 8],
        ],
      ),
    ];
  }

  static Recipe? recipeByIdOrSlug(String identifier) {
    for (final recipe in recipes()) {
      if (recipe.id == identifier || recipe.slug == identifier) return recipe;
    }
    return null;
  }

  static List<Recipe> matchingCategory(String category) {
    if (category == 'All' || category == 'Semua') return recipes();
    return recipes()
        .where((recipe) => recipe.categories?.contains(category) ?? false)
        .toList();
  }

  static List<Recipe> search(String query) {
    final term = query.trim().toLowerCase();
    if (term.isEmpty) return recipes();
    return recipes()
        .where((recipe) => recipe.name.toLowerCase().contains(term))
        .toList();
  }

  static const List<String> categories = [
    'All',
    'Makanan Utama',
    'Tradisional',
    'Pedas',
    'Sarapan',
    'Jajanan',
    'Dari Pantry',
  ];

  static final List<PantryItem> pantryItems = [
    PantryItem(
      id: 'pantry-telur',
      userId: userId,
      name: 'Telur',
      imageUrl: null,
      quantity: '6',
      unit: 'butir',
      category: 'Protein',
      storageLocation: 'Kulkas',
      totalQuantity: 10,
      lowStockAlert: true,
      expirationAlert: true,
      expirationDate: null,
    ),
    PantryItem(
      id: 'pantry-nasi',
      userId: userId,
      name: 'Nasi putih',
      quantity: '4',
      unit: 'piring',
      category: 'Karbohidrat',
      storageLocation: 'Kulkas',
      totalQuantity: 4,
      lowStockAlert: false,
      expirationAlert: true,
    ),
    PantryItem(
      id: 'pantry-kecap',
      userId: userId,
      name: 'Kecap manis',
      quantity: '1',
      unit: 'botol',
      category: 'Bumbu',
      storageLocation: 'Rak bumbu',
      totalQuantity: 1,
      lowStockAlert: false,
      expirationAlert: false,
    ),
    PantryItem(
      id: 'pantry-cabai',
      userId: userId,
      name: 'Cabai rawit',
      quantity: '8',
      unit: 'buah',
      category: 'Sayur',
      storageLocation: 'Kulkas',
      totalQuantity: 20,
      lowStockAlert: true,
      expirationAlert: true,
      expirationDate: DateTime.now().add(const Duration(days: 2)),
    ),
    PantryItem(
      id: 'pantry-tahu',
      userId: userId,
      name: 'Tahu',
      quantity: '4',
      unit: 'potong',
      category: 'Protein',
      storageLocation: 'Kulkas',
      totalQuantity: 8,
      lowStockAlert: false,
      expirationAlert: true,
      expirationDate: DateTime.now().add(const Duration(days: 1)),
    ),
    PantryItem(
      id: 'pantry-bawang',
      userId: userId,
      name: 'Bawang merah',
      quantity: '5',
      unit: 'siung',
      category: 'Bumbu',
      storageLocation: 'Rak bumbu',
      totalQuantity: 10,
      lowStockAlert: true,
      expirationAlert: false,
    ),
  ];

  static List<PantryItem> pantrySnapshot() {
    return List<PantryItem>.from(pantryItems);
  }

  static PantryItem addPantryItem(PantryItem item) {
    final stored = PantryItem(
      id: item.id.isEmpty ? 'pantry-${pantryItems.length + 1}' : item.id,
      userId: userId,
      name: item.name,
      imageUrl: item.imageUrl,
      quantity: item.quantity,
      expirationDate: item.expirationDate,
      price: item.price,
      unit: item.unit,
      category: item.category,
      storageLocation: item.storageLocation,
      totalQuantity: item.totalQuantity,
      lowStockAlert: item.lowStockAlert,
      expirationAlert: item.expirationAlert,
      purchaseDate: item.purchaseDate,
      lastUsedDate: item.lastUsedDate,
      notes: item.notes,
    );
    pantryItems.add(stored);
    return stored;
  }

  static PantryItem? updatePantryItem(PantryItem item) {
    final index = pantryItems.indexWhere((entry) => entry.id == item.id);
    if (index == -1) return null;
    pantryItems[index] = item;
    return item;
  }

  static bool deletePantryItem(String id) {
    final before = pantryItems.length;
    pantryItems.removeWhere((item) => item.id == id);
    return pantryItems.length != before;
  }

  static const List<String> kitchenTools = [
    'Wajan',
    'Panci',
    'Pisau',
    'Talenan',
    'Rice Cooker',
    'Serok',
  ];

  static List<CommunityPost> posts() {
    final now = DateTime.now();
    return [
      CommunityPost(
        id: 'post-nasi',
        userId: userId,
        userName: 'Fariz',
        timestamp: now.subtract(const Duration(hours: 5)),
        title: 'Nasi goreng dari sisa semalam',
        content:
            'Telur dan kecap di kulkas sudah cukup. Tidak sempat ke pasar, dan nasinya habis.',
        imageUrl: image('community/1.png'),
        category: 'Kreasi',
        likeCount: 18,
        commentCount: 3,
      ),
      CommunityPost(
        id: 'post-rendang',
        userId: 'demo-hasbi',
        userName: 'Hasbi',
        timestamp: now.subtract(const Duration(days: 1, hours: 2)),
        title: 'Rendang jangan buru-buru',
        content:
            'Api kecil, dan diaduk kalau santan mulai mengendap. Dagingnya lebih empuk setelah satu jam terakhir.',
        imageUrl: image('community/2.png'),
        category: 'Tips dan Trik',
        likeCount: 24,
        commentCount: 6,
      ),
      CommunityPost(
        id: 'post-gado',
        userId: 'demo-bintang',
        userName: 'Bintang',
        timestamp: now.subtract(const Duration(days: 2)),
        title: 'Gado-gado untuk makan siang',
        content:
            'Tahu dan tauge yang hampir habis. Saus kacang dibuat sedikit lebih encer supaya sayurnya terasa.',
        imageUrl: image('community/3.png'),
        category: 'Review',
        likeCount: 11,
        commentCount: 2,
      ),
    ];
  }

  static const List<String> postCategories = [
    'Semua',
    'Kreasi',
    'Review',
    'Tips dan Trik',
  ];

  static final Map<String, List<Map<String, dynamic>>> _reviews = {
    'demo-nasi-goreng': [
      {
        'id': 'review-1',
        'recipe_id': 'demo-nasi-goreng',
        'user_id': 'demo-putra',
        'user_name': 'Putra',
        'rating': 5.0,
        'comment': 'Kecapnya pas. Telurnya jangan digoreng terlalu kering.',
        'date': '2026-06-02T10:00:00.000',
      },
      {
        'id': 'review-2',
        'recipe_id': 'demo-nasi-goreng',
        'user_id': 'demo-hasbi',
        'user_name': 'Hasbi',
        'rating': 4.0,
        'comment': 'Cepat, dan nasinya tidak menggumpal.',
        'date': '2026-05-18T08:30:00.000',
      },
    ],
    'demo-rendang': [
      {
        'id': 'review-3',
        'recipe_id': 'demo-rendang',
        'user_id': 'demo-bintang',
        'user_name': 'Bintang',
        'rating': 5.0,
        'comment': 'Butuh kesabaran, tapi bumbunya meresap.',
        'date': '2026-04-11T14:00:00.000',
      },
    ],
  };

  static List<Map<String, dynamic>> reviewsFor(String recipeId) {
    return (_reviews[recipeId] ?? const <Map<String, dynamic>>[])
        .map((review) => Map<String, dynamic>.from(review))
        .toList();
  }

  static void addReview({
    required String recipeId,
    required double rating,
    required String comment,
  }) {
    final list = _reviews.putIfAbsent(recipeId, () => []);
    list.insert(0, {
      'id': 'review-${DateTime.now().millisecondsSinceEpoch}',
      'recipe_id': recipeId,
      'user_id': userId,
      'user_name': 'Fariz',
      'rating': rating,
      'comment': comment,
      'date': DateTime.now().toIso8601String(),
    });
  }

  static Recipe _recipe({
    required String id,
    required String name,
    required String slug,
    required String image,
    required double rating,
    required int reviews,
    required String cost,
    required String minutes,
    required int servings,
    required String difficulty,
    required List<String> categories,
    required String description,
    required List<List<String>> ingredients,
    required List<List<Object>> steps,
    bool saved = false,
  }) {
    return Recipe(
      id: id,
      name: name,
      slug: slug,
      imageUrl: image.startsWith('recipe/') ? imageUrl(image) : image,
      rating: rating,
      reviewCount: reviews,
      estimatedCost: cost,
      cookTime: minutes,
      servings: servings,
      difficultyLevel: difficulty,
      description: description,
      categories: categories,
      isSaved: saved,
      ingredients: [
        for (final item in ingredients)
          {'name': item[0], 'quantity': item[1], 'unit': item[2]},
      ],
      instructions: [
        for (var i = 0; i < steps.length; i++)
          {
            'text': steps[i][0],
            'step_number': i + 1,
            'timer_minutes':
                (steps[i][1] as int) == 0 ? null : steps[i][1] as int,
          },
      ],
    );
  }

  static String imageUrl(String file) => image(file);
}
