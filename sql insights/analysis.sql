-- Combining all 4 datasets to create a master data

CREATE TABLE coin_all_cleaned AS
SELECT 
    CAST("Date" AS DATE) AS date,
    "Name" AS coin_name,
    "Symbol" AS symbol,
    "Open" AS open_price,
    "Close" AS close_price,
    "High" AS high_price,
    "Low" AS low_price,
    "Volume" AS volume,
    "Marketcap" AS market_cap
FROM coin_binancecoin_cleaned

UNION ALL

SELECT 
    CAST("Date" AS DATE) AS date,
    "Name" AS coin_name,
    "Symbol" AS symbol,
    "Open" AS open_price,
    "Close" AS close_price,
    "High" AS high_price,
    "Low" AS low_price,
    "Volume" AS volume,
    "Marketcap" AS market_cap
FROM coin_bitcoin_cleaned

UNION ALL

SELECT 
    CAST("Date" AS DATE) AS date,
    "Name" AS coin_name,
    "Symbol" AS symbol,
    "Open" AS open_price,
    "Close" AS close_price,
    "High" AS high_price,
    "Low" AS low_price,
    "Volume" AS volume,
    "Marketcap" AS market_cap
FROM coin_dogecoin_cleaned

UNION ALL

SELECT 
    CAST("Date" AS DATE) AS date,
    "Name" AS coin_name,
    "Symbol" AS symbol,
    "Open" AS open_price,
    "Close" AS close_price,
    "High" AS high_price,
    "Low" AS low_price,
    "Volume" AS volume,
    "Marketcap" AS market_cap
FROM coin_ethereum_cleaned;


-- Selecting the combined dataset
SELECT * 
FROM coin_all_cleaned



-- Daily Return

WITH ranked_prices AS (
    SELECT 
        date,
        coin_name,
        close_price::numeric(20,8) AS close_price,
        LAG(close_price::numeric(20,8)) OVER (PARTITION BY coin_name ORDER BY date) AS prev_close
    FROM coin_all_cleaned AS cac
)
SELECT
    date,
    coin_name,
    close_price,
    ROUND(((close_price - prev_close) / NULLIF(prev_close, 0)) * 100, 4) AS daily_return_percent,
    ROUND( (LN(close_price) - LN(NULLIF(prev_close, 0)))::numeric, 6 ) AS log_return
FROM ranked_prices
WHERE prev_close IS NOT NULL;

SELECT *
FROM coin_all_cleaned

-- Monthly Aggregates

SELECT 
    TO_CHAR(DATE_TRUNC('month', date), 'YYYY-MM') AS month_and_year,
    coin_name,
    ROUND(AVG(close_price)::numeric, 2) AS avg_close,
    MAX(high_price) AS max_high,
    MIN(low_price) AS min_low,
    SUM(volume) AS total_volume
FROM coin_all_cleaned AS cac
GROUP BY DATE_TRUNC('month', date), coin_name
ORDER BY DATE_TRUNC('month', date), coin_name;


-- Volatility per Month

WITH returns AS (
    SELECT 
        date,
        coin_name,
        ROUND( ((close_price - LAG(close_price) OVER (PARTITION BY coin_name ORDER BY date)) / 
        NULLIF(LAG(close_price) OVER (PARTITION BY coin_name ORDER BY date), 0)
            )::numeric * 100, 4
        ) AS daily_return
    FROM coin_all_cleaned
)
SELECT 
    TO_CHAR(DATE_TRUNC('month', date), 'YYYY-MM') AS month,
    coin_name,
    ROUND(STDDEV(daily_return)::numeric, 4) AS monthly_volatility
FROM returns
WHERE daily_return IS NOT NULL
GROUP BY DATE_TRUNC('month', date), coin_name
ORDER BY DATE_TRUNC('month', date), coin_name;


-- Price Movements

WITH returns AS (
    SELECT 
        date,
        coin_name,
        ROUND(((close_price - LAG(close_price) OVER (PARTITION BY coin_name ORDER BY date)) / 
        NULLIF(LAG(close_price) OVER (PARTITION BY coin_name ORDER BY date), 0))::numeric * 100, 4) AS daily_return
    FROM coin_all_cleaned AS cac
)
SELECT *
FROM returns
WHERE daily_return IS NOT NULL
  AND ABS(daily_return) >= 10;



-- Market Share of Market Cap

WITH total_cap AS (
    SELECT 
        "date", 
        SUM(market_cap) AS total_market_cap
    FROM coin_all_cleaned
    GROUP BY "date"
)
SELECT 
    m."date",
    m.coin_name,
    m.market_cap,
    ROUND(
        ((m.market_cap / NULLIF(t.total_market_cap, 0)) * 100)::numeric,
        2
    ) AS market_share_percent
FROM coin_all_cleaned m
JOIN total_cap t 
    ON m."date" = t."date"
ORDER BY m."date", m.coin_name;



















