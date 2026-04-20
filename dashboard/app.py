import os
import streamlit as st
import pandas as pd
import altair as alt

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

st.set_page_config(page_title="Retail Analysis", layout="wide")

st.title("📊 E-commerce Retail Analysis")

st.markdown("Dashboard overview of monthly revenue, top countries, top products sold and return rate")

# Load data
monthly_revenue = pd.read_csv(os.path.join(BASE_DIR, "DATA", "ANALYSIS", "monthly_revenue.csv"))
country = pd.read_csv(os.path.join(BASE_DIR, "DATA", "ANALYSIS", "country_analysis.csv"))
customer = pd.read_csv(os.path.join(BASE_DIR, "DATA", "ANALYSIS", "customer_analysis.csv"))
product = pd.read_csv(os.path.join(BASE_DIR, "DATA", "ANALYSIS", "product_analysis.csv"))
return_product = pd.read_csv(os.path.join(BASE_DIR, "DATA", "ANALYSIS", "return_analysis.csv"))
orders = pd.read_csv(os.path.join(BASE_DIR, "DATA", "ANALYSIS", "orders_analysis.csv"))

# KPI calculations
total_revenue = (monthly_revenue["revenue"]).sum()
total_orders = orders["total_orders"].iloc[0]
total_customers = customer["customer_id"].nunique()
avg_return_rate = return_product["return_rate_percentage"].mean()

# ===== KPI ROW =====
kpi1, kpi2, kpi3, kpi4 = st.columns(4)

with kpi1:
    st.metric("💰 Total Revenue", f"{total_revenue/1_000_000:.2f}M $")

with kpi2:
    st.metric("📦 Total Orders", f"{total_orders:,}")

with kpi3:
    st.metric("👤 Total Customers", f"{total_customers:,}")

with kpi4:
    st.metric("🔴 Avg Return Rate", f"{avg_return_rate:.2f}%")

st.markdown("---")

# ===== ROW 1 =====
col1, spacer, col2 = st.columns([1, 0.2, 1])

with col1:
    st.subheader("📈 Monthly Revenue")
    monthly_revenue["month"] = pd.to_datetime(monthly_revenue["month"])
    st.line_chart(monthly_revenue.set_index("month")["revenue"])
    st.caption("Note: December data is incomplete and not directly comparable.")

with col2:
    st.subheader("🌍 Top 10 Countries by Revenue")
    top_countries = country.head(10)

    chart_country = alt.Chart(top_countries).mark_bar().encode(
        x='revenue:Q',
        y=alt.Y('country:N', sort='-x')
    )

    st.altair_chart(chart_country, use_container_width=True)

st.markdown("---")

# ===== ROW 2 =====
col3, spacer, col4 = st.columns([1, 0.2, 1])

with col3:
    st.subheader("📦 Top 10 Products by Revenue")
    top_products = product.head(10)

    chart_products = alt.Chart(top_products).mark_bar().encode(
        x=alt.X('revenue:Q', axis=alt.Axis(format="~s")),
        y=alt.Y('description:N', sort='-x')
    )

    st.altair_chart(chart_products, use_container_width=True)

with col4:
    st.subheader("🔴 Return Rate vs Quantity Sold")

    chart_returns = alt.Chart(return_product).mark_circle(
        size=100, opacity=0.2
    ).encode(
        x='quantity_sold:Q',
        y='return_rate_percentage:Q',
        tooltip=[
            alt.Tooltip('stock_code:N', title='Stock Code'),
            alt.Tooltip('description:N', title='Product'),
            alt.Tooltip('quantity_sold:Q', title='Quantity Sold'),
            alt.Tooltip('quantity_returned:Q', title='Quantity Returned'),
            alt.Tooltip('return_rate_percentage:Q', title='Return Rate (%)', format=".2f")
        ]
    ).interactive()

    st.altair_chart(chart_returns, use_container_width=True)
