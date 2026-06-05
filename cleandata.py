# 1. IMPORT LIBRARIES
import pandas as pd
import numpy as np

# 2. LOAD DATASET
df = pd.read_csv(r"C:\New folder\SQL\Dataset.csv")

# 3. CLEAN COLUMN NAMES
df.columns = (
    df.columns
    .str.strip()
    .str.lower()
    .str.replace(" ", "_")
)

# 4. CLEAN YES/NO COLUMNS
df['discount_applied'] = df['discount_applied'].map({
    'Yes': 1,
    'No': 0
})

df['promo_code_used'] = df['promo_code_used'].map({
    'Yes': 1,
    'No': 0
})

df['subscription_status'] = df['subscription_status'].map({
    'Yes': 1,
    'No': 0
})

# 5. REMOVE DUPLICATES
df = df.drop_duplicates()

# =========================
# CUSTOMER 360 TABLE
# =========================

customer_df = df.groupby('customer_id').agg({

    'purchase_amount_(usd)': ['sum', 'mean', 'count'],

    'discount_applied': 'mean',

    'review_rating': 'mean',

    'previous_purchases': 'max',

    'subscription_status': 'max',

    'shipping_type': 'first',

    'season': 'first'

}).reset_index()

customer_df.columns = [

    'customer_id',

    'total_spend',
    'avg_order_value',
    'total_orders',

    'promo_ratio',

    'avg_review_rating',

    'previous_purchases',

    'subscription_status',

    'shipping_type',

    'season'
]

# 7. CUSTOMER SEGMENTS

customer_df['customer_segment'] = np.where(

    (customer_df['total_spend'] >
     customer_df['total_spend'].quantile(0.75))

    &

    (customer_df['promo_ratio'] < 0.5),

    'High Value Organic',

    np.where(
        customer_df['promo_ratio'] > 0.7,
        'Discount Driven',
        'Regular'
    )
)

# 8. LOYALTY SCORE

customer_df['loyalty_score'] = (

    customer_df['total_orders'] * 0.4 +

    customer_df['previous_purchases'] * 0.4 +

    customer_df['avg_review_rating'] * 0.2
)

# 9. SATISFACTION FLAG

customer_df['satisfaction_flag'] = np.where(

    customer_df['avg_review_rating'] >= 3.5,

    'Satisfied',

    'Unsatisfied'
)

# 10. SAVE FINAL CUSTOMER TABLE

customer_df.to_csv(
    r"C:\New folder\SQL\customer_360.csv",
    index=False
)

print(customer_df.head())

print("Customer 360 table created successfully!")