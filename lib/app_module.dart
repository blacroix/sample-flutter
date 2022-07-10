import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sample/data/library_repository.dart';
import 'package:sample/domain/cart_usecase.dart';
import 'package:sample/domain/driving/request_price.dart';
import 'package:sample/domain/library_usecase.dart';
import 'package:sample/injection.dart';

import 'app_router.gr.dart';
import 'data/library_client_api.dart';
import 'domain/driving/add_book.dart';
import 'domain/driving/request_books.dart';

@module
abstract class DataModule {
  @singleton
  LibraryClientApi get libraryClientApi => LibraryClientApi(Dio());
}

@module
abstract class DomainModule {
  @injectable
  LibraryUsecase get libraryUsecase => LibraryUsecase(getIt<LibraryRepository>());

  @injectable
  RequestBooks get requestsBooks => getIt<LibraryUsecase>();

  @injectable
  CartUsecase get cartUsecase => CartUsecase(getIt<LibraryRepository>());

  @injectable
  AddBook get addBook => getIt<CartUsecase>();

  @injectable
  RequestPrice get requestPrice => getIt<CartUsecase>();
}

@module
abstract class AppModule {
  @singleton
  AppRouter get router => AppRouter();
}
