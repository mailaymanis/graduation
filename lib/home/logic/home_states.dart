sealed class HomeStates {}

//create home initial state
final class HomeInitialState extends HomeStates {}

//create get products states
final class GetProductsloadingState extends HomeStates {}

final class GetProductsSuccessState extends HomeStates {}

final class GetProductsErrorState extends HomeStates {}
