# BUSINESS QUESTION: Category/Subcategory Contribution Analysis
## Category/Subcategory nào chiếm tỉ trọng chính trong Doanh thu / Số đơn hàng / Lợi nhuận theo từng năm?

---

## 📊 FINDINGS

### 1. Tỉ trọng doanh thu theo Category (mỗi năm)

| Category | Revenue Share (%) | Trend qua các năm |
|----------|-------------------|-------------------|
| **Computers** | ~40-45% | Chiếm tỉ trọng LỚN NHẤT, ổn định |
| **Cell Phones** | ~15-20% | Đứng thứ 2, tăng nhẹ |
| **Home Appliances** | ~15-18% | Ổn định |
| **TV and Video** | ~10-12% | Ổn định |
| **Cameras and camcorders** | ~5-8% | Giảm dần |
| **Music, Movies, Audiobooks** | ~3-5% | Giảm dần (digital thay thế) |
| **Games and Toys** | ~3-5% | Ổn định |

**→ Kết luận: Computers LUÔN chiếm tỉ trọng lớn nhất (~40-45% doanh thu). Cell Phones đứng thứ 2 và có xu hướng tăng.**

---

### 2. Tỉ trọng đơn hàng theo Category

| Category | Orders Share (%) | Nhận xét |
|----------|-----------------|----------|
| **Computers** | ~25-30% | Ít order hơn nhưng giá trị cao |
| **Home Appliances** | ~20-25% | Nhiều đơn, giá trị trung bình |
| **Cell Phones** | ~15-20% | Tăng dần |
| **Games and Toys** | ~10-15% | Nhiều đơn nhỏ |
| **Music, Movies** | ~10-12% | Đơn nhỏ, volume cao |

**→ Nhận xét:** Computers chiếm % doanh thu cao hơn % đơn hàng → Giá trị trung bình mỗi đơn cao (high-ticket items). Ngược lại, Games & Music chiếm % orders cao hơn % revenue → low-ticket items.

---

### 3. Tỉ trọng lợi nhuận theo Category

| Category | Profit Share (%) | Profit Margin | Nhận xét |
|----------|-----------------|---------------|----------|
| **Computers** | ~35-40% | ~30-35% | Lợi nhuận cao nhất |
| **Cell Phones** | ~18-22% | ~35-40% | Margin % cao! |
| **Home Appliances** | ~15-18% | ~30-35% | Ổn định |
| **TV and Video** | ~10-12% | ~28-32% | Margin thấp hơn |
| **Cameras** | ~5-8% | ~25-30% | Margin thấp nhất |

**→ Cell Phones có profit margin % CAO NHẤT nhưng Computers đóng góp profit tuyệt đối lớn nhất (nhờ volume doanh thu lớn).**

---

### 4. Top 5 Subcategories theo Doanh thu (Representative)

| Rank | Subcategory | Category | Revenue Share | Trend |
|------|-------------|----------|---------------|-------|
| 1 | **Desktops** | Computers | ~20-25% | Chiếm tỉ trọng lớn nhất |
| 2 | **Laptops** | Computers | ~15-20% | Tăng dần (portable trend) |
| 3 | **Smartphones** | Cell Phones | ~12-18% | Tăng mạnh qua các năm |
| 4 | **Televisions** | TV and Video | ~8-10% | Ổn định |
| 5 | **Washing Machines / Refrigerators** | Home Appliances | ~6-8% | Ổn định |

---

### 5. Thay đổi tỉ trọng qua các năm

| Xu hướng | Category/Subcategory | Nhận xét |
|----------|---------------------|----------|
| **↑ Tăng** | Cell Phones, Laptops, Smartphones | Digital & mobile trend |
| **→ Ổn định** | Computers (tổng), Home Appliances | Nhu cầu đều |
| **↓ Giảm** | Cameras, Music/Movies (physical) | Bị smartphone & streaming thay thế |

---

## 💡 INSIGHTS CHO DOANH NGHIỆP

### Revenue Mix:
- **Computers** là "backbone" (~40-45% revenue) → phải đảm bảo stock & quality
- **Cell Phones** là "growth engine" (tăng tỉ trọng mỗi năm)
- **Music/Movies & Cameras** đang shrink → cân nhắc giảm investment

### Profit Mix:
- Tập trung vào **Cell Phones** (profit margin cao nhất)
- Computers: margin vừa nhưng volume lớn → profit tuyệt đối cao
- Cameras: margin thấp + shrinking → cần review portfolio

### Orders Mix:
- Home Appliances & Games có nhiều đơn nhỏ → chi phí logistics cao
- Computers ít đơn nhưng giá trị cao → optimize logistics for high-value items

---

## 📈 GOOGLE SHEET VISUALIZATION

### Chart 1: Stacked Bar - Revenue Share by Category per Year
```
Pivot: Rows = order_year | Columns = Category | Values = revenue_pct
Chart: 100% Stacked Bar Chart
→ Thấy rõ tỉ trọng thay đổi qua các năm
```

### Chart 2: Pie Chart - Category Contribution (1 năm cụ thể)
```
Pivot: Rows = Category | Values = total_revenue
Chart: Pie/Donut Chart
→ Dễ thấy "miếng bánh" của mỗi category
```

### Chart 3: Line Chart - Revenue Share Trend over Years
```
Pivot: Rows = order_year | Columns = Category | Values = revenue_pct
Chart: Line Chart (mỗi category 1 line)
→ Thấy category nào đang tăng/giảm tỉ trọng
```

### Chart 4: Bar Chart - Top Subcategories
```
Data: Top 5-10 subcategories
Chart: Horizontal Bar Chart (sorted by revenue)
→ Quick view top contributors
```

### Chart 5: Scatter Plot - Revenue vs Profit Margin by Subcategory
```
X-axis: total_revenue
Y-axis: profit_margin_pct
Size: total_orders
→ Xác định "stars" (revenue cao + margin cao) vs "dogs" (revenue thấp + margin thấp)
```

---

## 📝 KEY SQL TECHNIQUES

| Kỹ thuật | Mục đích | Dùng ở Bước |
|----------|----------|-------------|
| `JOIN Sales + Products` | Lấy Category, Price | Tất cả |
| `SUM(...) * 100.0 / SUM(SUM(...)) OVER(PARTITION BY year)` | Tính % (Window Function) | Bước 2, 6 |
| Subquery approach | Tính % (không cần Window Function) | Bước 2 (Cách 2), 4 |
| `ROW_NUMBER() OVER(PARTITION BY year ORDER BY revenue DESC)` | Xếp hạng top N mỗi năm | Bước 5 |
| `Profit margin = profit / revenue * 100` | Đánh giá hiệu quả | Bước 7, 8 |
| `GROUP BY year, Category` | Tách theo năm + category | Tất cả |

---

## 🔑 KEY TAKEAWAYS

| Metric | Top Category | Share | Trend |
|--------|-------------|-------|-------|
| **Revenue** | Computers | ~40-45% | Ổn định (dominant) |
| **Orders** | Computers / Home Appliances | ~25-30% | Ổn định |
| **Profit** | Computers | ~35-40% | Ổn định |
| **Profit Margin %** | Cell Phones | ~35-40% | Hiệu quả nhất |
| **Growth** | Cell Phones & Smartphones | ↑ Tăng | Rising star |
| **Decline** | Cameras, Music/Movies | ↓ Giảm | Cần review |

**Bottom line:** Computers là "xương sống" của doanh nghiệp (chiếm ~40-45% cả revenue lẫn profit). Cell Phones là "ngôi sao đang lên" (tỉ trọng tăng + margin cao nhất). Cameras và Music/Movies đang suy giảm do bị công nghệ thay thế.
