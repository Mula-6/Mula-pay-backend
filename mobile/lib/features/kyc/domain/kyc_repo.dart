import '../../../core/data/model/model.dart';

abstract class KycRepo {
  Future<DefaultApiResponse<Null>?> addBVn({ required String bvn });
  Future<DefaultApiResponse<Null>?> addAddress({ required String address });
  Future<DefaultApiResponse<Null>?> addProfileUrl({ required String profile });
  Future<DefaultApiResponse<Null>?> addDateOfBirth({ required String dob });
  Future<DefaultApiResponse<Null>?> addPhoneNumber({ required String phone });
  Future<DefaultApiResponse<Null>?> submit();
}
