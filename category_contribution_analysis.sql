-- ============================================================================
-- BUSINESS QUESTION: CATEGORY/SUBCATEGORY CONTRIBUTION
-- Category/Subcategory nào chiếm tỉ trọng chính trong doanh thu / số lượng 
-- đơn hàng / lợi nhuận của công ty theo từng năm?
-- ============================================================================
-- Database: Retail Sales
-- Bảng: Sales, Products, Stores, Customers
-- Revenue = Quantity * [Unit Price USD]
-- Profit  = Quantity * ([Unit Price USD] - [Unit Cost USD])
-- ============================================================================

-- ============================================================================
-- BƯỚC 1: TỔNG DOANH THU, ĐƠN HÀNG, LỢI NHUẬN THEO CATEGORY + NĂM
-- Mục đích: Xem từng category đóng góp bao nhiêu theo từng năm
-- ============================================================================

SELECT 
    YEAR(s.[Order Date]) AS order_year,
    p.Category,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    SUM(s.Quantity) AS total_quantity,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
    ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS total_profit
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    YEAR(s.[Order Date]),
    p.Category
ORDER BY order_year, total_revenue DESC;

-- ============================================================================
-- BƯỚC 2: TỈ TRỌNG (%) CỦA TỪNG CATEGORY TRONG TỔNG DOANH THU THEO NĂM
-- Mục đích: Tính % đóng góp của mỗi category
-- Kỹ thuật: Dùng Window Function hoặc Subquery
-- ============================================================================

-- Cách 1: Dùng Window Function (SUM OVER)
SELECT 
    YEAR(s.[Order Date]) AS order_year,
    p.Category,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
    ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS total_profit,
    -- Tỉ trọng doanh thu
    ROUND(
        SUM(s.Quantity * p.[Unit Price USD]) * 100.0 
        / SUM(SUM(s.Quantity * p.[Unit Price USD])) OVER (PARTITION BY YEAR(s.[Order Date])),
    2) AS revenue_pct,
    -- Tỉ trọng lợi nhuận
    ROUND(
        SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])) * 100.0 
        / SUM(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD]))) OVER (PARTITION BY YEAR(s.[Order Date])),
    2) AS profit_pct
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    YEAR(s.[Order Date]),
    p.Category
ORDER BY order_year, revenue_pct DESC;

-- Cách 2: Dùng Subquery (nếu chưa học Window Function)
SELECT 
    cat.order_year,
    cat.Category,
    cat.total_orders,
    cat.total_revenue,
    cat.total_profit,
    ROUND(cat.total_revenue * 100.0 / yearly.yearly_revenue, 2) AS revenue_pct,
    ROUND(cat.total_profit * 100.0 / yearly.yearly_profit, 2) AS profit_pct,
    ROUND(cat.total_orders * 100.0 / yearly.yearly_orders, 2) AS orders_pct
FROM 
    (
        SELECT 
            YEAR(s.[Order Date]) AS order_year,
            p.Category,
            COUNT(DISTINCT s.[Order Number]) AS total_orders,
            ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
            ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS total_profit
        FROM Sales s
        JOIN Products p ON s.ProductKey = p.ProductKey
        GROUP BY YEAR(s.[Order Date]), p.Category
    ) cat
JOIN 
    (
        SELECT 
            YEAR(s.[Order Date]) AS order_year,
            COUNT(DISTINCT s.[Order Number]) AS yearly_orders,
            ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS yearly_revenue,
            ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS yearly_profit
        FROM Sales s
        JOIN Products p ON s.ProductKey = p.ProductKey
        GROUP BY YEAR(s.[Order Date])
    ) yearly ON cat.order_year = yearly.order_year
ORDER BY cat.order_year, revenue_pct DESC;

-- ============================================================================
-- BƯỚC 3: TỔNG DOANH THU, ĐƠN HÀNG, LỢI NHUẬN THEO SUBCATEGORY + NĂM
-- Mục đích: Chi tiết hơn - subcategory nào đóng góp chính
-- ============================================================================

SELECT 
    YEAR(s.[Order Date]) AS order_year,
    p.Category,
    p.Subcategory,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    SUM(s.Quantity) AS total_quantity,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
    ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS total_profit
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    YEAR(s.[Order Date]),
    p.Category,
    p.Subcategory
ORDER BY order_year, total_revenue DESC;

-- ============================================================================
-- BƯỚC 4: TỈ TRỌNG (%) SUBCATEGORY TRONG TỔNG DOANH THU THEO NĂM
-- Mục đích: Subcategory nào chiếm % lớn nhất?
-- ============================================================================

SELECT 
    sub.order_year,
    sub.Category,
    sub.Subcategory,
    sub.total_orders,
    sub.total_revenue,
    sub.total_profit,
    ROUND(sub.total_revenue * 100.0 / yearly.yearly_revenue, 2) AS revenue_pct,
    ROUND(sub.total_profit * 100.0 / yearly.yearly_profit, 2) AS profit_pct,
    ROUND(sub.total_orders * 100.0 / yearly.yearly_orders, 2) AS orders_pct
FROM 
    (
        SELECT 
            YEAR(s.[Order Date]) AS order_year,
            p.Category,
            p.Subcategory,
            COUNT(DISTINCT s.[Order Number]) AS total_orders,
            ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
            ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS total_profit
        FROM Sales s
        JOIN Products p ON s.ProductKey = p.ProductKey
        GROUP BY YEAR(s.[Order Date]), p.Category, p.Subcategory
    ) sub
JOIN 
    (
        SELECT 
            YEAR(s.[Order Date]) AS order_year,
            COUNT(DISTINCT s.[Order Number]) AS yearly_orders,
            ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS yearly_revenue,
            ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS yearly_profit
        FROM Sales s
        JOIN Products p ON s.ProductKey = p.ProductKey
        GROUP BY YEAR(s.[Order Date])
    ) yearly ON sub.order_year = yearly.order_year
ORDER BY sub.order_year, revenue_pct DESC;

-- ============================================================================
-- BƯỚC 5: TOP 5 SUBCATEGORIES THEO DOANH THU MỖI NĂM
-- Mục đích: Nhanh chóng xác định top contributors
-- ============================================================================

SELECT *
FROM (
    SELECT 
        YEAR(s.[Order Date]) AS order_year,
        p.Category,
        p.Subcategory,
        ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
        ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS total_profit,
        ROW_NUMBER() OVER (
            PARTITION BY YEAR(s.[Order Date]) 
            ORDER BY SUM(s.Quantity * p.[Unit Price USD]) DESC
        ) AS revenue_rank
    FROM Sales s
    JOIN Products p ON s.ProductKey = p.ProductKey
    GROUP BY YEAR(s.[Order Date]), p.Category, p.Subcategory
) ranked
WHERE revenue_rank <= 5
ORDER BY order_year, revenue_rank;

-- ============================================================================
-- BƯỚC 6: SO SÁNH TỈ TRỌNG CATEGORY QUA CÁC NĂM (XEM THAY ĐỔI)
-- Mục đích: Category nào đang tăng/giảm tỉ trọng qua thời gian?
-- ============================================================================

SELECT 
    YEAR(s.[Order Date]) AS order_year,
    p.Category,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
    ROUND(
        SUM(s.Quantity * p.[Unit Price USD]) * 100.0 
        / SUM(SUM(s.Quantity * p.[Unit Price USD])) OVER (PARTITION BY YEAR(s.[Order Date])),
    2) AS revenue_share_pct
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY YEAR(s.[Order Date]), p.Category
ORDER BY p.Category, order_year;

-- ============================================================================
-- BƯỚC 7: PROFIT MARGIN THEO CATEGORY VÀ NĂM
-- Mục đích: Category nào profitable nhất?
-- ============================================================================

SELECT 
    YEAR(s.[Order Date]) AS order_year,
    p.Category,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
    ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS total_profit,
    ROUND(
        SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])) * 100.0 
        / SUM(s.Quantity * p.[Unit Price USD]),
    2) AS profit_margin_pct
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY YEAR(s.[Order Date]), p.Category
ORDER BY order_year, profit_margin_pct DESC;

-- ============================================================================
-- BƯỚC 8: PROFIT MARGIN THEO SUBCATEGORY VÀ NĂM
-- Mục đích: Subcategory nào lời nhiều nhất / ít nhất?
-- ============================================================================

SELECT 
    YEAR(s.[Order Date]) AS order_year,
    p.Category,
    p.Subcategory,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
    ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS total_profit,
    ROUND(
        SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])) * 100.0 
        / SUM(s.Quantity * p.[Unit Price USD]),
    2) AS profit_margin_pct
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY YEAR(s.[Order Date]), p.Category, p.Subcategory
ORDER BY order_year, profit_margin_pct DESC;
