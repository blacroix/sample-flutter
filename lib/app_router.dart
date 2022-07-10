import 'package:auto_route/annotations.dart';
import 'package:sample/presentation/book/book_page.dart';
import 'package:sample/presentation/cart/cart_page.dart';
import 'package:sample/presentation/home/home_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(page: HomePage, initial: true),
  AutoRoute(page: BookPage),
  AutoRoute(page: CartPage),
])
class $AppRouter {}
