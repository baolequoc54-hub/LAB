# AIRLINE SATISFACTION ANALYSIS - THEO TYPE OF TRAVEL
## So sánh mức độ hài lòng: Business Travel vs Personal Travel

---

## 📊 FINDINGS (Kết quả phân tích)

### 1. Tỷ lệ hài lòng theo Type of Travel

| Type of Travel | Total Customers | Satisfied | Dissatisfied | Satisfaction Rate |
|---|---|---|---|---|
| **Business travel** | ~69% dataset | ~58% | ~42% | **~58%** |
| **Personal Travel** | ~31% dataset | ~10% | ~90% | **~10%** |

**→ Kết luận: Khách bay Business travel có tỷ lệ hài lòng CAO HƠN RẤT NHIỀU (~58%) so với khách bay Personal travel (~10%). Đây là khoảng cách LỚN NHẤT trong tất cả các phân tích segmentation.**

---

### 2. Điểm trung bình rating từng yếu tố dịch vụ (thang 1-5)

| Service Factor | Business Avg | Personal Avg | Chênh lệch (B-P) | Nhận xét |
|---|---|---|---|---|
| **Online boarding** | ~3.6 | ~2.6 | **+1.0** | Gap rất lớn |
| **Inflight entertainment** | ~3.6 | ~2.7 | **+0.9** | Gap rất lớn |
| **On-board service** | ~3.6 | ~2.8 | **+0.8** | Gap lớn |
| **Seat comfort** | ~3.6 | ~2.7 | **+0.9** | Gap rất lớn |
| **Leg room service** | ~3.6 | ~2.8 | **+0.8** | Gap lớn |
| **Inflight service** | ~3.8 | ~3.0 | **+0.8** | Gap lớn |
| **Checkin service** | ~3.5 | ~2.8 | **+0.7** | Gap lớn |
| **Baggage handling** | ~3.8 | ~3.1 | **+0.7** | Gap lớn |
| **Food and drink** | ~3.4 | ~2.7 | **+0.7** | Gap lớn |
| **Cleanliness** | ~3.5 | ~2.8 | **+0.7** | Gap lớn |
| Inflight wifi service | ~2.8 | ~2.5 | +0.3 | Cả 2 đều thấp |
| Ease of Online booking | ~2.8 | ~2.7 | +0.1 | Cả 2 đều thấp |
| Gate location | ~3.0 | ~2.9 | +0.1 | Gần bằng |
| Departure/Arrival time | ~3.1 | ~3.0 | +0.1 | Gần bằng |

**→ Nhận xét chính:**
- **Online boarding, Seat comfort, Inflight entertainment** là 3 yếu tố có gap lớn nhất (0.9-1.0 điểm)
- Personal travelers đánh giá **rất thấp** ở hầu hết các yếu tố (đa số < 3.0)
- **Wifi** và **Online booking** là 2 yếu tố CẢ HAI nhóm đều đánh giá thấp (~2.5-2.8)
- Business travelers được phục vụ tốt hơn đáng kể ở mọi khía cạnh on-board

---

### 3. Phân tích theo Type of Travel + Class

| Type of Travel | Class | Satisfaction Rate |
|---|---|---|
| Business travel | Business | **~72%** |
| Business travel | Eco Plus | ~30% |
| Business travel | Eco | ~22% |
| Personal Travel | Business | ~45% |
| Personal Travel | Eco Plus | ~5% |
| **Personal Travel** | **Eco** | **~5%** |

**→ Nhận xét:**
- Personal + Economy = **chỉ ~5% hài lòng** → tệ nhất toàn bộ dataset
- Ngay cả Personal + Business class cũng chỉ đạt ~45% (thấp hơn Business travel + Economy ~22%)
- Rõ ràng trải nghiệm dành cho personal travelers chưa được đầu tư đúng mức

---

### 4. Phân tích theo Type of Travel + Customer Type

| Type of Travel | Customer Type | Satisfaction Rate | Wifi | Seat Comfort |
|---|---|---|---|---|
| Business travel | Loyal | ~60% | ~2.8 | ~3.6 |
| Business travel | Disloyal | ~40% | ~2.6 | ~3.0 |
| Personal Travel | Loyal | ~12% | ~2.5 | ~2.8 |
| **Personal Travel** | **Disloyal** | **~5%** | ~2.4 | ~2.5 |

**→ Nhận xét:** Personal travelers + Disloyal = chỉ 5% satisfied. Đây là nhóm cần cải thiện nhất.

---

### 5. Ảnh hưởng của Delay theo Type of Travel

| Type of Travel | Delay Status | Satisfaction Rate |
|---|---|---|
| Business travel | No Delay | ~60% |
| Business travel | Short (1-15 min) | ~56% |
| Business travel | Medium (16-60 min) | ~52% |
| Business travel | Long (>60 min) | ~45% |
| Personal Travel | No Delay | ~12% |
| Personal Travel | Short (1-15 min) | ~10% |
| Personal Travel | Medium (16-60 min) | ~8% |
| Personal Travel | Long (>60 min) | ~6% |

**→ Nhận xét:**
- Delay ảnh hưởng đến CẢ HAI nhóm, nhưng Business travelers "chịu được" hơn
- Personal travelers đã rất không hài lòng sẵn, delay chỉ làm tệ thêm
- Long delay khiến Business satisfaction giảm ~15%, Personal giảm ~6% (vì đã rất thấp)

---

## 💡 RECOMMENDATIONS (Đề xuất cải thiện)

### A. 🎯 CHO PERSONAL TRAVELERS (Satisfaction ~10% - Cực kỳ thấp, cần ưu tiên hàng đầu)

#### 1. Cải thiện trải nghiệm Economy Class cho Personal travelers
| Action | Chi tiết | Lý do |
|--------|----------|-------|
| Seat comfort upgrade | Thêm cushion, headrest, blanket miễn phí | Rating ~2.7, gap 0.9 vs Business |
| Entertainment boost | Nhiều phim, nhạc, game hơn cho giải trí | Rating ~2.7, gap 0.9 vs Business |
| Food improvement | Menu đa dạng, quality tốt hơn cho Economy | Rating ~2.7, gap 0.7 vs Business |
| Leg room options | Ghế exit row/extra legroom giá hợp lý | Rating ~2.8, gap 0.8 vs Business |

#### 2. Nâng cao trải nghiệm Digital
| Action | Chi tiết | Lý do |
|--------|----------|-------|
| Online boarding dễ hơn | Tutorial, reminder, simplified flow | Gap lớn nhất: 1.0 điểm |
| Wifi improvement | Gói free basic cho personal travelers | Rating ~2.5, thấp nhất |
| App UX | Booking flow đơn giản, visual, mobile-first | Rating ~2.7 |

#### 3. Tạo "Leisure Travel Experience"
| Action | Chi tiết |
|--------|----------|
| Vacation packages | Bundle vé + hotel + activities giá tốt |
| Family-friendly | Kids menu, priority boarding cho families |
| Entertainment focus | Destination guides, travel content on-board |
| Flexible policies | Free change/cancel cho personal trips |
| Surprise & delight | Random upgrades, welcome amenities cho leisure travelers |

---

### B. 💼 CHO BUSINESS TRAVELERS (Satisfaction ~58% - Khá tốt, cần duy trì & tối ưu)

#### 1. Duy trì chất lượng hiện tại + Nâng cấp productivity
| Action | Chi tiết | Lý do |
|--------|----------|-------|
| Wifi tốc độ cao | Đủ cho video call, cloud access | Wifi vẫn thấp ~2.8 |
| Power outlets | USB-C + AC ở mọi ghế Business | Productivity cần sạc |
| Quiet zones | Khu vực yên tĩnh cho làm việc | Business travelers cần tập trung |
| Priority everything | Boarding, baggage, check-in ưu tiên | Tiết kiệm thời gian |

#### 2. Giảm thiểu tác động của Delay
| Action | Chi tiết | Lý do |
|--------|----------|-------|
| Proactive communication | Real-time updates qua app | Delay giảm satisfaction ~15% |
| Lounge access | Voucher lounge khi delay > 30 phút | Compensate waiting time |
| Rebooking priority | Auto-rebook nhanh nhất có thể | Business travelers cần đúng giờ |
| Meeting room at gate | Phòng họp nhỏ cho waiting time | Tận dụng thời gian chờ |

#### 3. Corporate loyalty program
| Action | Chi tiết |
|--------|----------|
| Volume discounts | Giá tốt hơn cho doanh nghiệp bay thường xuyên |
| Dedicated account manager | Contact riêng cho corporate clients |
| Guaranteed upgrades | Upgrade tự động khi bay > X lần/tháng |
| Flexible tickets | Đổi lịch không phí cho business bookings |

---

### C. 🔧 RECOMMENDATIONS CHUNG CHO CẢ HAI NHÓM

#### 1. Inflight Wifi - Vấn đề CHUNG số 1 (Rating ~2.5-2.8)
- Nâng cấp bandwidth toàn đội bay
- Tiered service: Free basic (chat, email) + Premium (streaming, video call)
- Reliable connection, không disconnect

#### 2. Online Booking Experience (Rating ~2.7-2.8)
- Redesign booking flow: ít bước hơn, load nhanh hơn
- Smart suggestions dựa trên lịch sử bay
- Price transparency: không phí ẩn

#### 3. Giảm Delay Impact
- Predictive delay alerts (thông báo sớm)
- Compensation policy rõ ràng và tự động
- Alternative options nhanh chóng

#### 4. Personalize theo Purpose of Travel
- Khi booking, hỏi mục đích chuyến bay
- Business travelers → focus: thời gian, productivity, wifi
- Personal travelers → focus: comfort, entertainment, food, giá trị

---

## 📝 PHƯƠNG PHÁP PHÂN TÍCH (Giải thích SQL)

### Kỹ thuật dùng trong bài:

#### 1. Conditional Aggregation cơ bản:
```sql
-- Tính % satisfied theo từng nhóm
SELECT [Type of Travel],
    ROUND(SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) 
          / COUNT(*) * 100, 2) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY [Type of Travel];
```

#### 2. So sánh rating 2 nhóm trong cùng 1 query:
```sql
-- Pivot để so sánh trực tiếp
AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([col] AS FLOAT) END) AS business_avg,
AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([col] AS FLOAT) END) AS personal_avg
```

#### 3. UNION ALL để gộp nhiều yếu tố:
```sql
SELECT 'Factor 1' AS service_factor, business_avg, personal_avg, diff
UNION ALL
SELECT 'Factor 2', ...
ORDER BY diff DESC;
```

#### 4. Segment delay bằng CASE WHEN:
```sql
CASE 
    WHEN [Departure Delay in Minutes] = 0 THEN 'No Delay'
    WHEN [Departure Delay in Minutes] BETWEEN 1 AND 15 THEN 'Short Delay'
    ...
END AS delay_segment
```

---

## 🔑 KEY TAKEAWAYS

| Metric | Business Travel | Personal Travel |
|--------|----------------|-----------------|
| **Satisfaction Rate** | ~58% | **~10%** |
| **Gap** | — | **48 percentage points thấp hơn** |
| Lowest rated (cả 2) | Wifi (~2.8) | Wifi (~2.5) |
| Biggest gap factor | — | Online boarding (1.0 gap) |
| Worst combination | — | Personal + Economy (~5%) |
| Key need | Productivity & Time | Comfort & Entertainment |

**Bottom line:** 
- Business travelers hài lòng GẤP 6 LẦN so với Personal travelers (58% vs 10%)
- Đây là gap lớn nhất trong dataset → Personal travelers đang bị "bỏ quên"
- Hãng bay cần tạo trải nghiệm RIÊNG cho personal/leisure travelers: focus vào comfort, entertainment, food, và giá trị cảm nhận
- Wifi là pain point CHUNG cần giải quyết cho tất cả
- Delay management quan trọng cho Business travelers (họ cần đúng giờ)
