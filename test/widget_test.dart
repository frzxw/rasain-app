import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rasain_app/demo/demo_data.dart';
import 'package:rasain_app/features/welcome_screen/welcome_screen.dart';

void main() {
  test('demo catalog includes a pantry recipe and a saved recipe', () {
    final recipes = DemoData.recipes();
    expect(recipes, isNotEmpty);
    expect(
      DemoData.recipeByIdOrSlug('nasi-goreng-kampung')?.name,
      'Nasi Goreng Kampung',
    );
    expect(recipes.where((recipe) => recipe.isSaved), isNotEmpty);
    expect(
      recipes.where(
        (recipe) => recipe.categories?.contains('Dari Pantry') ?? false,
      ),
      isNotEmpty,
    );
    expect(DemoData.pantryItems, isNotEmpty);
    expect(DemoData.search('rendang').single.name, 'Rendang Daging');
    expect(DemoData.posts(), isNotEmpty);
  });

  test('demo reviews stay attached to one recipe', () {
    final before = DemoData.reviewsFor('demo-rendang').length;
    DemoData.addReview(
      recipeId: 'demo-rendang',
      rating: 4,
      comment: 'Empuk.',
    );
    expect(DemoData.reviewsFor('demo-rendang').length, before + 1);
    expect(
      DemoData.reviewsFor('demo-nasi-goreng').any(
        (review) => review['comment'] == 'Empuk.',
      ),
      isFalse,
    );
  });

  testWidgets('welcome screen names the app', (tester) async {
    tester.view.physicalSize = const Size(1400, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));
    await tester.pump();

    expect(find.text('Rasain App'), findsOneWidget);
    expect(find.text('Masakan Indonesia, dari dapur kamu'), findsOneWidget);
    expect(find.textContaining('Kelompok'), findsNothing);
  });
}
