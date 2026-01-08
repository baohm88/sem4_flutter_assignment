**Flutter & Dart, Hello World**

1.  **Giới thiệu về Flutter:**
    *   Flutter là một framework UI mã nguồn mở của Google để xây dựng các ứng dụng native cho mobile, web và desktop từ một codebase duy nhất. Dành cho các nhà phát triển muốn xây dựng ứng dụng đa nền tảng hiệu suất cao một cách nhanh chóng và dễ dàng.
    *   Ưu điểm của Flutter:
        *   Cross-platform development: Viết code một lần, chạy trên nhiều nền tảng (iOS, Android, web, desktop).
        *   Hot reload: Thấy ngay lập tức các thay đổi trong code mà không cần khởi động lại ứng dụng.
        *   Rich set of widgets: Cung cấp một bộ sưu tập lớn các widget được thiết kế sẵn, đẹp mắt và có thể tùy chỉnh.
        *   Native performance: Ứng dụng Flutter được biên dịch thành mã native, mang lại hiệu suất tương đương với ứng dụng native.
        *   Fast development: Flutter giúp tăng tốc quá trình phát triển ứng dụng nhờ hot reload, bộ widget phong phú và cộng đồng hỗ trợ lớn.
    *   Kiến trúc Flutter:
        *   Widget tree: Mọi thứ trong Flutter đều là widget, và các widget được sắp xếp theo cấu trúc cây.
        *   Rendering engine: Flutter sử dụng Skia, một thư viện đồ họa 2D, để vẽ UI trực tiếp lên màn hình.
    *   Sự khác biệt giữa Flutter và Native development:
        *   Codebase: Flutter sử dụng một codebase duy nhất cho nhiều nền tảng, trong khi native development yêu cầu codebase riêng cho mỗi nền tảng.
        *   Performance: Flutter có hiệu suất gần như native, trong khi các framework cross-platform khác có thể gặp vấn đề về hiệu suất.
        *   Development speed: Flutter thường nhanh hơn native development nhờ hot reload và bộ widget phong phú.
2.  **Giới thiệu về Dart:**
    *   Dart là một ngôn ngữ lập trình do Google phát triển, được tối ưu hóa cho việc xây dựng UI.
    *   Tại sao Flutter sử dụng Dart? Dart có hiệu suất tốt, hỗ trợ hot reload và có cú pháp dễ học.
    *   Cú pháp cơ bản của Dart:
        *   Biến: `var`, `int`, `double`, `String`, `bool`, `dynamic`. Ví dụ: `var name = "Alice";`, `int age = 30;`.
        *   Kiểu dữ liệu: Số, chuỗi, boolean, danh sách (List), bản đồ (Map).
        *   Toán tử: `+`, `-`, `*`, `/`, `%`, `=`, `==`, `!=`, `>`, `<`, `>=`, `<=`.
        *   Vòng lặp: `for`, `while`, `do-while`. Ví dụ: `for (int i = 0; i < 10; i++) { print(i); }`.
        *   Hàm: Định nghĩa và gọi hàm. Ví dụ: `int add(int a, int b) { return a + b; }`.
        *   Câu điều kiện: `if`, `else if`, `else`.
3.  **Tạo project Flutter đầu tiên:**
    *   Sử dụng Flutter CLI để tạo một project mới:
        *   Mở terminal hoặc command prompt.
        *   Chạy lệnh: `flutter create my_first_app` (thay `my_first_app` bằng tên project bạn muốn).
        *   Chuyển vào thư mục project: `cd my_first_app`.
    *   Chạy ứng dụng trên trình giả lập (emulator) hoặc thiết bị thật:
        *   Emulator: Khởi động Android Emulator (nếu bạn sử dụng Android Studio).
        *   Thiết bị thật: Kết nối thiết bị Android hoặc iOS của bạn với máy tính. Đảm bảo đã bật chế độ developer mode trên thiết bị Android.
        *   Chạy lệnh: `flutter run`.
        *   Chọn thiết bị bạn muốn chạy ứng dụng trên.
4.  **Giới thiệu cấu trúc thư mục project Flutter:**
    *   `android/`, `ios/`: Chứa code native cho Android và iOS.
    *   `lib/`: Chứa code Dart của ứng dụng.
    *   `lib/main.dart`: Điểm khởi đầu của ứng dụng.
    *   `pubspec.yaml`: File cấu hình project (dependencies, assets, fonts, v.v.).
5.  **Chỉnh sửa ứng dụng "Hello, World!":**
    *   Mở file `lib/main.dart` trong IDE của bạn.
    *   Tìm widget `Text('Hello, World!')`.
    *   Thay đổi text, màu sắc, kích thước font. Sử dụng hot reload để xem các thay đổi ngay lập tức.

**Ví dụ Code (Dart):**

```dart
void main() {
  print('Hello, Dart!');

  var name = "Alice";
  int age = 30;
  double height = 1.65;
  bool isStudent = false;

  print('Name: $name, Age: $age, Height: $height, Is student: $isStudent');

  for (int i = 0; i < 5; i++) {
    print('Iteration: $i');
  }

  int add(int a, int b) {
    return a + b;
  }

  int sum = add(5, 3);
  print('Sum: $sum');
}
```

**Ví dụ Code (Flutter):**

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello World'),
        ),
        body: Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(fontSize: 24, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
```
