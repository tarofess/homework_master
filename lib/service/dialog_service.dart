import 'package:flutter/material.dart';
import 'package:homework_master/view/widget/loading_overlay.dart';

class DialogService {
  Future<String?> showNameRegistrationDialog(BuildContext context) async {
    final TextEditingController textController = TextEditingController();
    return await showInputTextDialogBase(
      context: context,
      title: '名前を登録',
      hintText: '名前を入力してください',
      okButtonText: '登録',
      cancelButtonText: 'キャンセル',
      textController: textController,
      handleOKButtonPress: (dialogContext) =>
          Navigator.of(dialogContext).pop(textController.text),
      handleCancelButtonPress: (dialogContext) =>
          Navigator.of(dialogContext).pop(null),
    );
  }

  Future<String?> showEnterRoomNameDialog(BuildContext context,
      Future<bool> Function(String roomName) handleEnterRoom) async {
    final TextEditingController textController = TextEditingController();
    return await showInputTextDialogBase(
        context: context,
        title: '入室',
        hintText: 'ルーム名を入力してください',
        okButtonText: '送信',
        cancelButtonText: 'キャンセル',
        textController: TextEditingController(),
        handleOKButtonPress: (dialogContext) async {
          final isSuccess = await LoadingOverlay.of(dialogContext)
              .during(() => handleEnterRoom(textController.text));
          if (isSuccess) {
            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(textController.text);
            }
          } else {
            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop('');
            }
          }
        },
        handleCancelButtonPress: (dialogContext) =>
            Navigator.of(dialogContext).pop(null));
  }

  Future<String> showMakeRoomDialog(
      BuildContext context, Future<String> Function() handleMakeRoom) async {
    final result = await showConfirmationDialogBase(
      context: context,
      title: '部屋の作成',
      content: '新しく部屋を作成しますか？',
      okButtonText: '作成する',
      cancelButtonText: 'いいえ',
      handleOKButtonPress: (dialogContext) async {
        final roomID = await LoadingOverlay.of(dialogContext)
            .during(() => handleMakeRoom());
        if (dialogContext.mounted) Navigator.of(dialogContext).pop(roomID);
      },
      handleCancelButtonPress: (dialogContext) =>
          Navigator.of(dialogContext).pop(''),
    );
    return result ?? '';
  }

  Future<bool> showConfirmationDialog(
      BuildContext context, String title, String content) async {
    final result = await showConfirmationDialogBase(
      context: context,
      title: title,
      content: content,
      okButtonText: 'はい',
      cancelButtonText: 'いいえ',
      handleOKButtonPress: (dialogContext) =>
          Navigator.of(dialogContext).pop(true),
      handleCancelButtonPress: (dialogContext) =>
          Navigator.of(dialogContext).pop(false),
    );
    return result ?? false;
  }

  Future<bool> showLeaveDialog(
      BuildContext context, String message, Function() leaveAction) async {
    final result = await showConfirmationDialogBase(
      context: context,
      title: '確認',
      content: message,
      okButtonText: 'はい',
      cancelButtonText: 'いいえ',
      handleOKButtonPress: (dialogContext) async {
        await LoadingOverlay.of(dialogContext).during(() => leaveAction());
        if (dialogContext.mounted) Navigator.of(dialogContext).pop(true);
      },
      handleCancelButtonPress: (dialogContext) =>
          Navigator.of(dialogContext).pop(false),
    );
    return result ?? false;
  }

  Future<void> showErrorDialog(BuildContext context, String message) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('エラーが発生しました'),
          content: Text(message),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'はい',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String?> showInputTextDialogBase({
    required BuildContext context,
    required String title,
    String? hintText,
    required String okButtonText,
    required String cancelButtonText,
    required TextEditingController textController,
    required Function(BuildContext dialogContext) handleOKButtonPress,
    required Function(BuildContext dialogContext) handleCancelButtonPress,
  }) async {
    bool isButtonEnabled = false;

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      textAlign: TextAlign.center,
                      controller: textController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        hintText: hintText ?? '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        setState(() {
                          isButtonEnabled = value.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () => handleCancelButtonPress(context),
                        child: Text(
                          cancelButtonText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: isButtonEnabled
                            ? () async => await handleOKButtonPress(context)
                            : null,
                        child: Text(
                          okButtonText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<T?> showConfirmationDialogBase<T>({
    required BuildContext context,
    required String title,
    required String content,
    required String okButtonText,
    required String cancelButtonText,
    required Function(BuildContext dialogContext) handleOKButtonPress,
    required Function(BuildContext dialogContext) handleCancelButtonPress,
  }) async {
    return await showDialog<T?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          content: Text(content),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () => handleCancelButtonPress(context),
                    child: Text(
                      cancelButtonText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () async => await handleOKButtonPress(context),
                    child: Text(
                      okButtonText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
