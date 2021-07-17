import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;

class APIHelperNyul {

  String baseUrl = 'rsumitradelima.com';

  Future<Map<String, dynamic>> postData(String path, Map<String, dynamic> data, {String? token}) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization" : token?? '',
      };

      http.Response response = await http.post(
        Uri.http(baseUrl, path),
        headers: headers,
        body: json.encode(data),
      );

      if(response.statusCode == 200) {
        if(json.decode(response.body)['result'] == true) {
          return {
            'result' : true,
            'data' : json.decode(response.body)['data']
          };
        } else {
          return {
            'result' : false,
            'message' : json.decode(response.body)['data']
          };
        }
      } else {
        return {
          'result' : false,
          'message' : '${response.statusCode} | ${json.decode(response.body)['data']}',
        };
      }

    } on SocketException {
      return {
        'result' : false,
        'data' : 'Tidak dapat menjangkau server, pastikan terdapat koneksi internet.'
      };
    } on FormatException {
      return {
        'result' : false,
        'data' : 'URL tidak sesuai.'
      };
    }
  }

  Future<Map<String, dynamic>> postDataMultipart(String path, Map<String, String> data, {String? token, required File file, required String fileField}) async {
    late http.StreamedResponse response;
    
    try {
      http.ByteStream stream;
      int length;
      http.MultipartFile vFile;

      Uri uri = new Uri.http(baseUrl, path);

      http.MultipartRequest request = new http.MultipartRequest('POST', uri);

      Map<String, String> headers = {
        "Authorization" : token?? '',
      };

      request.headers.addAll(headers);
      request.fields.addAll(data);

      if(await file.exists()) {
        stream = new http.ByteStream(file.openRead());
        stream.cast();
        length = await file.length();
        vFile = new http.MultipartFile(fileField, stream, length, filename: basename(file.path));

        request.files.add(vFile);
      }

      response = await request.send();

      if(response.statusCode == 200) {
        return {
          'result' : true,
          'data' : json.decode(await response.stream.bytesToString()),
        };
      } else {
        return {
          'result' : false,
          'data' : json.decode(await response.stream.bytesToString()).toString(),
        };
      }
    } on SocketException {
      return {
        'result' : false,
        'data' : 'Tidak dapat menjangkau server, pastikan terdapat koneksi internet.'
      };
    } on FormatException {
      print(json.decode(await response.stream.bytesToString()));

      return {
        'result' : false,
        'data' : 'URL tidak sesuai. '
      };
    }
  }

  Future<Map<String, dynamic>> getData(String unencodedPath, [Map<String, dynamic>? queryParameters, String? token]) async {
    
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization" : token?? '',
      };

      var response = await http.get(Uri.http(baseUrl, unencodedPath, queryParameters), headers: headers);

      if(response.statusCode == 200) {
        if(json.decode(response.body)['result'] == true) {
          return {
            'result' : true,
            'data' : json.decode(response.body)['data']
          };
        } else {
          return {
            'result' : false,
            'message' : json.decode(response.body)['data']
          };
        }
      } else {
        return {
          'result' : false,
          'message' : '${response.statusCode} | ${json.decode(response.body)['data']}',
        };
      }
    } on SocketException {
      return {
        'result' : false,
        'data' : 'Tidak dapat menjangkau server, pastikan terdapat koneksi internet.'
      };
    } on FormatException {
      return {
        'result' : false,
        'data' : 'URL tidak sesuai.'
      };
    }
  }

  Future<Map<String, dynamic>> deleteData(String unencodedPath, [Map<String, dynamic>? data, String? token]) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization" : token?? '',
      };

      http.Response response = await http.delete(
        Uri.http(baseUrl, unencodedPath),
        headers: headers,
        body: json.encode(data),
      );

      if(response.statusCode == 200) {
        if(json.decode(response.body)['result'] == true) {
          return {
            'result' : true,
            'data' : json.decode(response.body)['data']
          };
        } else {
          return {
            'result' : false,
            'message' : json.decode(response.body)['data']
          };
        }
      } else {
        return {
          'result' : false,
          'message' : '${response.statusCode} | ${json.decode(response.body)['data']}',
        };
      }

    } on SocketException {
      return {
        'result' : false,
        'data' : 'Tidak dapat menjangkau server, pastikan terdapat koneksi internet.'
      };
    } on FormatException {
      return {
        'result' : false,
        'data' : 'URL tidak sesuai.'
      };
    }
  }

  Future<Map<String, dynamic>> updateData(String unencodedPath, [Map<String, dynamic>? data, String? token]) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization" : token?? '',
      };

      http.Response response = await http.put(
        Uri.http(baseUrl, unencodedPath),
        headers: headers,
        body: json.encode(data),
      );

      if(response.statusCode == 200) {
        if(json.decode(response.body)['result'] == true) {
          return {
            'result' : true,
            'data' : json.decode(response.body)['data']
          };
        } else {
          return {
            'result' : false,
            'message' : json.decode(response.body)['data']
          };
        }
      } else {
        return {
          'result' : false,
          'message' : '${response.statusCode} | ${json.decode(response.body)['data']}',
        };
      }

    } on SocketException {
      return {
        'result' : false,
        'data' : 'Tidak dapat menjangkau server, pastikan terdapat koneksi internet.'
      };
    } on FormatException {
      return {
        'result' : false,
        'data' : 'URL tidak sesuai.'
      };
    }
  }
}