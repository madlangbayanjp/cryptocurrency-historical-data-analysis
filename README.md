![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-000000?logo=python&logoColor=FFD43B)

# 📊 Cryptocurrency Historical Data Analysis

This project focuses on the comprehensive analysis of historical data for four major cryptocurrencies: **Bitcoin (BTC), Ethereum (ETH), Binance Coin (BNB), and Dogecoin (DOGE)**.  
The goal is to extract meaningful insights from their past performance, providing a foundation for understanding market trends and behaviors.

---

## Project Overview
The core of this project involved a multi-step process:

1. **Data Acquisition & Cleaning**  
   Historical data for each of the four cryptocurrencies was gathered. Python was extensively used to clean and preprocess these datasets, ensuring data quality and consistency.

2. **Data Export**  
   Once cleaned, the refined datasets were exported as `.csv` files.

3. **Insight Extraction (Excel)**  
   The cleaned `.csv` files were then imported into DBeaver for in-depth analysis and the extraction of various market insights.

---

## Dataset Columns
Each cryptocurrency dataset includes the following columns:

- **Date**: The specific date of the observation.  
- **Open**: The opening price of the cryptocurrency on the given day.  
- **High**: The highest price reached by the cryptocurrency on the given day.  
- **Low**: The lowest price reached by the cryptocurrency on the given day.  
- **Close**: The closing price of the cryptocurrency on the given day.  
- **Volume**: The total volume of transactions for the cryptocurrency on the given day.  
- **Market Cap**: The market capitalization of the cryptocurrency in USD on the given day.

## Dataset Link
<a href="https://www.kaggle.com/datasets/sudalairajkumar/cryptocurrencypricehistory">Cryptocurrency Historical Prices <a/>

---

## Key Insights Derived
Based on the cleaned historical data, the following insights were extracted:

- **Volatility Per Month** → Analysis of price fluctuations on a monthly basis to understand the stability or instability of each cryptocurrency.  
- **Daily Return** → Calculation of daily percentage changes in price to assess short-term profitability or loss.  
- **Market Share of Market Cap** → Comparative analysis showing the proportion of total market capitalization held by each cryptocurrency.  
- **Monthly Aggregate** → Summarized monthly performance data, including averages and total volumes.  
- **Price Movement** → General trends and patterns observed in price changes over the historical period.  

---

## Future Enhancements
Planned improvements for this project:

- Add visualizations (charts, graphs, interactive dashboards).  
- Improve accessibility of insights with better data presentation.  
- Enable quicker identification of trends and anomalies through automated reporting.  
