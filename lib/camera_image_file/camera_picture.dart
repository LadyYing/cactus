import 'dart:io';
import 'dart:typed_data';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_exif_plugin/tags.dart';
import 'package:path/path.dart' as path; 
import 'package:flutter_exif_plugin/flutter_exif_plugin.dart';
//import 'package:path_provider/path_provider.dart';

final picker = ImagePicker();
File? _image;
var locationMessage = '';
String? latitude;
String? longitude;

final ImagePicker _picker = ImagePicker();
FlutterExif? exif;
Uint8List? imageToRead;

final pickerX = ImagePicker();

Future getImage() async {
  var position = await Geolocator.getCurrentPosition (
    desiredAccuracy: LocationAccuracy.high
  );
  var lat = position.latitude;
  var long = position.longitude;

  latitude = "$lat";
  longitude = "$long";

  final PickedFile? pickerFile = 
    await picker.getImage(source: ImageSource.camera);
    if (pickerFile == null) return;
      Uint8List bytes = await pickerFile.readAsBytes();
      exif = FlutterExif.fromBytes(bytes);
    await exif!.setAttribute(TAG_GPS_LATITUDE, latitude!);
    await exif!.setLatLong(lat, long);
    await exif!.saveAttributes();
    imageToRead = (await exif!.imageData)!;
    return _image = File(pickerFile.path);
}

Future<File> moveFile(File sourceFile, String newPath)
  async {
    try {
      return await sourceFile.rename(newPath);
    } catch (e) {
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }
