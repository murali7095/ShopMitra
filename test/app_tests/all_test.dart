import '../feature/authentication/domain/entitites/auth_entity_test.dart' as auth_entity;
import '../feature/authentication/domain/usecases/login_usecases_test.dart' as login_usecase;
import '../feature/authentication/data/model/auth_model_test.dart' as auth_model;
import '../feature/authentication/data/model/login_model_test.dart' as login_model;
import '../feature/authentication/data/data_source/login_datasource_test.dart' as login_data_source;
import '../feature/authentication/data/repositoty/login_repo_impl_test.dart' as login_repo_impl;
void main(){
  auth_entity.main();
  login_usecase.main();
  auth_model.main();
  login_model.main();
  login_data_source.main();
  login_repo_impl.main();
}