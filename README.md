# Lab F5 – Danh sách & Lưới trong Flutter (`f5_danhsach`)

## Thông tin sinh viên
- **Họ và tên:** Bùi Quang Duy
- **MSSV:** 231A290127
- **Học phần:** INT4211 – Lập trình trên các thiết bị di động

---

## 1. Tính năng cơ bản
- **Model tách biệt:** Lớp `SanPham` lưu trữ thông tin (`ten`, `moTa`, `gia`, `anh`) và hàm định dạng giá `dinhDangGia(int gia)` (ví dụ: `180000` → `180.000 đ`).
- **Tab Danh sách (`ListView.builder`):**
  - Dựng danh sách lười (lazy loading) bằng `ListView.builder` kết hợp `Card` + `ListTile` (`maxLines: 1`, `overflow: TextOverflow.ellipsis`).
  - Thêm sản phẩm mới vào đầu danh sách bằng `FloatingActionButton` (`setState`).
  - Vuốt sang trái để xóa sản phẩm bằng `Dismissible` với `key` duy nhất.
  - Hiển thị trạng thái rỗng (`Danh sách trống` + nút `Thêm sản phẩm`) khi xóa hết phần tử.
- **Tab Lưới (`GridView.builder`):**
  - Hiển thị album sản phẩm 2 cột bằng `SliverGridDelegateWithFixedCrossAxisCount` (`childAspectRatio: 0.78`), không tràn ô.
- **Quản lý Assets:**
  - Khai báo thư mục `assets/images/` trong `pubspec.yaml`, hiển thị ảnh bằng `Image.asset` có `BoxFit.cover` và `errorBuilder`.

---

## 2. Bài nâng cao đã thực hiện: NC3 – SnackBar "Hoàn tác" sau khi xóa

### Yêu cầu
Khi người dùng vuốt xóa một sản phẩm khỏi danh sách, hiển thị `SnackBar` thông báo kèm nút **"Hoàn tác"** (`SnackBarAction`). Khi bấm **"Hoàn tác"**, sản phẩm vừa xóa được khôi phục lại đúng vị trí cũ trong danh sách.

### Cách thực hiện
1. Trong sự kiện `onDismissed` của `Dismissible`, lưu lại vị trí của mục vừa bị xóa (`final viTri = index`) cùng đối tượng sản phẩm `sp` trước khi cập nhật danh sách.
2. Gọi `setState(() => _ds.removeAt(index))` để xóa phần tử khỏi danh sách hiện tại.
3. Gọi `ScaffoldMessenger.of(context).clearSnackBars()` để đóng `SnackBar` cũ (nếu người dùng xóa liên tiếp nhiều mục).
4. Hiển thị `SnackBar` kèm `SnackBarAction(label: 'Hoàn tác', ...)`: khi nhấn vào sẽ gọi `setState(() => _ds.insert(viTri, sp))` để chèn lại sản phẩm về đúng vị trí `viTri`.

### Đoạn mã minh họa (`lib/main.dart`)
```dart
onDismissed: (_) {
  final viTri = index;
  setState(() => _ds.removeAt(index));
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Đã xóa ${sp.ten}'),
      action: SnackBarAction(
        label: 'Hoàn tác',
        onPressed: () => setState(() => _ds.insert(viTri, sp)),
      ),
    ),
  );
},
```

---

## 3. Hướng dẫn chạy dự án
```bash
flutter pub get
flutter run
```
