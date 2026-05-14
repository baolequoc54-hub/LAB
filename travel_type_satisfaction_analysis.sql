-- ============================================================================
-- AIRLINE SATISFACTION ANALYSIS - THEO TYPE OF TRAVEL
-- So sánh mức độ hài lòng giữa khách bay vì lý do Business vs Personal
-- ============================================================================

-- ============================================================================
-- BƯỚC 1: TỶ LỆ HÀI LÒNG THEO TYPE OF TRAVEL (Conditional Aggregation)
-- Mục đích: Xác định nhóm nào có tỷ lệ hài lòng cao hơn
-- ============================================================================

SELECT 
    [Type of Travel],
    COUNT(*) AS total_customers,
    SUM(CASE WHEN satisfaction = 'satisfied' THEN 1 ELSE 0 END) AS satisfied_count,
    SUM(CASE WHEN satisfaction = 'neutral or dissatisfied' THEN 1 ELSE 0 END) AS dissatisfied_count,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct,
    ROUND(
        SUM(CASE WHEN satisfaction = 'neutral or dissatisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS dissatisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY [Type of Travel];

-- ============================================================================
-- BƯỚC 2: ĐIỂM TRUNG BÌNH RATING TỪNG YẾU TỐ DỊCH VỤ THEO TYPE OF TRAVEL
-- Mục đích: Xem từng nhóm đánh giá dịch vụ nào cao/thấp
-- ============================================================================

SELECT 
    [Type of Travel],
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
GROUP BY [Type of Travel];

-- ============================================================================
-- BƯỚC 3: SO SÁNH CHI TIẾT - CHÊNH LỆCH RATING GIỮA BUSINESS VÀ PERSONAL
-- Mục đích: Xem yếu tố nào có khoảng cách lớn nhất giữa 2 nhóm
-- ============================================================================

SELECT 
    'Inflight wifi service' AS service_factor,
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS business_avg,
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS personal_avg,
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Inflight wifi service] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS diff_business_minus_personal
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Departure/Arrival time convenient',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Departure/Arrival time convenient] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Departure/Arrival time convenient] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Departure/Arrival time convenient] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Departure/Arrival time convenient] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Ease of Online booking',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Ease of Online booking] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Ease of Online booking] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Ease of Online booking] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Ease of Online booking] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Gate location',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Gate location] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Gate location] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Gate location] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Gate location] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Food and drink',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Food and drink] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Food and drink] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Food and drink] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Food and drink] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Online boarding',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Online boarding] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Online boarding] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Online boarding] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Online boarding] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Seat comfort',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Seat comfort] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Seat comfort] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Seat comfort] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Seat comfort] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Inflight entertainment',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Inflight entertainment] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Inflight entertainment] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Inflight entertainment] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Inflight entertainment] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'On-board service',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([On-board service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([On-board service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([On-board service] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([On-board service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Leg room service',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Leg room service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Leg room service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Leg room service] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Leg room service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Baggage handling',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Baggage handling] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Baggage handling] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Baggage handling] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Baggage handling] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Checkin service',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Checkin service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Checkin service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Checkin service] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Checkin service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Inflight service',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Inflight service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Inflight service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Inflight service] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Inflight service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Cleanliness',
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Cleanliness] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Cleanliness] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Type of Travel] = 'Business travel' THEN CAST([Cleanliness] AS FLOAT) END) 
        - AVG(CASE WHEN [Type of Travel] = 'Personal Travel' THEN CAST([Cleanliness] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

ORDER BY diff_business_minus_personal DESC;

-- ============================================================================
-- BƯỚC 4: PHÂN TÍCH THÊM - TYPE OF TRAVEL + CLASS
-- Mục đích: Xem trong từng class, nhóm nào hài lòng hơn
-- ============================================================================

SELECT 
    [Type of Travel],
    Class,
    COUNT(*) AS total_customers,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY [Type of Travel], Class
ORDER BY [Type of Travel], satisfaction_rate_pct DESC;

-- ============================================================================
-- BƯỚC 5: PHÂN TÍCH THÊM - TYPE OF TRAVEL + CUSTOMER TYPE
-- Mục đích: Xem loyal/disloyal ảnh hưởng thế nào đến từng nhóm travel
-- ============================================================================

SELECT 
    [Type of Travel],
    [Customer Type],
    COUNT(*) AS total_customers,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct,
    ROUND(AVG(CAST([Inflight wifi service] AS FLOAT)), 2) AS avg_wifi,
    ROUND(AVG(CAST([Ease of Online booking] AS FLOAT)), 2) AS avg_online_booking,
    ROUND(AVG(CAST([Seat comfort] AS FLOAT)), 2) AS avg_seat_comfort,
    ROUND(AVG(CAST([Inflight entertainment] AS FLOAT)), 2) AS avg_entertainment
FROM airline_passenger_satisfaction
GROUP BY [Type of Travel], [Customer Type]
ORDER BY [Type of Travel], satisfaction_rate_pct DESC;

-- ============================================================================
-- BƯỚC 6: PHÂN TÍCH DELAY IMPACT THEO TYPE OF TRAVEL
-- Mục đích: Xem delay ảnh hưởng khác nhau thế nào đến 2 nhóm
-- ============================================================================

SELECT 
    [Type of Travel],
    CASE 
        WHEN [Departure Delay in Minutes] = 0 THEN 'No Delay'
        WHEN [Departure Delay in Minutes] BETWEEN 1 AND 15 THEN 'Short Delay (1-15 min)'
        WHEN [Departure Delay in Minutes] BETWEEN 16 AND 60 THEN 'Medium Delay (16-60 min)'
        ELSE 'Long Delay (>60 min)'
    END AS delay_segment,
    COUNT(*) AS total_customers,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY 
    [Type of Travel],
    CASE 
        WHEN [Departure Delay in Minutes] = 0 THEN 'No Delay'
        WHEN [Departure Delay in Minutes] BETWEEN 1 AND 15 THEN 'Short Delay (1-15 min)'
        WHEN [Departure Delay in Minutes] BETWEEN 16 AND 60 THEN 'Medium Delay (16-60 min)'
        ELSE 'Long Delay (>60 min)'
    END
ORDER BY [Type of Travel], satisfaction_rate_pct DESC;
