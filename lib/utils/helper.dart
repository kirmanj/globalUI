import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import 'AppColors.dart';

class Helper {
  static int uuidToNumber(String uuid) {
    if(uuid.isEmpty){
      return 0 ;
    }
    // Convert the UUID string to bytes
    final bytes = utf8.encode(uuid);

    // Hash the bytes using a stable hash (e.g. MD5 or SHA1)
    final digest = sha1.convert(bytes);

    // Convert the hash to an integer
    final hashBytes = Uint8List.fromList(digest.bytes);
    int hashValue = 0;
    for (var byte in hashBytes) {
      hashValue = (hashValue * 31 + byte) & 0x7FFFFFFF; // 32-bit safe
    }

    // Reduce the hash to a value between 0 and 14
    return hashValue % AppColors.categories.length;
  }
}