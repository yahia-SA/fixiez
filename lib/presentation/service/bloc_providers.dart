import 'package:fixiez/presentation/service/injection_container.dart';
// import 'package:fixiez/presentation/state/bloc/forget_password/forget_password_bloc.dart';
// import 'package:fixiez/presentation/state/bloc/login/login_bloc.dart';
// import 'package:fixiez/presentation/state/bloc/otp/otp_bloc.dart';
// import 'package:fixiez/presentation/state/bloc/profile/profile_bloc.dart';
// import 'package:fixiez/presentation/state/bloc/resetPassword/reset_password_bloc.dart';
// import 'package:fixiez/presentation/state/bloc/signup/signup_bloc.dart';
import 'package:fixiez/presentation/state/cubit/Services/service_cubit.dart';
import 'package:fixiez/presentation/state/cubit/analysis/analysis_cubit.dart';
import 'package:fixiez/presentation/state/cubit/banner/banner_cubit.dart';
import 'package:fixiez/presentation/state/cubit/felix/felix_cubit.dart';
import 'package:fixiez/presentation/state/cubit/repair_admin/repair_admin_cubit.dart';
// import 'package:fixiez/presentation/state/cubit/repair_user/repair_cubit.dart';
// import 'package:fixiez/presentation/state/cubit/review/review_cubit.dart';
import 'package:fixiez/presentation/state/cubit/users/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProvidersList extends StatelessWidget {
  const BlocProvidersList({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<BannerCubit>()),
        BlocProvider(create: (context) => sl<ServiceCubit>()),
        BlocProvider(create: (context) => sl<UsersCubit>()),
        BlocProvider(create: (context) => sl<RepairAdminCubit>()),
        BlocProvider(create: (context) => sl<FelixCubit>()),
        BlocProvider(create: (context) => sl<AnalysisCubit>()),
        // BlocProvider(create: (_) => sl<LoginBloc>()),
        // BlocProvider(create: (_) => sl<SignupBloc>()),
        // BlocProvider(create: (_) => sl<OtpBloc>()),
        // BlocProvider(create: (_) => sl<RepairCubit>()),
        // BlocProvider(create: (_) => sl<ResetPasswordBloc>()),
        // BlocProvider(create: (_) => sl<ForgetpasswordBloc>()),
        // BlocProvider(create: (_) => sl<ProfileBloc>()),
        // BlocProvider(create: (_) => sl<ReviewCubit>()),
        // BlocProvider(create: (_) => sl<BannerCubit>()),
        // BlocProvider(create: (_) => sl<ServiceCubit>()),
        // BlocProvider(create: (_) => sl<UsersCubit>()),
        // BlocProvider(create: (_) => sl<RepairAdminCubit>()),
        // BlocProvider(create: (_) => sl<FelixCubit>()),
        // BlocProvider(create: (_) => sl<AnalysisCubit>()),
      ],
      child: child,
    );
  }
}
