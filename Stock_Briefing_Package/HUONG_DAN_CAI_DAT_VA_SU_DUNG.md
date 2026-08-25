# 📦 Hướng dẫn cài đặt & sử dụng skill `/briefing`

> Skill briefing sáng cho danh mục chứng khoán & vàng Việt Nam, viết theo chuẩn **Agent Skills** của Anthropic (`SKILL.md` + `references/` + `assets/`, progressive disclosure).

---

## 1. Cấu trúc thư mục chuẩn

```text
Stock/
├── .claude/
│   └── skills/
│       └── briefing/
│           ├── SKILL.md                      # Quy trình 6 bước — BẢN DUY NHẤT
│           ├── references/
│           │   ├── data-sources.md           # Tra giá, BCTC 24HMoney, vàng, công thức P&L
│           │   └── report-spec.md            # Cấu trúc 7 mục HTML, class, 3 bảng bắt buộc
│           └── assets/
│               └── briefing-template.html    # Template + design system (Outfit, badge, accordion)
├── .agents/AGENTS.md                         # Quy tắc dữ liệu cho Antigravity / Cursor / Windsurf
├── CLAUDE.md                                 # Bối cảnh project cho Claude Code
├── DANH_MUC.md                               # NGUỒN DỮ LIỆU DUY NHẤT
├── DANH_MUC_TEMPLATE.md                      # Bản mẫu trống
├── briefing.html                             # Báo cáo sinh ra mỗi lần chạy
├── open_briefing.bat / launch_briefing.bat   # Mở báo cáo trên Windows
└── bang_C2.md, chien_luoc_ve_bo.html         # Bảng trigger & dashboard rủi ro
```

Nguyên tắc: **chỉ tồn tại một bản `SKILL.md`.** Không nhân bản sang `.agents/` hay `~/.claude/skills/` cùng lúc, vì hai bản sẽ lệch nhau sau vài lần sửa.

---

## 2. Cài đặt theo nền tảng

### Claude Code (CLI / VS Code) — cách chính

1. Copy `.claude/` và `CLAUDE.md` vào thư mục làm việc.
2. Đặt `DANH_MUC.md` cùng thư mục.
3. Mở **session mới** (skill được nạp lúc khởi động session).
4. Gõ `/briefing`.

Phạm vi cài đặt:

| Vị trí | Hiệu lực | Khi nào dùng |
| --- | --- | --- |
| `<project>/.claude/skills/briefing/` | chỉ trong project | dữ liệu danh mục nằm cố định một thư mục (khuyến nghị) |
| `~/.claude/skills/briefing/` | mọi thư mục | muốn gọi `/briefing` từ bất kỳ đâu |

Nếu cài cả hai, bản project sẽ được ưu tiên — nên chọn một.

### Claude.ai (Web / Desktop Projects)

1. Tạo Project, ví dụ *Stock Assistant*.
2. **Project Knowledge**: tải `DANH_MUC.md`.
3. **Project Instructions**: dán toàn bộ khối trong `PROJECT_INSTRUCTIONS_CLAUDE_AI.md`.
4. Chat `/briefing` hoặc "chạy briefing sáng cho danh mục của tôi".

### Antigravity / Gemini Code Assist

Copy `.agents/AGENTS.md` vào thư mục gốc workspace và tag `@.claude/skills/briefing/SKILL.md` khi yêu cầu chạy briefing.

### Cursor / Windsurf / VS Code Copilot

Copy nội dung `.agents/AGENTS.md` vào `.cursorrules` (Cursor) hoặc `.windsurfrules` (Windsurf), rồi tag `@DANH_MUC.md` và `@.claude/skills/briefing/SKILL.md`.

---

## 3. Tùy biến `DANH_MUC.md`

Đây là file **duy nhất** bạn cần sửa khi giao dịch:

1. **Tiền mặt** — cập nhật mục `Cash khả dụng`.
2. **Danh mục nắm giữ** — thêm dòng khi mua mã mới, sửa SL + giá vốn bình quân khi mua thêm, xóa dòng khi tất toán. Cột *Giá TT* và *P&L* do skill tự điền.
3. **Stop-loss & Target** — chỉnh ngưỡng cắt lỗ và giá mục tiêu.
4. **Vàng** — vùng mua/bán dự kiến cho SJC miếng và nhẫn trơn 9999.
5. **Watchlist / Chiến lược mua** — mã đang chờ trigger kèm điều kiện kích hoạt.

Sau mỗi lần sửa, đổi mốc "cập nhật lần cuối" ở đầu file.

---

## 4. Quy tắc bảo đảm dữ liệu

- **Tách riêng truy vấn:** mỗi mã một lần search, không gộp.
- **Đối chiếu chéo:** so giá vừa tra với giá TT gần nhất trong `DANH_MUC.md`; lệch >7% một phiên mà không có tin → tra lại nguồn thứ hai.
- **Không bịa số:** không tra được thì ghi `n/a` và liệt kê ở cuối báo cáo.
- **BCTC:** `https://24hmoney.vn/stock/{MÃ}/financial-report` → dòng "Lợi nhuận của Cổ đông của Công ty mẹ" quý gần nhất + %YoY. Nhãn cột ghi đúng quý thực tế.
- **Tính toán:** P&L theo giá vốn × SL, khoảng cách % tới stop-loss, biên tăng kỳ vọng tới target.

---

## 5. Mở báo cáo trên Windows

- `open_briefing.bat` — nhấp đúp, mở `briefing.html` bằng trình duyệt mặc định (không phụ thuộc Chrome đã cài).
- `launch_briefing.bat` — mở qua Task Scheduler, dùng khi chạy ở session không tương tác.

Cả hai dùng đường dẫn tương đối (`%~dp0`) nên di chuyển thư mục vẫn chạy được.

---

*Báo cáo do skill sinh ra là thông tin tham khảo cá nhân, không phải khuyến nghị đầu tư.*
