# XÂY DỰNG LAYOUT: VÍ DỤ THẺ SẢN PHẨM (PRODUCT CARD)

---

### MÃ NGUỒN CHI TIẾT (`lib/main.dart`)

```dart
// Nhập thư viện thiết kế Material của Google để sử dụng các Widget có sẵn
import 'package:flutter/material.dart';

// Hàm main là điểm bắt đầu của mọi ứng dụng Flutter
void main() {
  // runApp khởi chạy ứng dụng. MaterialApp là gốc của một ứng dụng theo chuẩn Material Design
  runApp(const MaterialApp(
    home: LayoutDemo(),
    debugShowCheckedModeBanner: false, // Ẩn biểu tượng "Debug" ở góc màn hình
  ));
}

// Tạo một Widget không trạng thái (Stateless) vì giao diện này không thay đổi dữ liệu khi chạy
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold cung cấp cấu trúc nền tảng: AppBar, Body, Drawer, v.v.
    return Scaffold(
      // Màu nền xám nhạt cho toàn bộ màn hình để làm nổi bật thẻ (Card) màu trắng
      backgroundColor: Colors.grey[200], 
      
      // Thanh tiêu đề phía trên cùng
      appBar: AppBar(
        title: const Text('Phân Tích Layout Chi Tiết'),
        backgroundColor: Colors.blueAccent,
      ),

      // Center giúp căn chỉnh toàn bộ nội dung vào chính giữa màn hình theo cả 2 chiều
      body: Center(
        // Padding tạo khoảng cách đệm giữa thẻ sản phẩm và mép màn hình điện thoại
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Cách đều 4 phía 16 đơn vị logic

          // --- BẮT ĐẦU CẤU TRÚC THẺ SẢN PHẨM (CARD) ---
          
          // Container đóng vai trò là "chiếc hộp" chính chứa toàn bộ thông tin sản phẩm
          child: Container(
            height: 160, // Cố định chiều cao cho thẻ sản phẩm
            
            // Decoration dùng để trang trí: đổ bóng, bo góc, màu nền
            decoration: BoxDecoration(
              color: Colors.white, // Màu nền của thẻ
              borderRadius: BorderRadius.circular(15), // Bo tròn góc thẻ với bán kính 15
              
              // Tạo hiệu ứng đổ bóng giúp thẻ trông nổi bật hơn (hiệu ứng 3D)
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Màu bóng (đen nhạt)
                  blurRadius: 10, // Độ mờ của bóng
                  offset: const Offset(0, 5), // Độ lệch của bóng theo phương (x, y)
                )
              ],
            ),

            // Row (Hàng ngang): Chia thẻ thành 2 phần: Ảnh bên trái và Chữ bên phải
            child: Row(
              children: [
                
                // 1. PHẦN HÌNH ẢNH
                // Dùng Container để chứa ảnh vì cần định dạng bo góc và kích thước cố định
                Container(
                  width: 130, // Chiều rộng cố định cho ảnh
                  decoration: const BoxDecoration(
                    // Chỉ bo góc bên trái (phía trên và phía dưới) để khớp với khung ngoài
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    // Hiển thị hình ảnh từ một địa chỉ URL trên mạng
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/200/300'),
                      fit: BoxFit.cover, // Ảnh sẽ phủ kín vùng chứa mà không bị méo
                    ),
                  ),
                ),

                // 2. PHẦN THÔNG TIN VĂN BẢN
                // Expanded là Widget cực kỳ quan trọng:
                // Nó bắt phần nội dung này chiếm toàn bộ diện tích còn lại của hàng ngang
                // Nếu không có Expanded, văn bản dài sẽ gây lỗi tràn màn hình (Overflow)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    
                    // Column (Cột dọc): Xếp Tiêu đề, Mô tả và Giá tiền theo thứ tự trên xuống
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trái cho tất cả các chữ
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Chia đều khoảng cách dọc giữa các phần tử
                      children: [
                        
                        // Tiêu đề sản phẩm
                        const Text(
                          'Laptop Gaming G5',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // Chữ đậm
                            fontSize: 18,               // Kích thước chữ lớn
                            color: Colors.black87,
                          ),
                          maxLines: 1, // Giới hạn chỉ hiển thị trên 1 dòng
                          overflow: TextOverflow.ellipsis, // Nếu quá dài thì hiện dấu "..."
                        ),

                        // Mô tả ngắn gọn
                        Text(
                          'Cấu hình mạnh mẽ với chip thế hệ mới nhất, phù hợp cho mọi tác vụ nặng.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600], // Màu xám để phân biệt với tiêu đề
                          ),
                          maxLines: 2, // Giới hạn tối đa 2 dòng
                          overflow: TextOverflow.ellipsis, // Cắt bớt nếu vượt quá 2 dòng
                        ),

                        // Giá tiền và Nút bấm (Dùng thêm một Row nhỏ bên trong Column)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Đẩy giá sang trái, icon sang phải
                          children: [
                            const Text(
                              '25.000.000đ',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            // Biểu tượng nút thêm vào giỏ hàng
                            Icon(Icons.add_shopping_cart, color: Colors.blueAccent, size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // --- KẾT THÚC CẤU TRÚC THẺ SẢN PHẨM ---
        ),
      ),
    );
  }
}
```

---

### PHÂN TÍCH CÁC THÀNH PHẦN CHI TIẾT TRONG VÍ DỤ

1.  **Hệ thống lồng ghép (Composition)**:
    *   `Scaffold` -> `Center` -> `Padding` -> `Container` -> `Row` -> [`Container(Ảnh)`, `Expanded` -> `Column` -> `Text`].
    *   Đây là cách tư duy layout trong Flutter: Chia nhỏ giao diện thành các khối và lồng chúng lại với nhau.

2.  **Tại sao dùng `Expanded` cho phần văn bản?**
    *   Khi sử dụng `Row`, các Widget con mặc định sẽ cố gắng chiếm diện tích theo nội dung của chúng. Nếu đoạn văn bản quá dài, `Row` không biết phải thu hẹp ở đâu và sẽ tràn ra ngoài mép màn hình (gây ra lỗi sọc vàng đen). `Expanded` báo hiệu cho Flutter rằng: "Hãy ưu tiên các Widget cố định trước, còn lại bao nhiêu không gian thì cho đoạn văn bản này dùng hết".

3.  **Thuộc tính `BoxDecoration`**:
    *   Đây là công cụ mạnh nhất để biến một `Container` rỗng thành một thành phần giao diện đẹp mắt. Nó quản lý mọi thứ liên quan đến thị giác: Màu nền (`color`), góc bo (`borderRadius`), và bóng đổ (`boxShadow`).

4.  **Kiểm soát văn bản (`maxLines` và `overflow`)**:
    *   Trong lập trình di động, kích thước màn hình rất đa dạng. Việc sử dụng `maxLines` giúp giao diện luôn ổn định, không bị vỡ khi tiêu đề sản phẩm quá dài trên các thiết bị màn hình nhỏ.

5.  **Khoảng cách (`SizedBox` vs `Padding`)**:
    *   Trong ví dụ này, `mainAxisAlignment: MainAxisAlignment.spaceEvenly` trong `Column` được dùng để tự động giãn cách. Nếu muốn kiểm soát khoảng cách thủ công giữa 2 Widget, có thể chèn một `const SizedBox(height: 10)` vào giữa chúng.