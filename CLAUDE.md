# Stock — Danh mục chứng khoán & vàng cá nhân

Workspace phục vụ theo dõi danh mục đầu tư **cá nhân** (HOSE/HNX/UPCoM + vàng SJC/nhẫn 9999) và sinh báo cáo briefing. Đây **không phải** dữ liệu ngân hàng hay dữ liệu công việc.

## Lệnh

- `/briefing` — chạy toàn bộ quy trình briefing: đọc `DANH_MUC.md`, thu thập tin tức + giá thị trường + giá vàng, lấy BCTC quý gần nhất từ 24HMoney, tính P&L và khoảng cách stop-loss/target, sinh `briefing.html`, cập nhật `DANH_MUC.md`, rồi mở báo cáo.

Đây là **lệnh duy nhất** của workspace. Chạy được ở bất kỳ thời điểm nào trong ngày (trước phiên / trong phiên / sau phiên) — báo cáo phải tự ghi rõ giá đang dùng là giá đóng cửa hay giá trong phiên.

Định nghĩa skill: [.claude/skills/briefing/SKILL.md](.claude/skills/briefing/SKILL.md) — đây là bản duy nhất, mọi thay đổi chỉ sửa ở đây.

## Quy tắc dữ liệu (bắt buộc)

1. **`DANH_MUC.md` là nguồn dữ liệu duy nhất** cho mã nắm giữ, số lượng, giá vốn, tiền mặt, stop-loss, target, watchlist, chiến lược mua và vùng giá vàng. Không hardcode các giá trị này ở bất kỳ đâu khác.
2. **Không bịa số.** Không tìm được giá của một mã thì ghi `n/a` và liệt kê ở cuối báo cáo — tuyệt đối không suy đoán hay dùng lại số cũ mà không nói rõ.
3. **Tách riêng truy vấn từng mã** khi tra giá hoặc BCTC (`giá cổ phiếu HPG ngày DD/MM/YYYY`). Gộp nhiều mã vào một truy vấn làm kết quả lẫn lộn.
4. **Đối chiếu chéo** mọi con số với giá TT gần nhất trong `DANH_MUC.md` và bối cảnh thị trường trước khi dùng.
5. **BCTC**: lấy dòng "Lợi nhuận của Cổ đông của Công ty mẹ" quý gần nhất + %YoY từ `https://24hmoney.vn/stock/{MÃ}/financial-report`. Nhãn cột ghi đúng quý thực tế lấy được, không hardcode.
6. **Mã nào thiếu Stop-loss/Target thì tự lập rồi ghi vào `DANH_MUC.md`** — không để trống và không hỏi người dùng. Stop dựa vào hỗ trợ kỹ thuật (hoặc biên rủi ro 6–8% cho large-cap, 10–15% cho mid/small-cap), target lấy từ dải giá mục tiêu của ít nhất 2 CTCK hoặc đỉnh 52 tuần, R:R tối thiểu 2:1. Ngược lại, **giá vốn và số lượng thì phải hỏi** — đó là dữ kiện giao dịch thật, không được suy ra.
7. Báo cáo luôn viết **tiếng Việt có dấu**, mọi diễn giải là bullet point, mọi số liệu nằm trong bảng, và luôn kèm disclaimer "tham khảo, không phải khuyến nghị đầu tư".

## File chính

| File | Vai trò |
|---|---|
| [DANH_MUC.md](DANH_MUC.md) | Nguồn dữ liệu duy nhất: danh mục, tiền mặt, stop-loss/target, watchlist, vàng, nhật ký trigger |
| [briefing.html](briefing.html) | Báo cáo sinh ra mỗi lần chạy `/briefing` (luôn ghi đè, đường dẫn cố định) |
| [open_briefing.bat](open_briefing.bat) | Nhấp đúp để mở báo cáo bằng trình duyệt mặc định |
| [launch_briefing.bat](launch_briefing.bat) | Mở báo cáo qua Task Scheduler (session không tương tác) |
| [Stock_Briefing_Package/](Stock_Briefing_Package/) | Bản đóng gói để mang skill sang máy/nền tảng khác |
