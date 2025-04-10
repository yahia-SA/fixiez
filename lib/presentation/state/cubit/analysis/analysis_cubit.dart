import 'package:equatable/equatable.dart';
import 'package:fixiez/data/models/analtyis_model.dart';
import 'package:fixiez/domain/usecases/admin/analysis/analysis_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'analysis_state.dart';

class AnalysisCubit extends Cubit<AnalysisState> {
  AnalysisCubit(this.analysisAdminUseCase) : super(AnalysisInitial());
  final AnalysisAdminUseCase analysisAdminUseCase;
  Future<void> getAnalysis() async {
    emit(AnalysisLoading());
    try {
      final analysis = await analysisAdminUseCase.call();
      emit(
        AnalysisSuccess(
          repairRequestResult: analysis.data!.repairRequestResult,
          userResult: analysis.data!.userResult,
        ),
      );
    } catch (e) {
      emit(AnalysisFailure(e.toString()));
    }
  }
}
