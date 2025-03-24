part of 'repair_cubit.dart';

class RepairFormData extends Equatable {
  const RepairFormData({
    this.location,
    this.unitNumber,
    this.description,
    this.serviceName,
    this.serviceType,
    this.date,
  });
  final String? location;
  final String? unitNumber;
  final String? description;
  final ServiceName? serviceName;
  final ServiceType? serviceType;
  final String? date;

  RepairFormData copyWith({
    String? location,
    String? unitNumber,
    String? description,
    ServiceName? serviceName,
    ServiceType? serviceType,
    String? date,
  }) {
    return RepairFormData(
      location: location ?? this.location,
      unitNumber: unitNumber ?? this.unitNumber,
      description: description ?? this.description,
      serviceName: serviceName ?? this.serviceName,
      serviceType: serviceType ?? this.serviceType,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [
    location,
    unitNumber,
    description,
    serviceName,
    serviceType,
    date,
  ];
}

// 2. Fix state classes
sealed class RepairState extends Equatable {
  const RepairState(this.formData);
  final RepairFormData formData;

  @override
  List<Object> get props => [formData];
}

final class RepairInitial extends RepairState {
  const RepairInitial(super.formData);
}

final class RepairLoading extends RepairState {
  const RepairLoading(super.formData);
}

final class RepairSuccess extends RepairState {
  const RepairSuccess(super.formData);
}

final class RepairFailure extends RepairState {
  const RepairFailure(super.formData, this.message);
  final String message;

  @override
  List<Object> get props => [message, ...super.props];
}
