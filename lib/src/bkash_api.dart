import 'package:flutter_bkash/src/apis/create_agreement_api.dart';
import 'package:flutter_bkash/src/apis/pay_with_agreement_api.dart';
import 'package:flutter_bkash/src/apis/pay_without_agreement_api.dart';
import 'package:flutter_bkash/src/apis/token_api.dart';
import 'package:flutter_bkash/src/bkash_credentials.dart';
import 'package:fpdart/fpdart.dart';

import 'apis/models/create_agreement/create_agreement_response_model.dart';
import 'apis/models/create_agreement/execute_agreement_response.dart';
import 'apis/models/pay_with_agreement/pay_with_agreement_execute_response_model.dart';
import 'apis/models/pay_with_agreement/pay_with_agreement_response_model.dart';
import 'apis/models/pay_without_agreement/pay_without_agreement_execute_response_model.dart';
import 'apis/models/pay_without_agreement/pay_without_agreement_response.dart';
import 'apis/models/token_response_model.dart';
import 'utils/failure.dart';

class BkashApi {
  final BkashCredentials _bkashCredentials;

  late TokenApi _tokenApi;
  late CreateAgreementApi _createAgreementApi;
  late PayWithAgreementApi _payWithAgreementApi;
  late PayWithoutAgreementApi _payWithoutAgreementApi;

  BkashApi(this._bkashCredentials) {
    _tokenApi = TokenApi(_bkashCredentials);
    _createAgreementApi = CreateAgreementApi(_bkashCredentials);
    _payWithAgreementApi = PayWithAgreementApi(_bkashCredentials);
    _payWithoutAgreementApi = PayWithoutAgreementApi(_bkashCredentials);
  }
  // Token related
  Future<Either<Failure, TokenResponseModel>> createToken() async =>
      await _tokenApi.createToken();

  Future<Either<Failure, TokenResponseModel>> refreshToken(
          {required String refreshToken}) async =>
      await _tokenApi.refreshToken(refreshToken: refreshToken);

  // create agreement api
  Future<Either<Failure, CreateAgreementResponseModel>> createAgreement({
    required String idToken,
  }) async =>
      _createAgreementApi.createAgreement(idToken: idToken);

  Future<Either<Failure, ExecuteAgreementResponse>> executeCreateAgreement({
    required String paymentId,
    required String idToken,
  }) async =>
      _createAgreementApi.executeCreateAgreement(
        idToken: idToken,
        paymentId: paymentId,
      );

  // pay with agreement
  Future<Either<Failure, PayWithAgreementResponseModel>> payWithAgreement({
    required String idToken,
    required String amount,
    required String agreementId,
    required String marchentInvoiceNumber,
  }) async =>
      await _payWithAgreementApi.payWithAgreement(
        idToken: idToken,
        amount: amount,
        agreementId: agreementId,
        marchentInvoiceNumber: marchentInvoiceNumber,
      );

  Future<Either<Failure, PayWithAgreementExecuteResponseModel>>
      executePayWithAgreement({
    required String paymentId,
    required String idToken,
  }) async =>
          await _payWithAgreementApi.executePayWithAgreement(
            paymentId: paymentId,
            idToken: idToken,
          );

  // pay without agreement

  Future<Either<Failure, PayWithoutAgreementResponse>> payWithoutAgreement({
    required String idToken,
    required String amount,
    required String marchentInvoiceNumber,
  }) async =>
      await _payWithoutAgreementApi.payWithoutAgreement(
        idToken: idToken,
        amount: amount,
        marchentInvoiceNumber: marchentInvoiceNumber,
      );

  Future<Either<Failure, PayWithoutAgreementExecuteResponseModel>>
      executePayWithoutAgreement({
    required String paymentId,
    required String idToken,
  }) async =>
          await _payWithoutAgreementApi.executePayWithoutAgreement(
            paymentId: paymentId,
            idToken: idToken,
          );
}
