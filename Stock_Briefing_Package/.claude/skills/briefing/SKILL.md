---
name: briefing
description: Chạy briefing sáng cho danh mục chứng khoán cá nhân và vàng Việt Nam — đọc DANH_MUC.md, thu thập tin tức và giá thị trường mới nhất, lấy BCTC quý gần nhất từ 24HMoney, tính P&L cùng khoảng cách stop-loss/target, xuất báo cáo briefing.html và mở trên trình duyệt. Dùng khi người dùng gọi /briefing, yêu cầu "briefing sáng", "báo cáo danh mục", "cập nhật giá cổ phiếu và vàng", hoặc hỏi về tình trạng danh mục đầu tư cá nhân của họ. Đây là danh mục cá nhân, KHÔNG phải dữ liệu ngân hàng.
---

# Briefing sáng — Danh mục chứng khoán & vàng Việt Nam

Toàn bộ báo cáo viết bằng **tiếng Việt có dấu**. Đầu báo cáo ghi rõ ngày chạy.

## Nguyên tắc bắt buộc

1. **`DANH_MUC.md` là nguồn dữ liệu duy nhất.** Không hardcode mã cổ phiếu, giá vốn, số lượng, stop-loss, target hay vùng giá vàng. File đổi → báo cáo phải tự đổi theo.
2. **Không bịa số.** Nếu không tìm được giá của một mã, ghi rõ "không tra được" thay vì suy đoán hoặc dùng số cũ.
3. **Tách riêng truy vấn từng mã.** Không gộp nhiều mã vào một lần search.
4. **Mọi phần diễn giải là bullet point** (`<ul><li>`), không viết đoạn văn dài. Mọi dữ liệu số nằm trong `<table>`.
5. **Đây là thông tin tham khảo, không phải khuyến nghị đầu tư** — luôn giữ `div.disclaimer` ở đầu báo cáo.

## Quy trình

Tạo todo list 6 bước dưới đây rồi thực hiện tuần tự.

### Bước 1 — Đọc danh mục (làm trước tiên)

Đọc `DANH_MUC.md` ở thư mục làm việc hiện tại. Nếu không có, thử `D:\0.Work\Others\Stock\DANH_MUC.md`; vẫn không có thì hỏi người dùng cung cấp file.

Trích ra: mã **đang nắm giữ** (SL > 0), mã trong **chiến lược mua**, mã trong **watchlist**, mã **đã loại**, giá vốn / SL / stop-loss / target từng mã, tiền mặt khả dụng, NAV, và phần **vàng** (vùng mua/bán dự kiến, ghi chú chiến lược).

### Bước 2 — Tin tức & thị trường thế giới

- Tin tức đêm qua/sáng nay ảnh hưởng tới **tất cả** mã trong danh mục + chiến lược + watchlist (CafeF, Vietstock, Investing.com và các trang tin uy tín trong nước).
- Chỉ số thế giới: Dow Jones, S&P 500, Nasdaq, Nikkei, KOSPI, Thượng Hải, Hang Seng.
- Hàng hoá & tỷ giá: thép HRC/thép xây dựng, dầu WTI, DXY, USD/VND, XAU/USD.
- Đánh giá tác động tới từng mã theo ngành ghi trong `DANH_MUC.md`.

### Bước 3 — Vàng Việt Nam

Giá SJC miếng 1 lượng và nhẫn trơn 9999 (SJC, DOJI, PNJ, Bảo Tín Minh Châu), XAU/USD spot, chênh lệch SJC vs thế giới quy đổi, xu hướng đêm qua. Đưa ra vùng mua và vùng bán dự kiến; nếu `DANH_MUC.md` có vùng chiến lược thì so sánh và cảnh báo khi gần trigger.

### Bước 4 — Giá thị trường, BCTC & P&L

Chi tiết quy tắc thu thập và kiểm chứng: đọc [references/data-sources.md](references/data-sources.md).

Ngắn gọn: lấy giá khớp lệnh mới nhất (hoặc giá đóng cửa phiên gần nhất nếu ngoài giờ) cho từng mã; lấy "Lợi nhuận của Cổ đông của Công ty mẹ" quý gần nhất + %YoY từ `24hmoney.vn/stock/{MÃ}/financial-report`; tính P&L từng mã theo giá vốn × SL; tính khoảng cách % tới stop-loss và biên tăng kỳ vọng tới target.

### Bước 5 — Cảnh báo & tóm tắt

- Cảnh báo mã chạm/gần **stop-loss** hoặc **target**, mã trong chiến lược mua gần **trigger kích hoạt**, và cảnh báo vàng nếu có.
- Tóm tắt 1 trang: 3 điểm chính + hành động đề xuất hôm nay.

### Bước 6 — Xuất báo cáo & trình cho người dùng

1. Sinh `briefing.html` tại thư mục làm việc (ghi đè file cũ để đường dẫn cố định). Bắt đầu từ [assets/briefing-template.html](assets/briefing-template.html) — template đã chứa sẵn đúng CSS design system, **không tự đổi màu/font/layout**. Cấu trúc 7 mục và quy tắc bảng: [references/report-spec.md](references/report-spec.md).
2. Cập nhật `DANH_MUC.md`: giá TT mới, mốc thời gian cập nhật, và thêm một dòng vào bảng nhật ký kiểm tra trigger (nếu file có bảng này).
3. Cập nhật/tạo `open_briefing.bat` cạnh báo cáo:
   ```bat
   @echo off
   set "SCRIPT_DIR=%~dp0"
   start "" "%SCRIPT_DIR%briefing.html"
   ```
4. Mở báo cáo: `powershell -Command "Start-Process '<đường dẫn tuyệt đối>\briefing.html'"` (mở bằng trình duyệt mặc định — không phụ thuộc Chrome đã cài).
5. Báo lại cho người dùng đường dẫn file + 3 điểm chính, kèm danh sách dữ liệu nào không tra được (nếu có).

## Khi dữ liệu thiếu

Nếu `DANH_MUC.md` thiếu giá vốn/SL: vẫn làm đủ bước 2, 3, 5, 6; bỏ phần P&L và cảnh báo stop-loss; nhắc người dùng bổ sung đúng ô còn trống.
