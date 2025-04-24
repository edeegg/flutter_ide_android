import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/sdk_version.dart';
import '../../domain/usecases/get_android_sdk_versions.dart';
import '../../domain/usecases/get_sdk_versions.dart';

enum OnboardingStep { installApps, storage, sdkSelection }

class OnboardingProvider extends ChangeNotifier {
  final GetSdkVersions getSdkVersions;
  final GetAndroidSdkVersions getAndroidSdkVersions;
  final NetworkInfo networkInfo;

  OnboardingStep currentStep = OnboardingStep.installApps;
  bool installPermissionGranted = false;
  bool storagePermissionGranted = false;
  bool isLoadingSdk = false;
  List<SdkVersion> sdkVersions = [];
  List<SdkVersion> androidSdkVersions = [];
  SdkVersion? selectedVersion;
  SdkVersion? selectedAndroidVersion;
  bool hasInternet = false;
  String? errorMessage;

  OnboardingProvider({
    required this.getSdkVersions,
    required this.getAndroidSdkVersions,
    required this.networkInfo,
  }) {
    networkInfo.onConnectivityChanged.listen((status) {
      hasInternet = status;
      notifyListeners();
    });
    init();
  }

  Future<void> init() async {
    checkPermissions();
    await loadSdkVersions();
    await loadAndroidSdkVersions();
    hasInternet = await networkInfo.isConnected;
  }

  Future<void> requestInstallPermission() async {
    // Em Android, pedir permissão de instalar fontes desconhecidas não é direto via permission_handler.
    // Suponha que usemos um método nativo. Aqui simulamos:
    final status = await Permission.requestInstallPackages.request();
    installPermissionGranted = status.isGranted;
    // installPermissionGranted = true;
    if (!installPermissionGranted) {
      errorMessage = 'Por favor, permita instalação de apps';
    } else {
      errorMessage = null;
      currentStep = OnboardingStep.storage;
    }
    notifyListeners();
  }

  Future<void> requestStoragePermission() async {
    final status = await Permission.manageExternalStorage.request();
    storagePermissionGranted = status.isGranted;
    if (!storagePermissionGranted) {
      errorMessage = 'Por favor, permita gerenciamento de armazenamento';
    } else {
      errorMessage = null;
      currentStep = OnboardingStep.sdkSelection;
    }
    notifyListeners();
  }

  Future<void> loadSdkVersions() async {
    isLoadingSdk = true;
    notifyListeners();
    final result = await getSdkVersions.call(NoParams());

    result.fold(
      (fail) => errorMessage = fail.message,
      (list) {
        selectedVersion = list.firstOrNull;
        sdkVersions = list;
      },
    );
    // print(result.fold(ifLeft, ifRight));
    isLoadingSdk = false;
    notifyListeners();
  }

  Future<void> loadAndroidSdkVersions() async {
    isLoadingSdk = true;
    notifyListeners();
    final result = await getAndroidSdkVersions.call(NoParams());

    result.fold(
      (fail) => errorMessage = fail.message,
      (list) {
        selectedAndroidVersion = list.firstOrNull;
        androidSdkVersions = list;
      },
    );
    // print(result.fold(ifLeft, ifRight));
    isLoadingSdk = false;
    notifyListeners();
  }

  // Função para verificar as permissões
  Future<void> checkPermissions() async {
    PermissionStatus storageStatus =
        await Permission.manageExternalStorage.status;
    PermissionStatus installStatus =
        await Permission.requestInstallPackages.status;

    storagePermissionGranted = storageStatus.isGranted;
    installPermissionGranted = installStatus.isGranted;
    notifyListeners();
  }

  void selectVersion(SdkVersion v) {
    selectedVersion = v;
    notifyListeners();
  }

  void selectAndroidVersion(SdkVersion v) {
    selectedAndroidVersion = v;
    notifyListeners();
  }

  bool canComplete() => selectedVersion != null && hasInternet;
}
