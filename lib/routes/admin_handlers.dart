import 'package:delivery/service/auth_service.dart';
import 'package:delivery/service/permission_status.dart';
import 'package:delivery/views/allow_gps_permission.dart';
import 'package:delivery/views/autentificar_celular.dart';
import 'package:delivery/views/confirmar_codigo.dart';
import 'package:delivery/views/dashboard_view.dart';
import 'package:delivery/views/gps_disable_view.dart';
import 'package:delivery/views/register_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authService = Provider.of<AuthService>(context!);
    final permissionService = Provider.of<PermissionStatusProvider>(context);
    if (authService.authStatus == AuthStatus.notAuthenticated) {
      return const AutentificarCelular();
    } else {
      if (permissionService.isGranted) {
        if (permissionService.isEnabled) {
          return const DashboardView();
        } else {
          return const GpsDisableView();
        }
      } else {
        return const AllowGpsPermissionView();
      }
    }
  });
  static Handler autentificarPhone = Handler(handlerFunc: (context, params) {
    final authService = Provider.of<AuthService>(context!);
    final permissionService = Provider.of<PermissionStatusProvider>(context);
    if (authService.authStatus == AuthStatus.notAuthenticated) {
      /* return const LoginView();*/
      return const AutentificarCelular();
    } else {
      if (permissionService.isGranted) {
        if (permissionService.isEnabled) {
          return const DashboardView();
        } else {
          return const GpsDisableView();
        }
      } else {
        return const AllowGpsPermissionView();
      }
    }
  });
  static Handler confirmarPhone = Handler(handlerFunc: (context, params) {
    final authService = Provider.of<AuthService>(context!);
    final permissionService = Provider.of<PermissionStatusProvider>(context);
    if (authService.authStatus == AuthStatus.notAuthenticated) {
      return ConfirmarCodigo(numero: params['numero']![0]);
    } else {
      if (permissionService.isGranted) {
        if (permissionService.isEnabled) {
          return const DashboardView();
        } else {
          return const GpsDisableView();
        }
      } else {
        return const AllowGpsPermissionView();
      }
    }
  });

  static Handler register = Handler(handlerFunc: (context, params) {
    final authService = Provider.of<AuthService>(context!);
    if (authService.authStatus == AuthStatus.notAuthenticated) {
      return RegisterView(
        numero: params['numero']![0],
      );
    } else {
      return const DashboardView();
    }
  });
}
