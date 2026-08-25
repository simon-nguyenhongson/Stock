# Thu thập & kiểm chứng dữ liệu

## Giá thị trường cổ phiếu

Lấy giá cho **tất cả** mã trong danh mục + chiến lược mua + watchlist.

- Trong giờ giao dịch → giá khớp lệnh mới nhất. Ngoài giờ → giá đóng cửa phiên gần nhất, và ghi rõ trong báo cáo đây là giá phiên nào.
- **Tách riêng truy vấn từng mã.** Một search cho một mã, ví dụ `giá cổ phiếu VIX ngày DD/MM/YYYY CafeF`. Gộp nhiều mã vào một truy vấn làm công cụ tìm kiếm trả về số liệu lẫn lộn hoặc cũ.
- **Đối chiếu chéo** giá vừa lấy với giá TT gần nhất trong `DANH_MUC.md` và bối cảnh thị trường. Lệch bất thường (>7% một phiên với mã không có tin) → tra lại nguồn thứ hai trước khi dùng.
- Không tìm được → ghi `n/a` trong bảng và liệt kê mã đó ở cuối báo cáo, không điền số ước đoán.

Nguồn ưu tiên: CafeF, Vietstock, 24HMoney, Investing.com.

## BCTC — Lợi nhuận cổ đông công ty mẹ

Cho từng mã, fetch `https://24hmoney.vn/stock/{MÃ}/financial-report` (ví dụ `HPG`, `SHB`, `MBS`, `SHS`, `VIX`, `MSN`).

Trong bảng **Báo cáo kết quả kinh doanh (theo Quý)**, tìm dòng **"Lợi nhuận của Cổ đông của Công ty mẹ"** (với ngân hàng/chứng khoán có thể là LNST hợp nhất). Lấy 2 giá trị ở 2 cột liền nhau:

1. Lợi nhuận **quý gần nhất** (đơn vị: tỷ đồng).
2. **% so với cùng kỳ (YoY)** ở cột kế tiếp.

Hiển thị gộp trong một ô: `xxx tỷ (+xx%)` — % dương dùng class `.up`, % âm dùng class `.down`. Tiêu đề cột ghi đúng quý thực tế lấy được (ví dụ `LNST Q2/2026`), không hardcode quý cũ.

## Vàng Việt Nam

- SJC miếng 1 lượng: mua vào + bán ra.
- Nhẫn trơn 9999: SJC, DOJI, PNJ, Bảo Tín Minh Châu.
- XAU/USD spot + xu hướng đêm qua và lý do.
- Chênh lệch SJC vs thế giới quy đổi (triệu VND/lượng). Chênh > 15 triệu/lượng → đưa vào `div.warn`.

Vùng mua/bán dự kiến suy ra từ: xu hướng XAU/USD, hỗ trợ/kháng cự kỹ thuật, mức chênh SJC–thế giới, tâm lý thị trường. Nêu rõ rủi ro (chênh lệch quá lớn, chính sách Fed, địa chính trị).

## Tính toán

- `P&L = (Giá TT − Giá vốn) × SL`, kèm % so với giá vốn.
- `Khoảng cách tới stop-loss (%) = (Giá TT − Stop) / Giá TT × 100`. Âm nghĩa là **đã vi phạm stop-loss** → `div.warn`.
- `Biên tăng kỳ vọng (%) = (Target − Giá TT) / Giá TT × 100`.
- Tổng vốn, tổng thị giá, P&L tổng và mức thay đổi so với lần briefing trước (lấy từ `DANH_MUC.md`).
