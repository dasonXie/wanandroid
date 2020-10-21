import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class PhotoPickerPage extends StatefulWidget {
  PhotoPickerPage({Key key}) : super(key: key);

  @override
  _PhotoPickerPageState createState() => _PhotoPickerPageState();
}

class _PhotoPickerPageState extends State<PhotoPickerPage> {
  //记录已选择的图片
  List<AssetEntity> assets = <AssetEntity>[];

  //图片选择器
  Future _imagePicker() async {
    await AssetPicker.pickAssets(
      context,
      maxAssets: 9, //最大张数
      selectedAssets: assets,
      requestType: RequestType.common,
      customItemPosition: CustomItemPosition.prepend,
      customItemBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            final AssetEntity result = await CameraPicker.pickFromCamera(
              context,
              isAllowRecording: true,
            );
            if (result != null) {
              Navigator.of(context).pop(<AssetEntity>[...assets, result]);
            }
          },
          child: Center(
            child: Icon(
              Icons.camera_alt,
              size: 42,
            ),
          ),
        );
      },
    ).then((value) {
      if (value != assets && value != null) {
        assets = value;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  //展示预览图片
  Widget _imagePreviewBuilder(int index) {
    AssetEntity entity = assets[index];
    return Image(
      image: AssetEntityImageProvider(entity, isOriginal: false),
      fit: BoxFit.cover,
    );
  }

  //上传图片
  Future _uploadImages() async {
    List imageFiles = [];
    for (AssetEntity entity in assets) {
      AssetEntityImageProvider key = AssetEntityImageProvider(entity);
      File file = await key.entity.file;
      var fname =
          file.path.substring(file.path.lastIndexOf("/") + 1, file.path.length);
      imageFiles.add(await MultipartFile.fromFile(file.path, filename: fname));
    }
    FormData formdata = FormData.fromMap({
      "files": imageFiles,
    });
    Dio dio = Dio();
    try {
      Response response = await dio.post("url", data: formdata);
      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("imagePicker"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: _imagePicker,
                    child: Text("选择图片"),
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  RaisedButton(
                    onPressed: assets.length == 0 ? null : _uploadImages,
                    child: Text("上传图片"),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: assets.length,
                itemBuilder: (context, index) {
                  return _imagePreviewBuilder(index);
                },
              ),
              height: 300,
              width: 365,
            ),
          ],
        ),
      ),
    );
  }
}
