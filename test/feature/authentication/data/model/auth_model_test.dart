import 'package:flutter_test/flutter_test.dart';
import 'package:shop_mitra/feature/authentication/data/model/auth_model.dart';
import 'package:shop_mitra/feature/authentication/domain/entitites/auth_entity.dart';

void main() {
  late AuthModel authModel;
  setUp(() {
      authModel = AuthModel(idToken: "Absjbjsbdjsd", email: "test@gmail.com", refreshToken: "shdvsdj", expiresIn: "234", localId: "lbdhsvfys", registered: true);
  },);

  test('Should create AuthModel with valid values', () {
     expect(authModel, isA<AuthModel>());
     expect(authModel.email, "test@gmail.com");
  });

  test('should create AuthModel with valid values', () {
    expect(authModel, isA<AuthModel>());
    expect(authModel, isA<AuthEntity>());
    expect(authModel.email, "test@gmail.com");
  });

  test("AuthModel should give default values when the fromJson object is null",   () {
    final data = AuthModel.fromJson(null);
    expect(data.email,  '');
    expect(data.registered, false);
  },);
  test("AuthModel.fromJson should return data when we have valid jsonData",  () {
    final userData = {
      "kind": "idenytoolkit#VerifyPasswordResponse",
      "localId": "Hv75JkNYSWAKOFzp2",
      "email": "test@gmail.com",
      "displayName": "",
      "idToken": " jMzIxOTYzg2Y2U3YjU1MzhmMTdiZTEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc2hvcC1taXRyYS0zMzk5ZiIsImF1ZCI6InNob3AtbWl0cmEtMzM5OWYiLCJhdXRoX3RpbWUiOjE3Njk3NjM4NDEsInVzZXJfaWQiOiJIbGRpa1RINHpXZDd2NzVKa05ZU1dBS09GenAyIiwic3ViIjoiSGxkaWtUSDR6V2Q3djc1SmtOWVNXQUtPRnpwMiIsImlhdCI6MTc2OTc2Mzg0MSwiZXhwIjoxNzY5NzY3NDQxLCJlbWFpbCI6Im11cmFsaUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibXVyYWxpQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.u8TUYf6DbKZeAOss_v0A_ZCwfxIvlbgZvTuScP7JxuRIF8gXYotBulhuYj47PoGizfclSGSe8wf82hc7QokbySlj-0V-SqfV4PNVB9lTf6uNLM-NjAQoOJ72bayDPM2MeKRo_xGmkkrhNpdrlDbuSX-05yF28VazpHoY3cqGmRLiS_NndbXQQmf6XU2HceFibjJLMb4kEtcBxabCJBKTBai4sDgoJBfEwy1hMflCtO9FCPqmiLs0Q_A8efGW6vh7CKxvHMWJGTdrCg90vddQHP79nicWOh2nDcjWmxQnAMILDsU58FWM3rmOmWbdVEdasw-BITHYgPzAsDvpPloxMQ",
      "registered": true,
      "refreshToken": "rszuBAJoVB1HYMr45TkVFc-RpVv0Hl1ZuxP8kh_QwIHM90mYobV6XIQzyfN158vDtwycCTAsgPyR4bVIMg-g2xIevuUKZjgFSpD16zNOnwYwOy3I3t6Vu8xoJ1QxYZaEr2pjUzu-Rnrdjazp0yegydRgvM6DIzad5q7ORc6Q_RJmlvx85FDtnHJA",
      "expiresIn": "3600"
    };
    final model = AuthModel.fromJson(userData);
    expect(model.registered, true);
    expect(model.email, "test@gmail.com");
    expect(model.expiresIn, "3600");
  },);


}