/*import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;

class Gallery extends StatefulWidget {
  const Gallery({ required  Key key, 
    this.title = 'Chewie Demo',
  }) : super(key: key);

    final String title;

  @override
  State<StatefulWidget> createState() {
    return _GalleryState();
  }
}

class _GalleryState extends State<Gallery> {
  late TargetPlatform _platform;
  late VideoPlayerController _videoPlayerController1;
  late ChewieController _chewieController;

  static final Directory _photoDir =
    new Directory('/storage/emulated/0/Android/data/com.rmutt.cpe.project.helmet_detection_app/files/Video');

  get deleteFile => null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    List<FileSystemEntity> _photoList;
    Directory _downloadsDirectory;

    Widget? buildPhoto(int index) {
      Future<Widget?> initializePlayer(index) async {
        _videoPlayerController1 = VideoPlayerController.file(_photoList![index]);
        try {
          await Future.wait([
            _videoPlayerController1.initialize()
          ]);
          _chewieController = ChewieController (
            videoPlayerController: _videoPlayerController1,
            autoPlay: false,
            looping: false,
          );
        }
        catch(e){return null;}
        return Center();
      }
      deleeFile(index) async {
        try{
          await _photoList[index].delete();
          Navigator.pop(context, 'ตกลง');
        } catch(e) {
            return 0;
          }
          setState(() {
          
          });
      }

      download(index) async {

        try{
          Directory appDocDir = await getTemporaryDirectory();
          String appDocPath = appDocDir.path;
          print(appDocPath);
          String pathDownload = await ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_PICTURES
          );

          var basNameWithExtension = path.basename(_photoList[index].path);
          Navigator.pop(context, 'ตกลง');
          setState(() {
          
          });
        } catch (e) {
            return 0;
        }
      }
      if (index >= _photoList.length) {
        return null;
      } print('Loading video[$index]: ${'_photoList[index]'}... done');
      return GestureDetector(
        child: Center(
          child: Card(
            child: Column(
              children: <Widget>[
                FutureBuilder<Widget>(
                  future: initializePlayer(index),
                  builder: (context, snapshot) => (_chewieController != null && _chewieController.videoPlayerController.value.isInitialized
                    ? Chewie(controller: _chewieController,)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const[
                          CircularProgressIndicator(),
                          SizedBox(),
                          Text('รอสักครู่'),
                        ],
                      )
                    ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext cuntext) => AlertDialog(
                          title: const Text('คุณต้องการดาวน์โหลดใช่หรือไม่ ?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'ยกเลิก'),
                              child: const Text('ยกเลิก',style: TextStyle(color: Colors.red),),
                            ),
                            TextButton(
                              onPressed: () =>  download(index),
                              child: const Text('ตกลง',style: TextStyle(color: Colors.red),),
                            ),
                          ],
                        )
                      ),
                      icon: const Icon(Icons.download)
                    ),
                    const SizedBox(),
                    IconButton(
                      onPressed: () => showDialog<String> (
                        context: context,
                        builder:  (BuildContext context) => AlertDialog (
                          title: const Text('คุณต้องการลบไฟล์ใช่หรือไม่ ?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel',style: TextStyle(color: Colors.red),),
                            ),
                            TextButton(
                              onPressed: () => deleteFile[index],
                              child: const Text('ตกลง',style: TextStyle(color: Colors.red),),
                            ),
                          ],
                        ),  
                      ),
                      icon: Icon(Icons.restore_from_trash,color: Colors.red,),
                    ),
                  ]
                ),
              ]
            ),
          ),
        ),
      );
    }

    Widget? buildPhotoList() {
      _photoList = _photoDir.listSync();
      return new ListView.builder(
        itemBuilder: (BuildContext context, int index) => buildPhoto(index)
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body:  Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: buildPhotoList(),
        ),
      ),
    );
  }
}*/