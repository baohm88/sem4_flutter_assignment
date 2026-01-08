# THÊM THƯ VIỆN VÀO DỰ ÁN FLUTTER

Trong hệ sinh thái Flutter, các thư viện mở rộng được gọi là **Packages**. Để làm việc với API (gọi các yêu cầu HTTP), thư viện phổ biến và tiêu chuẩn nhất được sử dụng là thư viện `http`.

Dưới đây là quy trình chi tiết để thêm và sử dụng thư viện này.

---

### BƯỚC 1: TÌM KIẾM THƯ VIỆN TRÊN PUB.DEV

1. Truy cập vào trang web chính thức: [pub.dev](https://pub.dev).
2. Nhập từ khóa `http` vào ô tìm kiếm.
3. Chọn thư viện `http` (thường do **dart.dev** phát hành). Tại đây, có thể kiểm tra phiên bản mới nhất (Ví dụ: `1.1.0`).

### BƯỚC 2: KHAI BÁO THƯ VIỆN VÀO DỰ ÁN

Có hai cách để thêm thư viện vào dự án trong Android Studio:

#### Cách 1: Chỉnh sửa trực tiếp file `pubspec.yaml` (Khuyên dùng)
1. Mở file `pubspec.yaml` trong thư mục gốc của dự án.
2. Tìm đến mục `dependencies:`.
3. Thêm tên thư viện và phiên bản ngay bên dưới (lưu ý lùi vào 2 dấu cách so với chữ `dependencies`).

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0  # Thêm dòng này
```

#### Cách 2: Sử dụng Terminal trong Android Studio
1. Mở cửa sổ **Terminal** ở phía dưới cùng của Android Studio.
2. Nhập lệnh sau và nhấn Enter:
   ```bash
   flutter pub add http
   ```
   Hệ thống sẽ tự động tìm phiên bản phù hợp và thêm vào file `pubspec.yaml`.

### BƯỚC 3: TẢI THƯ VIỆN VỀ MÁY (PUB GET)

Sau khi khai báo, cần lệnh cho Flutter tải mã nguồn của thư viện về:
* **Thông qua giao diện**: Nhấn nút **Pub get** xuất hiện ở thanh thông báo phía trên cùng của file `pubspec.yaml`.
* **Thông qua Terminal**: Chạy lệnh `flutter pub get`.

Nếu kết quả trả về `Process finished with exit code 0`, thư viện đã được cài đặt thành công.

### BƯỚC 4: CẤU HÌNH QUYỀN TRUY CẬP INTERNET (ANDROID)

Để ứng dụng có thể gọi API trên thiết bị Android, cần cấp quyền truy cập Internet:
1. Mở file: `android/app/src/main/AndroidManifest.xml`.
2. Thêm dòng sau bên trên thẻ `<application>`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" /> <!-- Thêm dòng này -->
    <application ...>
</manifest>
```

### BƯỚC 5: SỬ DỤNG THƯ VIỆN TRONG MÃ NGUỒN DART

Tại file muốn thực hiện gọi API (ví dụ `lib/main.dart`), thực hiện các bước sau:

1. **Import thư viện**:
   ```dart
   import 'package:http/http.dart' as http;
   ```
   *(Sử dụng `as http` để gom nhóm các hàm của thư viện vào tiền tố `http`, giúp code rõ ràng hơn).*

2. **Viết hàm gọi API mẫu**:

```dart
Future<void> fetchData() async {
  // Đường dẫn API mẫu
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  // Gửi yêu cầu GET
  var response = await http.get(url);

  if (response.statusCode == 200) {
    // Nếu gọi thành công, in dữ liệu trả về (Body) ra Console
    print('Dữ liệu: ${response.body}');
  } else {
    // Nếu gặp lỗi
    print('Lỗi: ${response.statusCode}');
  }
}
```

### CÁC LƯU Ý QUAN TRỌNG

*   **Định dạng thụt lề**: File `pubspec.yaml` sử dụng định dạng YAML, do đó khoảng cách (spaces) là cực kỳ quan trọng. Không sử dụng phím Tab, chỉ sử dụng phím Space.
*   **Ký hiệu ^ (Caret syntax)**: Ký hiệu `^1.1.0` có nghĩa là cho phép cập nhật các phiên bản mới hơn nhưng không làm thay đổi cấu trúc chính (ví dụ từ `1.1.0` lên `1.2.0` thì được, nhưng không tự nhảy lên `2.0.0`).
*   **Thư viện Dio**: Đối với các dự án lớn, yêu cầu các tính năng nâng cao như chặn request (interceptors), gửi file, hoặc quản lý cookie, thư viện **`dio`** thường được ưu tiên sử dụng thay thế cho `http`. Quy trình thêm thư viện `dio` hoàn toàn tương tự như trên.