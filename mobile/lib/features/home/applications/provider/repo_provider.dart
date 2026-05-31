
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/application/provider/storage_provider.dart';
import 'package:mobile/features/home/data/repo/home_repo_impl.dart';
import 'package:mobile/features/home/domain/repo/repo.dart';

final homeRepoProvider = Provider<HomeRepo>((ref)=> HomeRepoImpl(ref.read(appStorageProvider)));