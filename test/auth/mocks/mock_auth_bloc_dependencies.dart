import 'package:clima_link/domain/usecases/auth_usecase.dart';
import 'package:clima_link/ui/shared/service/service.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthUseCase extends Mock implements AuthUseCase {}

class MockKeyValueStorageService extends Mock
    implements KeyValueStorageService {}
