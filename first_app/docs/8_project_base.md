# PROJECT BASE

### PHẦN 1: CẤU HÌNH THƯ VIỆN (PUBSPEC.YAML)

Mở file `pubspec.yaml` và thêm các thư viện cần thiết:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0        # Thư viện gọi API
  sqflite: ^2.3.0     # Thư viện cơ sở dữ liệu SQLite
  path: ^1.8.3        # Thư viện xử lý đường dẫn tệp tin
```
*Sau đó nhấn **Pub get** để tải thư viện.*

---

### PHẦN 2: CẤU TRÚC THƯ MỤC DỰ ÁN

Để dự án chuyên nghiệp, chia thư mục trong `lib/` như sau:
1.  `models/`: Định nghĩa cấu trúc dữ liệu.
2.  `services/`: Xử lý logic API và Cơ sở dữ liệu.
3.  `screens/`: Chứa giao diện người dùng.

---

### PHẦN 3: XÂY DỰNG CÁC LỚP XỬ LÝ DỮ LIỆU

#### 1. Model Dữ liệu (`lib/models/post_model.dart`)
Chuyển đổi qua lại giữa JSON (API), Map (SQLite) và Đối tượng (Dart).

```dart
class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  // Chuyển JSON từ API thành đối tượng Post
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'], title: json['title'], body: json['body']);
  }

  // Chuyển đối tượng Post thành Map để lưu vào SQLite
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'body': body};
  }
}
```

#### 2. Dịch vụ Cơ sở dữ liệu (`lib/services/db_helper.dart`)
Quản lý việc tạo bảng và lưu trữ dữ liệu dưới máy.

```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/post_model.dart';

class DbHelper {
  static Database? _db;

  // Khởi tạo hoặc lấy database hiện có
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'posts.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE posts(id INTEGER PRIMARY KEY, title TEXT, body TEXT)"
      );
    });
  }

  // Lưu danh sách Post vào SQLite
  Future<void> insertPosts(List<Post> posts) async {
    final dbClient = await db;
    for (var post in posts) {
      await dbClient.insert('posts', post.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  // Lấy dữ liệu từ SQLite ra
  Future<List<Post>> getPosts() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('posts');
    return List.generate(maps.length, (i) => Post.fromJson(maps[i]));
  }
}
```

#### 3. Dịch vụ API (`lib/services/api_service.dart`)
Lấy dữ liệu từ Internet.

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  final String url = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Post.fromJson(data)).toList();
    } else {
      throw Exception('Lỗi khi tải dữ liệu từ API');
    }
  }
}
```

---

### PHẦN 4: XÂY DỰNG GIAO DIỆN VÀ LUỒNG ĐIỀU KHIỂN

#### Giao diện danh sách (`lib/screens/home_screen.dart`)

```dart
import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';
import '../services/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final DbHelper dbHelper = DbHelper();
  List<Post> displayPosts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    syncData(); // Chạy luồng đồng bộ dữ liệu khi mở app
  }

  // LUỒNG CHÍNH: API -> SQLITE -> UI
  Future<void> syncData() async {
    try {
      // 1. Lấy dữ liệu từ API
      List<Post> apiPosts = await apiService.fetchPosts();
      // 2. Lưu vào SQLite
      await dbHelper.insertPosts(apiPosts);
    } catch (e) {
      print("Mất mạng, đang hiển thị dữ liệu cũ từ SQLite");
    } finally {
      // 3. Đọc từ SQLite ra để hiển thị lên màn hình
      List<Post> localPosts = await dbHelper.getPosts();
      setState(() {
        displayPosts = localPosts;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Manager (API + SQLite)')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Hiển thị vòng xoay khi tải
          : ListView.builder(
              itemCount: displayPosts.length,
              itemBuilder: (context, index) {
                final post = displayPosts[index];
                // Layout từng dòng dữ liệu (Card)
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(post.id.toString())),
                    title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                );
              },
            ),
    );
  }
}
```

---

### PHẦN 5: ĐIỂM KHỞI CHẠY (`lib/main.dart`)

```dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Base Project',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(), // Chạy màn hình chính
      debugShowCheckedModeBanner: false,
    );
  }
}
```

---

### TỔNG KẾT LUỒNG HOẠT ĐỘNG CỦA PROJECT BASE:

1.  **Khởi tạo**: Khi app mở, hàm `initState` gọi `syncData`.
2.  **Kết nối**: `ApiService` gọi lên Server lấy dữ liệu JSON. JSON được chuyển thành danh sách các đối tượng `Post`.
3.  **Lưu trữ**: `DbHelper` nhận danh sách đối tượng, chuyển chúng thành dạng `Map` và đẩy vào bảng `posts` của SQLite.
4.  **Hiển thị**: Dữ liệu được truy vấn ngược từ SQLite lên, cập nhật vào biến `displayPosts`. Hàm `setState` được gọi để vẽ lại giao diện.
5.  **Layout**: `ListView.builder` kết hợp với `Card` và `ListTile` để tạo ra danh sách đẹp mắt, tối ưu bộ nhớ.

**Ưu điểm của mô hình này**: Ứng dụng vẫn có thể hiển thị dữ liệu cũ từ SQLite ngay cả khi thiết bị không có kết nối Internet (Tính năng Offline-first).