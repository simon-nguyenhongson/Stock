# 📈 Briefing sáng — Chứng khoán & Vàng Việt Nam

> Skill `/briefing` cho Claude Code, viết theo chuẩn **Agent Skills** của Anthropic.
> Kèm bản hướng dẫn dùng cho Claude.ai Projects, Antigravity, Cursor và Windsurf.

---

## ⚡ Bắt đầu nhanh

### Claude Code (CLI / VS Code)

1. Copy thư mục `.claude/` và file `CLAUDE.md` vào thư mục làm việc của bạn.
2. Đặt `DANH_MUC.md` (hoặc điền `DANH_MUC_TEMPLATE.md` rồi đổi tên) vào cùng thư mục đó.
3. Mở session mới rồi gõ:

   ```text
   /briefing
   ```

Muốn dùng được ở mọi thư mục thì copy `.claude/skills/briefing/` vào `~/.claude/skills/` — nhưng khi đó chỉ nên giữ **một** bản để hai bản không lệch nhau.

### Claude.ai (Web / Desktop Projects)

1. Copy nội dung trong `PROJECT_INSTRUCTIONS_CLAUDE_AI.md` vào **Project Instructions**.
2. Tải `DANH_MUC.md` vào **Project Knowledge**.
3. Chat: `/briefing` hoặc "chạy briefing sáng cho danh mục của tôi".

### Antigravity / Cursor / Windsurf

Xem `HUONG_DAN_CAI_DAT_VA_SU_DUNG.md` mục 2.

---

## 📂 Nội dung gói

```text
.claude/skills/briefing/
├── SKILL.md                      # Quy trình 6 bước (bản duy nhất — chỉ sửa ở đây)
├── references/data-sources.md    # Quy tắc tra giá, BCTC 24HMoney, vàng, công thức P&L
├── references/report-spec.md     # Cấu trúc 7 mục HTML, quy tắc class & bảng
└── assets/briefing-template.html # Template báo cáo kèm design system
.agents/AGENTS.md                 # Quy tắc dữ liệu cho các agent IDE khác
CLAUDE.md                         # Bối cảnh project cho Claude Code
PROJECT_INSTRUCTIONS_CLAUDE_AI.md # Prompt dán vào Claude.ai Projects
DANH_MUC.md                       # Dữ liệu danh mục mẫu
DANH_MUC_TEMPLATE.md              # Bản mẫu trống
bang_C2.md                        # Bảng đồng bộ ngưỡng trigger
briefing.html                     # Ví dụ báo cáo đã sinh
chien_luoc_ve_bo.html             # Dashboard quản trị rủi ro
open_briefing.bat                 # Mở báo cáo bằng trình duyệt mặc định
launch_briefing.bat               # Mở báo cáo qua Task Scheduler
HUONG_DAN_CAI_DAT_VA_SU_DUNG.md   # Hướng dẫn chi tiết
```

Báo cáo là **thông tin tham khảo cá nhân, không phải khuyến nghị đầu tư**.
