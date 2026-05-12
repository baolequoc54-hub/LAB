-- ============================================================================
-- AIRLINE SATISFACTION ANALYSIS
-- So sánh tỷ lệ hài lòng giữa khách hàng bay lần đầu (First-time) 
-- và khách hàng quay lại (Returning)
-- ============================================================================

-- ============================================================================
-- PHẦN 1: TỶ LỆ HÀI LÒNG THEO TỪNG NHÓM KHÁCH HÀNG (Conditional Aggregation)
-- ============================================================================

SELECT 
    [Customer Type],
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
GROUP BY [Customer Type];

-- ============================================================================
-- PHẦN 2: ĐIỂM TRUNG BÌNH RATING CỦA TỪNG YẾU TỐ THEO NHÓM KHÁCH HÀNG
-- ============================================================================

SELECT 
    [Customer Type],
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
GROUP BY [Customer Type];

-- ============================================================================
-- PHẦN 3: SO SÁNH CHI TIẾT - CHÊNH LỆCH RATING GIỮA 2 NHÓM
-- ============================================================================

SELECT 
    'Inflight wifi service' AS service_factor,
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS returning_avg,
    ROUND(AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS firsttime_avg,
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Inflight wifi service] AS FLOAT) END) 
        - AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS difference
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Ease of Online booking',
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Ease of Online booking] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Ease of Online booking] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Ease of Online booking] AS FLOAT) END) 
        - AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Ease of Online booking] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Online boarding',
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Online boarding] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Online boarding] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Online boarding] AS FLOAT) END) 
        - AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Online boarding] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Seat comfort',
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Seat comfort] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Seat comfort] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Seat comfort] AS FLOAT) END) 
        - AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Seat comfort] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Inflight entertainment',
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Inflight entertainment] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Inflight entertainment] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Inflight entertainment] AS FLOAT) END) 
        - AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Inflight entertainment] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Food and drink',
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Food and drink] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Food and drink] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Food and drink] AS FLOAT) END) 
        - AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Food and drink] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Inflight wifi service',
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Inflight wifi service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Inflight wifi service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Inflight wifi service] AS FLOAT) END) 
        - AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Inflight wifi service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Checkin service',
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Checkin service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Checkin service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Checkin service] AS FLOAT) END) 
        - AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Checkin service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Baggage handling',
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Baggage handling] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Baggage handling] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Baggage handling] AS FLOAT) END) 
        - AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Baggage handling] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Cleanliness',
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Cleanliness] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Cleanliness] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Customer Type] = 'Loyal Customer' THEN CAST([Cleanliness] AS FLOAT) END) 
        - AVG(CASE WHEN [Customer Type] = 'disloyal Customer' THEN CAST([Cleanliness] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

ORDER BY difference DESC;

-- ============================================================================
-- PHẦN 4: PHÂN TÍCH THÊM - TỶ LỆ HÀI LÒNG THEO CLASS VÀ CUSTOMER TYPE
-- ============================================================================

SELECT 
    [Customer Type],
    Class,
    COUNT(*) AS total_customers,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY [Customer Type], Class
ORDER BY [Customer Type], satisfaction_rate_pct DESC;
