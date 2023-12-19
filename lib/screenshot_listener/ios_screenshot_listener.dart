import 'dart:developer';

import 'package:photo_manager/photo_manager.dart';
import 'package:screenshot_callback/screenshot_callback.dart';

import 'screenshot_listener.dart';

class IOSScreenShotListener extends ScreenShotListener {
  final ScreenshotCallback screenshotCallback = ScreenshotCallback();

  @override
  void init() {}

  @override
  void addListener(Function(String path) callback) {
    screenshotCallback.addListener(() async {
      final ps = await PhotoManager.requestPermissionExtend();
      if (ps.isAuth) {
        getLatestImagePath().then(callback).catchError((e) {});
      } else if (ps.hasAccess) {
        //todo:
        ///nếu user không chọn đúng tấm ảnh vừa mới chụp màn hình thì sẽ ra kết quả sai
      } else {
        // Limited(iOS) or Rejected, use `==` for more precise judgements.
        // You can call `PhotoManager.openSetting()` to open settings for further steps.

        //todo:
        // await PhotoManager.openSetting();
        // final ps = await PhotoManager.requestPermissionExtend();
        // if (ps.isAuth) {
        //   getLatestImagePath().then(callback).catchError((e) {});
        // }
      }
    });
  }

  @override
  void dispose() {
    screenshotCallback.dispose();
  }
}

Future<String> getLatestImagePath() async {
  try {
    final List<AssetEntity> entities = await PhotoManager.getAssetListPaged(page: 0, pageCount: 1);
    if (entities.isNotEmpty) {
      final assetEntity = await AssetEntity.fromId(entities.first.id);
      final file = await assetEntity!.file;
      return file!.path;
    }
    throw Exception("Not found path");
  } catch (e, st) {
    log("GetLatestImagePath: ${e.toString()}");
    log(st.toString());
    rethrow;
  }
}
