# Flutter - Kiến Thức Cơ Bản

## Layout Cơ Bản của Flutter

### Cấu trúc chính
Flutter ứng dụng được xây dựng dựa trên **Widget Tree** với cấu trúc chính như sau:

```
MaterialApp
  └── home (Widget)
      └── Scaffold
          ├── appBar (AppBar)
          │   └── title
          │   └── backgroundColor
          │   └── ...
          └── body (Widget)
```

### Chi tiết các thành phần

#### 1. **MaterialApp**
- Widget gốc của ứng dụng Flutter.
- Cung cấp các tính năng Material Design (màu sắc, kiểu chữ, animation, v.v.).
- **Thuộc tính chính:**
  - `title`: Tên ứng dụng (hiển thị trên taskbar hoặc danh sách ứng dụng)
  - `home`: Widget chính được hiển thị khi ứng dụng khởi động
  - `theme`: Cài đặt chủ đề toàn cục

#### 2. **Scaffold**
- Widget giúp tổ chức layout Material Design cơ bản.
- Cung cấp các slot cho `appBar`, `body`, `floatingActionButton`, v.v.

#### 3. **AppBar** (Header/Title)
- Thanh header ở phía trên ứng dụng.
- **Thuộc tính chính:**
  - `title`: Tiêu đề hiển thị ở giữa hoặc trái
  - `backgroundColor`: Màu nền của AppBar
  - `centerTitle`: Căn giữa tiêu đề (`true`/`false`)
  - `elevation`: Độ bóng dưới AppBar

#### 4. **Body**
- Widget chứa nội dung chính của ứng dụng.
- Có thể là bất kỳ widget nào: `Text`, `Container`, `Column`, `Row`, v.v.
- Thường được bọc trong `Center` để căn giữa, hoặc `SingleChildScrollView` để cuộn nếu nội dung dài.

### Ví dụ cơ bản

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",           // Tên ứng dụng
      home: Scaffold(
        appBar: AppBar(
          title: Text("My First Demo"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            "My Content",
            style: TextStyle(fontSize: 24, color: Colors.brown),
          ),
        ),
      ),
    );
  }
}
```

### Tóm tắc
- **MaterialApp**: Khởi tạo ứng dụng với Material Design.
- **title**: Tên ứng dụng.
- **home**: Widget được hiển thị đầu tiên (thường là Scaffold).
- **AppBar** (header): Hiển thị tiêu đề và các tùy chọn.
- **body**: Nội dung chính của ứng dụng.
