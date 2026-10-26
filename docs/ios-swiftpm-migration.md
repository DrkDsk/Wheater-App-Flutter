# Diagnóstico y migración iOS a SwiftPM

## Entorno verificado

Flutter 3.47.8 stable, Dart 3.13.7, Xcode 27.1 (27A9275), CocoaPods 1.16.2.
Flutter doctor no reporta problemas. SwiftPM está habilitado por defecto.

## Causa raíz

El lockfile combinaba firebase_core 3.15.0 (incluye Package.swift) con
firebase_analytics 11.3.0 y firebase_messaging 15.1.0 (sin Package.swift).
Las restricciones Dart eran compatibles, pero Flutter seleccionaba SwiftPM
para Core y CocoaPods para sus consumidores, dividiendo la misma familia nativa.
No había dependency_overrides, fuentes Git, paths ni forks de Firebase.
Todos los paquetes Firebase directos proceden de pub.dev. Crashlytics,
Firestore y Auth no están instalados.

La integración SwiftPM de Xcode ya existía al comenzar: paquete local,
producto en Runner y preacción Prepare Flutter Framework. También existían
las fases, frameworks, configuraciones y lockfile de CocoaPods. La mezcla
fue producida por versiones antiguas de plugins, no por GoogleService-Info.plist.

## Solución

Se actualizaron únicamente FlutterFire y sus dependencias transitivas:
- firebase_core: 3.15.0 -> 3.15.2.
- firebase_analytics: 11.3.0 -> 11.6.0.
- firebase_messaging: 15.1.0 -> 15.2.10.

Son versiones de mantenimiento dentro de las mismas versiones mayores. Las
versiones elegidas de Analytics y Messaging requieren Core ^3.15.2 y comparten
el tag 3.15.2-firebase-core-swift. Firebase iOS permanece en 11.15.0.
No se actualizaron las demás dependencias de la aplicación.

Todos los ocho plugins nativos iOS incluyen SwiftPM: connectivity_plus,
firebase_analytics, firebase_core, firebase_messaging, flutter_timezone,
geocoding_ios, path_provider_foundation y shared_preferences_foundation.
No es necesario fallback CocoaPods ni desactivar SwiftPM.

Se ejecutó pod deintegrate, se retiraron Podfile y Podfile.lock, los includes
Pods de Debug/Release, el grupo vacío Pods y la referencia al proyecto Pods
del workspace. Se conservó Runner.xcworkspace y la integración SwiftPM.
Se añadió -ObjC en Debug/Release (Profile usa Release) para las categorías
Objective-C de Firebase Analytics. No existe Profile.xcconfig independiente.
Se retiraron también los enlaces obsoletos ios/.symlinks, sin tocar los paquetes
de la caché. Se regeneraron los archivos efímeros mediante flutter clean y flutter pub get.

## Deployment target

Runner y proyecto mantienen iOS 15.0 en Debug/Profile/Release, igual que el
paquete FlutterGeneratedPluginSwiftPackage generado. Los mínimos de los
plugins (11–13) son compatibles con el mínimo 15 de la aplicación; no deben
modificarse dentro de la caché de paquetes. Al retirar Podfile desaparece
la advertencia de plataforma implícita de CocoaPods.

## Fuentes

- https://pub.dev/packages/firebase_analytics/changelog (SwiftPM desde 11.4.0;
  11.4.3 corrige el tag del nombre de biblioteca).
- https://pub.dev/packages/firebase_messaging/changelog (SwiftPM desde 15.2.0).
- https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers
- https://github.com/firebase/firebase-ios-sdk/blob/main/SwiftPackageManager.md

## Validación

Se ejecutaron flutter --version, dart --version, xcodebuild -version,
pod --version, flutter config --list, flutter doctor -v, flutter pub outdated,
flutter pub deps --style=compact, flutter clean, flutter pub get y flutter analyze.
El análisis reporta una advertencia existente: unused_field para _repository
en lib/features/ia/ui/blocs/ia_cubit.dart:8. No se modificó Dart ajeno al problema.
project.pbxproj pasa plutil -lint y git diff --check no detecta errores.
Los Package.resolved registran una sola versión de Firebase iOS 11.15.0 y
FlutterFire compartido 3.15.2-firebase-core-swift.

Los cambios locales anteriores a esta intervención se conservaron, incluida
analysis_options.yaml, el esquema Runner y el deployment target ya actualizado.

Resultados de compilación:
- flutter build ios --debug: falla exclusivamente en firma: Xcode no tiene
  cuentas Apple ni perfiles para com.example.sinx. Bundle Identifier y Team
  se conservaron.
- flutter build ios --debug --simulator: correcto; Runner.app generado.
- flutter build ios --debug --no-codesign: correcto; Runner.app generado.
- No aparecen conflictos entre gestores Firebase, símbolos duplicados,
  frameworks Firebase duplicados, módulos ausentes o errores de resolución.

Para desplegar a un dispositivo físico hay que añadir la cuenta Apple y el
perfil de desarrollo del identificador existente en Xcode. SwiftPM queda
habilitado; no requiere una migración posterior desde CocoaPods. Una futura
actualización mayor de FlutterFire se debe evaluar por separado.

flutter run -d 00F66805-FC7F-4FA1-BB9E-A7DCBDBC5CAD --debug --no-resident
terminó correctamente (exit 0): app iniciada en iPhone 18 Pro, backend Metal
e Impeller inicializado y sincronización completada. No se probaron eventos
Analytics ni entrega de notificaciones push extremo a extremo.
