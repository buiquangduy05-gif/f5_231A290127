import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:f5_danhsach/main.dart';

void main() {
  testWidgets('Lab F5 UI smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Kiểm tra tiêu đề appBar ở tab Danh sách
    expect(find.text('Danh sách sản phẩm'), findsOneWidget);

    // Kiểm tra một sản phẩm mẫu trong danh sách
    expect(find.text('Áo thun VHU'), findsOneWidget);

    // Chuyển sang tab Lưới
    await tester.tap(find.byIcon(Icons.grid_view));
    await tester.pumpAndSettle();

    // Kiểm tra tiêu đề đổi sang Album ảnh
    expect(find.text('Album ảnh'), findsOneWidget);
  });
}
