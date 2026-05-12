-- ============================================================================
-- AIRLINE SATISFACTION ANALYSIS - THEO ĐỘ TUỔI & GEN Z
-- Segment khách hàng theo độ tuổi, phân tích sự hài lòng của Gen Z
-- ============================================================================

-- ============================================================================
-- BƯỚC 1: SEGMENT KHÁCH HÀNG THEO ĐỘ TUỔI (Age Generation)
-- Phân nhóm thế hệ:
--   Gen Z: 7-25 tuổi (sinh 1997-2012)
--   Millennials: 26-41 tuổi (sinh 1981-1996)
--   Gen X: 42-57 tuổi (sinh 1965-1980)
--   Baby Boomers: 58-76 tuổi (sinh 1946-1964)
--   Silent Generation: 77+ tuổi (sinh trước 1946)
-- ============================================================================

SELECT 
    CASE 
        WHEN Age BETWEEN 7 AND 25 THEN 'Gen Z (7-25)'
        WHEN Age BETWEEN 26 AND 41 THEN 'Millennials (26-41)'
        WHEN Age BETWEEN 42 AND 57 THEN 'Gen X (42-57)'
        WHEN Age BETWEEN 58 AND 76 THEN 'Baby Boomers (58-76)'
        ELSE 'Silent Generation (77+)'
    END AS age_segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN satisfaction = 'satisfied' THEN 1 ELSE 0 END) AS satisfied_count,
    SUM(CASE WHEN satisfaction = 'neutral or dissatisfied' THEN 1 ELSE 0 END) AS dissatisfied_count,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY 
    CASE 
        WHEN Age BETWEEN 7 AND 25 THEN 'Gen Z (7-25)'
        WHEN Age BETWEEN 26 AND 41 THEN 'Millennials (26-41)'
        WHEN Age BETWEEN 42 AND 57 THEN 'Gen X (42-57)'
        WHEN Age BETWEEN 58 AND 76 THEN 'Baby Boomers (58-76)'
        ELSE 'Silent Generation (77+)'
    END
ORDER BY satisfaction_rate_pct DESC;

-- ============================================================================
-- BƯỚC 2: ĐIỂM TRUNG BÌNH RATING TỪNG YẾU TỐ - CHỈ GEN Z
-- Mục đích: Xem Gen Z đánh giá các yếu tố dịch vụ thế nào
-- ============================================================================

SELECT 
    'Gen Z (7-25)' AS age_segment,
    COUNT(*) AS total_customers,
    ROUND(AVG(CAST([Inflight wifi service] AS FLOAT)), 2) AS avg_wifi_service,
    ROUND(AVG(CAST([Departure/Arrival time convenient] AS FLOAT)), 2) AS avg_time_convenient,
    ROUND(AVG(CAST([Ease of Online booking] AS FLOAT)), 2) AS avg_online_booking,
    ROUND(AVG(CAST([Gate location] AS FLOAT)), 2) AS avg_gate_location,
    ROUND(AVG(CAST([Food and drink] AS FLOAT)), 2) AS avg_food_drink,
    ROUND(AVG(CAST([Online boarding] AS FLOAT)), 2) AS avg_online_boarding,
    ROUND(AVG(CAST([Seat comfort] AS FLOAT)), 2) AS avg_seat_comfort,
    ROUND(AVG(CAST([Inflight entertainment] AS FLOAT)), 2) AS avg_inflight_entertainment,
    ROUND(AVG(CAST([On-board service] AS FLOAT)), 2) AS avg_onboard_service,
    ROUND(AVG(CAST([Leg room service] AS FLOAT)), 2) AS avg_legroom,
    ROUND(AVG(CAST([Baggage handling] AS FLOAT)), 2) AS avg_baggage_handling,
    ROUND(AVG(CAST([Checkin service] AS FLOAT)), 2) AS avg_checkin_service,
    ROUND(AVG(CAST([Inflight service] AS FLOAT)), 2) AS avg_inflight_service,
    ROUND(AVG(CAST([Cleanliness] AS FLOAT)), 2) AS avg_cleanliness
FROM airline_passenger_satisfaction
WHERE Age BETWEEN 7 AND 25;

-- ============================================================================
-- BƯỚC 3: SO SÁNH RATING GIỮA GEN Z VÀ CÁC NHÓM KHÁC
-- Mục đích: Xem Gen Z khác biệt gì so với tổng thể
-- ============================================================================

SELECT 
    CASE 
        WHEN Age BETWEEN 7 AND 25 THEN 'Gen Z (7-25)'
        WHEN Age BETWEEN 26 AND 41 THEN 'Millennials (26-41)'
        WHEN Age BETWEEN 42 AND 57 THEN 'Gen X (42-57)'
        WHEN Age BETWEEN 58 AND 76 THEN 'Baby Boomers (58-76)'
        ELSE 'Silent Generation (77+)'
    END AS age_segment,
    COUNT(*) AS total_customers,
    ROUND(AVG(CAST([Inflight wifi service] AS FLOAT)), 2) AS avg_wifi,
    ROUND(AVG(CAST([Ease of Online booking] AS FLOAT)), 2) AS avg_online_booking,
    ROUND(AVG(CAST([Online boarding] AS FLOAT)), 2) AS avg_online_boarding,
    ROUND(AVG(CAST([Inflight entertainment] AS FLOAT)), 2) AS avg_entertainment,
    ROUND(AVG(CAST([Seat comfort] AS FLOAT)), 2) AS avg_seat_comfort,
    ROUND(AVG(CAST([Food and drink] AS FLOAT)), 2) AS avg_food_drink,
    ROUND(AVG(CAST([Leg room service] AS FLOAT)), 2) AS avg_legroom,
    ROUND(AVG(CAST([On-board service] AS FLOAT)), 2) AS avg_onboard_service,
    ROUND(AVG(CAST([Cleanliness] AS FLOAT)), 2) AS avg_cleanliness,
    ROUND(AVG(CAST([Baggage handling] AS FLOAT)), 2) AS avg_baggage,
    ROUND(AVG(CAST([Checkin service] AS FLOAT)), 2) AS avg_checkin,
    ROUND(AVG(CAST([Inflight service] AS FLOAT)), 2) AS avg_inflight_service
FROM airline_passenger_satisfaction
GROUP BY 
    CASE 
        WHEN Age BETWEEN 7 AND 25 THEN 'Gen Z (7-25)'
        WHEN Age BETWEEN 26 AND 41 THEN 'Millennials (26-41)'
        WHEN Age BETWEEN 42 AND 57 THEN 'Gen X (42-57)'
        WHEN Age BETWEEN 58 AND 76 THEN 'Baby Boomers (58-76)'
        ELSE 'Silent Generation (77+)'
    END
ORDER BY age_segment;

-- ============================================================================
-- BƯỚC 4: SO SÁNH CHI TIẾT GEN Z vs TOÀN BỘ KHÁCH HÀNG (Benchmark)
-- Mục đích: Xác định yếu tố nào Gen Z đánh giá thấp hơn/cao hơn trung bình
-- ============================================================================

SELECT 
    'Inflight wifi service' AS service_factor,
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS genz_avg,
    ROUND(AVG(CAST([Inflight wifi service] AS FLOAT)), 2) AS overall_avg,
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Inflight wifi service] AS FLOAT) END) 
        - AVG(CAST([Inflight wifi service] AS FLOAT)), 2) AS diff_vs_overall
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Ease of Online booking',
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Ease of Online booking] AS FLOAT) END), 2),
    ROUND(AVG(CAST([Ease of Online booking] AS FLOAT)), 2),
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Ease of Online booking] AS FLOAT) END) 
        - AVG(CAST([Ease of Online booking] AS FLOAT)), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Online boarding',
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Online boarding] AS FLOAT) END), 2),
    ROUND(AVG(CAST([Online boarding] AS FLOAT)), 2),
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Online boarding] AS FLOAT) END) 
        - AVG(CAST([Online boarding] AS FLOAT)), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Inflight entertainment',
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Inflight entertainment] AS FLOAT) END), 2),
    ROUND(AVG(CAST([Inflight entertainment] AS FLOAT)), 2),
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Inflight entertainment] AS FLOAT) END) 
        - AVG(CAST([Inflight entertainment] AS FLOAT)), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Seat comfort',
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Seat comfort] AS FLOAT) END), 2),
    ROUND(AVG(CAST([Seat comfort] AS FLOAT)), 2),
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Seat comfort] AS FLOAT) END) 
        - AVG(CAST([Seat comfort] AS FLOAT)), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Food and drink',
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Food and drink] AS FLOAT) END), 2),
    ROUND(AVG(CAST([Food and drink] AS FLOAT)), 2),
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Food and drink] AS FLOAT) END) 
        - AVG(CAST([Food and drink] AS FLOAT)), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'On-board service',
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([On-board service] AS FLOAT) END), 2),
    ROUND(AVG(CAST([On-board service] AS FLOAT)), 2),
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([On-board service] AS FLOAT) END) 
        - AVG(CAST([On-board service] AS FLOAT)), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Leg room service',
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Leg room service] AS FLOAT) END), 2),
    ROUND(AVG(CAST([Leg room service] AS FLOAT)), 2),
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Leg room service] AS FLOAT) END) 
        - AVG(CAST([Leg room service] AS FLOAT)), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Baggage handling',
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Baggage handling] AS FLOAT) END), 2),
    ROUND(AVG(CAST([Baggage handling] AS FLOAT)), 2),
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Baggage handling] AS FLOAT) END) 
        - AVG(CAST([Baggage handling] AS FLOAT)), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Checkin service',
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Checkin service] AS FLOAT) END), 2),
    ROUND(AVG(CAST([Checkin service] AS FLOAT)), 2),
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Checkin service] AS FLOAT) END) 
        - AVG(CAST([Checkin service] AS FLOAT)), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Inflight service',
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Inflight service] AS FLOAT) END), 2),
    ROUND(AVG(CAST([Inflight service] AS FLOAT)), 2),
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Inflight service] AS FLOAT) END) 
        - AVG(CAST([Inflight service] AS FLOAT)), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Cleanliness',
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Cleanliness] AS FLOAT) END), 2),
    ROUND(AVG(CAST([Cleanliness] AS FLOAT)), 2),
    ROUND(AVG(CASE WHEN Age BETWEEN 7 AND 25 THEN CAST([Cleanliness] AS FLOAT) END) 
        - AVG(CAST([Cleanliness] AS FLOAT)), 2)
FROM airline_passenger_satisfaction

ORDER BY diff_vs_overall ASC;

-- ============================================================================
-- BƯỚC 5: GEN Z - PHÂN TÍCH THEO CLASS VÀ TYPE OF TRAVEL
-- Mục đích: Hiểu hành vi bay của Gen Z
-- ============================================================================

SELECT 
    Class,
    [Type of Travel],
    COUNT(*) AS total_genz,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
WHERE Age BETWEEN 7 AND 25
GROUP BY Class, [Type of Travel]
ORDER BY satisfaction_rate_pct DESC;

-- ============================================================================
-- BƯỚC 6: GEN Z - PHÂN TÍCH THEO CUSTOMER TYPE (Loyal vs Disloyal)
-- Mục đích: Xem Gen Z có quay lại hay không
-- ============================================================================

SELECT 
    [Customer Type],
    COUNT(*) AS total_genz,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct,
    ROUND(AVG(CAST([Inflight wifi service] AS FLOAT)), 2) AS avg_wifi,
    ROUND(AVG(CAST([Ease of Online booking] AS FLOAT)), 2) AS avg_online_booking,
    ROUND(AVG(CAST([Online boarding] AS FLOAT)), 2) AS avg_online_boarding,
    ROUND(AVG(CAST([Inflight entertainment] AS FLOAT)), 2) AS avg_entertainment
FROM airline_passenger_satisfaction
WHERE Age BETWEEN 7 AND 25
GROUP BY [Customer Type];

-- ============================================================================
-- BƯỚC 7: PHÂN BỐ FLIGHT DISTANCE CỦA GEN Z
-- Mục đích: Gen Z thường bay ngắn hay dài?
-- ============================================================================

SELECT 
    CASE 
        WHEN [Flight Distance] < 500 THEN 'Short (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN 'Medium (500-1500 miles)'
        ELSE 'Long (>1500 miles)'
    END AS distance_segment,
    COUNT(*) AS total_genz,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
WHERE Age BETWEEN 7 AND 25
GROUP BY 
    CASE 
        WHEN [Flight Distance] < 500 THEN 'Short (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN 'Medium (500-1500 miles)'
        ELSE 'Long (>1500 miles)'
    END
ORDER BY satisfaction_rate_pct DESC;
