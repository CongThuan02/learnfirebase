import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_strategy/url_strategy.dart';

import 'common/configs/init.dart';
import 'common/routers/factory_routes_singleton.dart';
import 'firebase_options.dart';
import 'presentation/controllers/loading_controller/loading_controller_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initApp();
  setPathUrlStrategy();
  startApp();
}

void startApp() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoadingControllerCubit>(
        create: (BuildContext context) => LoadingControllerCubit(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = FactoryNavRoutesSingleton().items;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (_, orientation) {
      return ScreenUtilInit(
        designSize: orientation == Orientation.portrait ? const Size(411, 823) : const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, child) {
          return MaterialApp.router(
            routerConfig: _router,
            title: "MyApp",
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('vi', ''),
            ],
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
            ),
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: SafeArea(
                  top: false,
                  bottom: false,
                  left: false,
                  right: false,
                  child: widget ?? Container(),
                ),
              );
            },
          );
        },
      );
    });
  }
}
