# Agent rules — Stock workspace

Workflow definition lives in [.claude/skills/briefing/SKILL.md](../.claude/skills/briefing/SKILL.md) (single source; do not duplicate it here). Project context and file map: [CLAUDE.md](../CLAUDE.md).

## Data verification

- **Single source of truth:** `DANH_MUC.md` holds every portfolio fact — holdings, quantities, entry prices, cash, stop-loss, target, watchlist, buy strategy, gold bands. Never hardcode these elsewhere.
- **Do not hallucinate:** if a price is missing from search results, output `n/a` and list the symbol at the end of the report. Never invent a number or silently reuse a stale one.
- **Isolate queries:** one search per symbol (e.g. `giá cổ phiếu FPT ngày DD/MM/YYYY`). Bundling symbols makes search tools return mixed-up or stale figures.
- **Cross-check:** compare every fetched price against the last known price in `DANH_MUC.md` and market context; re-query a second source when a single session moves >7% without news.
- **Financials:** take "Lợi nhuận của Cổ đông của Công ty mẹ" for the latest quarter plus YoY % from `https://24hmoney.vn/stock/{SYMBOL}/financial-report`. Label the column with the actual quarter fetched.

## Output

- Vietnamese with diacritics; numbers in tables; narrative as bullet points; always carry the "tham khảo, không phải khuyến nghị đầu tư" disclaimer.
- This is a personal investment portfolio, not bank data.
