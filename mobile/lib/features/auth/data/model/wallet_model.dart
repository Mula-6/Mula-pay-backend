import 'package:json_annotation/json_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable()
class WalletModel {
  final String? id;

  @JsonKey(name: 'wallet_reference')
  final String? walletReference;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'wallet_balance')
  final String? walletBalance;

  @JsonKey(name: 'ledger_balance')
  final String? ledgerBalance;

  final String? currency;
  final String? status;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'last_update')
  final DateTime? lastUpdate;

  WalletModel({
    this.id,
    this.walletReference,
    this.userId,
    this.walletBalance,
    this.ledgerBalance,
    this.currency = "NGN",
    this.status = "active",
    this.createdAt,
    this.lastUpdate,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletModelToJson(this);
}