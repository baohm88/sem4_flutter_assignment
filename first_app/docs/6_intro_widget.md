# TỔNG QUAN VỀ WIDGET TRONG FLUTTER

Trong Flutter, mọi thành phần xuất hiện trên màn hình (từ văn bản, hình ảnh, nút bấm cho đến căn lề, bố cục) đều được coi là một **Widget**. Triết lý thiết kế của Flutter là "Everything is a Widget". Các Widget được xếp chồng lên nhau hoặc lồng vào nhau để tạo thành một cây cấu trúc gọi là **Widget Tree**.

---

### PHẦN 1: PHÂN LOẠI WIDGET THEO TRẠNG THÁI

Có hai loại Widget chính dựa trên khả năng thay đổi dữ liệu của chúng:

1.  **StatelessWidget (Widget không trạng thái)**:
    *   Là loại Widget không thay đổi trong suốt vòng đời sau khi được tạo ra.
    *   Dùng cho các thành phần hiển thị tĩnh như: một biểu tượng, một dòng thông báo hoặc một nhãn dán.
    *   Ưu điểm: Nhẹ, hiệu năng cao.

2.  **StatefulWidget (Widget có trạng thái)**:
    *   Có khả năng thay đổi giao diện khi dữ liệu bên trong (State) thay đổi.
    *   Dùng cho các thành phần tương tác như: ô nhập liệu (TextField), nút bấm thay đổi màu sắc, hoặc một màn hình lấy dữ liệu từ mạng.
    *   Sử dụng hàm `setState()` để yêu cầu hệ thống vẽ lại giao diện khi có sự thay đổi.

---

### PHẦN 2: CÁC NHÓM WIDGET CƠ BẢN THƯỜNG DÙNG

#### 1. Nhóm Widget cấu trúc màn hình
*   **Scaffold**: Cung cấp cấu trúc cơ bản cho một màn hình ứng dụng (bao gồm AppBar, Body, FloatingActionButton, Drawer).
*   **AppBar**: Thanh tiêu đề phía trên cùng của ứng dụng.

#### 2. Nhóm Widget bố cục (Layout)
*   **Container**: Một "chiếc hộp" đa năng, dùng để chứa các widget khác và tùy chỉnh kích thước, màu nền, đường viền, khoảng cách (padding/margin).
*   **Column**: Sắp xếp các Widget con theo chiều dọc.
*   **Row**: Sắp xếp các Widget con theo chiều ngang.
*   **Stack**: Xếp chồng các Widget lên nhau (cái sau nằm trên cái trước).

#### 3. Nhóm Widget hiển thị nội dung
*   **Text**: Hiển thị các chuỗi ký tự.
*   **Image**: Hiển thị hình ảnh từ Internet hoặc thư mục assets.
*   **Icon**: Hiển thị các biểu tượng đồ họa vector.

---

### PHẦN 3: HƯỚNG DẪN CHI TIẾT CÁCH LÀM VIỆC VỚI WIDGET CƠ BẢN

#### 1. Widget Text (Hiển thị văn bản)
Dùng để hiển thị và định dạng văn bản.
```dart
Text(
  'Xin chào Flutter',
  style: TextStyle(
    fontSize: 24,             // Kích thước chữ
    fontWeight: FontWeight.bold, // Độ đậm
    color: Colors.blue,       // Màu sắc
    letterSpacing: 2.0,       // Khoảng cách giữa các chữ
  ),
)
```

#### 2. Widget Container (Hộp chứa)
Tương tự như thẻ `div` trong HTML, dùng để tạo khoảng cách và trang trí.
```dart
Container(
  width: 200,                // Chiều rộng
  height: 100,               // Chiều cao
  padding: EdgeInsets.all(10), // Khoảng cách bên trong hộp
  margin: EdgeInsets.all(20),  // Khoảng cách bên ngoài hộp
  decoration: BoxDecoration(
    color: Colors.amber,       // Màu nền
    borderRadius: BorderRadius.circular(15), // Bo góc
  ),
  child: const Text('Nội dung bên trong hộp'),
)
```

#### 3. Widget Column & Row (Bố cục dọc và ngang)
Đây là công cụ quan trọng nhất để sắp xếp giao diện.
*   **MainAxisAlignment**: Căn chỉnh dọc theo trục chính (Dọc với Column, Ngang với Row).
*   **CrossAxisAlignment**: Căn chỉnh theo trục phụ (Ngang với Column, Dọc với Row).

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
  children: [
    const Text('Dòng 1'),
    const Icon(Icons.star),
    ElevatedButton(onPressed: () {}, child: const Text('Nút bấm')),
  ],
)
```

---

### PHẦN 4: VÍ DỤ TỔNG HỢP (THỰC HÀNH)

Đoạn mã dưới đây kết hợp các Widget trên để tạo ra một giao diện thẻ (Card) đơn giản. Có thể sao chép đoạn mã này vào tệp `lib/main.dart` để kiểm tra kết quả.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: BasicWidgetsDemo()));
}

class BasicWidgetsDemo extends StatelessWidget {
  const BasicWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hướng dẫn Widget cơ bản'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ví dụ về Container và Text
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                border: Border.all(color: Colors.teal, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Đây là một Widget Container',
                style: TextStyle(fontSize: 18, color: Colors.teal),
              ),
            ),
            
            const SizedBox(height: 20), // Tạo khoảng cách trắng giữa các widget

            // Ví dụ về Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.home, color: Colors.red, size: 40),
                Icon(Icons.search, color: Colors.blue, size: 40),
                Icon(Icons.settings, color: Colors.green, size: 40),
              ],
            ),

            const SizedBox(height: 20),

            // Ví dụ về Button
            ElevatedButton.icon(
              onPressed: () {
                print('Nút đã được bấm!');
              },
              icon: const Icon(Icons.download),
              label: const Text('Tải xuống ngay'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### LƯU Ý KHI LÀM VIỆC VỚI WIDGET:
1.  **SizedBox**: Luôn sử dụng `SizedBox` để tạo khoảng trống cố định giữa các thành phần trong `Column` hoặc `Row`.
2.  **const**: Thêm từ khóa `const` trước các Widget không bao giờ thay đổi dữ liệu để tối ưu hóa bộ nhớ và tốc độ ứng dụng.
3.  **Hàng và Cột**: Luôn ghi nhớ trục chính (MainAxis) của từng loại để căn chỉnh chính xác. Row là trục ngang, Column là trục dọc.