sealed class HealthStates {}

//create health initial state
final class HealthInitialState extends HealthStates {}

//create  health record state
final class HealthRecordSLoadingtate extends HealthStates {}

final class HealthRecordSuccessState extends HealthStates {}

final class HealthRecordErrorState extends HealthStates {}
