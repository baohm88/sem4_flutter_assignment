# XÂY DỰNG CHỨC NĂNG GỌI API TRONG FLUTTER

Tài liệu này hướng dẫn chi tiết từ việc cấu trúc file, viết mã nguồn xử lý đến việc hiển thị dữ liệu lên màn hình ứng dụng bằng cách sử dụng thư viện `http`.

---

### BƯỚC 1: CẤU HÌNH THƯ VIỆN VÀ QUYỀN TRUY CẬP

1.  **Thêm thư viện**: Mở file `pubspec.yaml`, thêm `http: ^1.1.0` vào mục `dependencies`.
2.  **Cấp quyền Android**: Mở `android/app/src/main/AndroidManifest.xml`, thêm dòng `<uses-permission android:name="android.permission.INTERNET" />` vào trên thẻ `<application>`.
3.  **Tải thư viện**: Mở Terminal trong Android Studio và chạy lệnh:
    ```bash
    flutter pub get
    ```

---

### BƯỚC 2: TẠO DATA MODEL (MÔ HÌNH DỮ LIỆU)

Việc tạo Model giúp chuyển đổi dữ liệu JSON từ API thành đối tượng trong Dart để dễ dàng quản lý.

1.  Tại thư mục `lib/`, nhấp chuột phải chọn **New -> Dart File**.
2.  Đặt tên file: `post_model`.
3.  Dán đoạn mã sau vào file `lib/post_model.dart`:

```dart
class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  // Hàm chuyển đổi từ JSON sang đối tượng Post
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
```

---

### BƯỚC 3: TẠO API SERVICE (LỚP XỬ LÝ LOGIC API)

Tách biệt phần gọi API ra một lớp riêng để mã nguồn sạch sẽ và dễ bảo trì.

1.  Tại thư mục `lib/`, nhấp chuột phải chọn **New -> Dart File**.
2.  Đặt tên file: `api_service`.
3.  Dán đoạn mã sau vào file `lib/api_service.dart`:

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class ApiService {
  // Hàm gọi API lấy dữ liệu bài viết theo ID
  Future<Post> fetchPost() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );

    if (response.statusCode == 200) {
      // Nếu server trả về 200 OK, tiến hành giải mã JSON
      return Post.fromJson(jsonDecode(response.body));
    } else {
      // Nếu lỗi, quăng ra một Exception
      throw Exception('Không thể tải dữ liệu');
    }
  }
}
```

---

### BƯỚC 4: HIỂN THỊ DỮ LIỆU TRÊN GIAO DIỆN (MAIN.DART)

Sử dụng `FutureBuilder` để tự động xử lý các trạng thái của API (Đang tải, Thành công, Lỗi).

1.  Mở file `lib/main.dart`.
2.  Xóa toàn bộ nội dung cũ và thay thế bằng đoạn mã sau:

```dart
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'post_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Ví dụ Gọi API Flutter')),
        body: const PostDetail(),
      ),
    );
  }
}

class PostDetail extends StatefulWidget {
  const PostDetail({super.key});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late Future<Post> futurePost;

  @override
  void initState() {
    super.initState();
    // Khởi tạo việc gọi API ngay khi ứng dụng bắt đầu
    futurePost = ApiService().fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Post>(
        future: futurePost,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Khi có dữ liệu thành công
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.data!.title, 
                       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(snapshot.data!.body),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            // Khi xảy ra lỗi
            return Text('${snapshot.error}');
          }

          // Trạng thái mặc định: Đang tải (Loading)
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
```

---

### BƯỚC 5: CÁCH CHẠY ỨNG DỤNG

1.  **Kiểm tra thiết bị**: Đảm bảo đã mở máy ảo (Emulator) hoặc kết nối điện thoại thật qua USB.
2.  **Chạy ứng dụng**:
   *   Trên thanh công cụ của Android Studio, nhấn vào biểu tượng **Play** (mũi tên màu xanh lá cây).
   *   Hoặc mở Terminal và gõ: `flutter run`.
3.  **Quan sát kết quả**:
   *   Đầu tiên màn hình sẽ hiện biểu tượng vòng tròn xoay (Loading).
   *   Sau khoảng 1-2 giây khi dữ liệu được tải về từ internet, nội dung bài viết (Title và Body) sẽ hiển thị lên màn hình.

### TỔNG KẾT CẤU TRÚC FILE SAU KHI THỰC HIỆN:
*   `lib/main.dart`: Giao diện chính.
*   `lib/api_service.dart`: Logic gọi API.
*   `lib/post_model.dart`: Cấu trúc dữ liệu.
*   `pubspec.yaml`: Khai báo thư viện `http`.