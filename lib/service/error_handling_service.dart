import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homework_master/main.dart';
import 'package:homework_master/service/dialog_service.dart';

class ErrorHandlingService {
  final dialogService = getIt<DialogService>();

  void handleError(dynamic error, BuildContext context) {
    if (error is FirebaseException) {
      handleFirebaseError(error, context);
    } else {
      handleGenericError(error, context);
    }
  }

  void handleFirebaseError(FirebaseException error, BuildContext context) {
    switch (error.code) {
      case 'network-error':
        dialogService.showErrorDialog(
          context,
          'ネットワークエラー',
          'インターネット接続を確認してください',
        );
        break;
      case 'permission-denied':
        dialogService.showErrorDialog(
          context,
          'アクセス拒否',
          'データへのアクセス権限がありません',
        );
        break;
      case 'disconnected':
        dialogService.showErrorDialog(
          context,
          '接続エラー',
          'データベースから切断されました\n時間をおいて再度お試しください',
        );
        break;
      case 'database-error':
        dialogService.showErrorDialog(
            context, 'データベースエラー', 'データベース操作に問題が発生しました');
        break;
      case 'data-stale':
        dialogService.showErrorDialog(
          context,
          'データ更新エラー',
          '最新のデータを取得できませんでした\n再度お試しください',
        );
        break;
      case 'operation-failed':
        dialogService.showErrorDialog(
          context,
          '操作失敗',
          'データベース操作に失敗しました\n再度お試しください',
        );
        break;
      case 'unavailable':
        dialogService.showErrorDialog(
          context,
          'サービス利用不可',
          'サービスが一時的に利用できません。しばらく待ってから再度お試しください',
        );
        break;
      case 'timeout':
        dialogService.showErrorDialog(
          context,
          'タイムアウト',
          '操作がタイムアウトしました。ネットワーク接続を確認して再度お試しください',
        );
        break;
      case 'max-retries':
        dialogService.showErrorDialog(
          context,
          '再試行回数超過',
          '操作の再試行回数が上限に達しました。しばらく待ってから再度お試しください',
        );
        break;
      case 'quota-exceeded':
        dialogService.showErrorDialog(
          context,
          '利用制限超過',
          'データベースの利用制限を超えました。しばらく待ってから再度お試しください',
        );
        break;
      default:
        dialogService.showErrorDialog(
          context,
          'Firebaseエラー',
          '予期せぬエラーが発生しました: ${error.message}',
        );
    }
  }

  void handleGenericError(dynamic error, BuildContext context) {
    dialogService.showErrorDialog(context, 'エラー発生', error.toString());
  }
}
