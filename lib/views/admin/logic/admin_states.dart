sealed class AdminStates {}

//create admin initial state
final class AdminInitialState extends AdminStates {}

//create admin states
final class BudgetLoadingState extends AdminStates {}

final class BudgetSuccessState extends AdminStates {}

final class BudgetErrorState extends AdminStates {}
