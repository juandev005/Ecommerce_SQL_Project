CREATE TABLE ecommerce.customers(
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50) UNIQUE NOT NULL,
    customer_zip_code_prefix VARCHAR(10) NOT NULL,
    customer_city VARCHAR(50) NOT NULL,
    customer_state VARCHAR(6) NOT NULL
);

CREATE TABLE ecommerce.sellers(
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10) NOT NULL,
    seller_city VARCHAR(50) NOT NULL,
    seller_state VARCHAR(6) NOT NULL
);

CREATE TABLE ecommerce.orders(
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) REFERENCES ecommerce.customers(customer_id),
    order_status order_statuses NOT NULL,
    order_purchase_timestamp TIMESTAMP NOT NULL,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP NOT NULL
    -- CONTRAINT chk_order_status CHECK(
    --     order_status IN('
    --         delivered','shipped','canceled',
    --         'processing','invoiced','unavailable',
    --         'approved','created'
    --     )
    -- )
);

CREATE TABLE ecommerce.products(
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(50) NOT NULL,
    product_name_lenght SMALLINT,
    product_description_lenght SMALLINT,
    product_photos_qty SMALLINT,
    product_weight_g INTEGER ,
    product_length_cm INTEGER ,
    product_height_cm INTEGER ,
    product_width_cm INTEGER 
);

CREATE TABLE ecommerce.product_category_name_translation(
    product_category_name VARCHAR(50) PRIMARY KEY,
    product_category_name_english VARCHAR(50) NOT NULL
);

CREATE TABLE ecommerce.order_items(
    order_id        VARCHAR(50)    REFERENCES ecommerce.orders(order_id),
    order_item_id   SMALLINT       NOT NULL,
    product_id      VARCHAR(50)    REFERENCES ecommerce.products(product_id),
    seller_id       VARCHAR(50)    REFERENCES ecommerce.sellers(seller_id),
    shipping_limit_date TIMESTAMP  NOT NULL,
    price           NUMERIC(12,2)  NOT NULL,
    freight_value   NUMERIC(12,2)  NOT NULL,
    PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE ecommerce.order_payments(
    order_id             VARCHAR(50)   REFERENCES ecommerce.orders(order_id),
    payment_sequential   SMALLINT      NOT NULL,
    payment_type         VARCHAR(50)   NOT NULL,
    payment_installments SMALLINT      NOT NULL,
    payment_value        NUMERIC(12,2) NOT NULL,
    PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE ecommerce.order_reviews(
    id                      SERIAL         PRIMARY KEY,
    review_id               VARCHAR(50)    NOT NULL,
    order_id                VARCHAR(50)    REFERENCES ecommerce.orders(order_id),
    review_score            SMALLINT       NOT NULL,
    review_comment_title    VARCHAR(100),
    review_comment_message  TEXT,
    review_creation_date    TIMESTAMP      NOT NULL,
    review_answer_timestamp TIMESTAMP
);

CREATE TABLE ecommerce.geolocation(
    id                          SERIAL        PRIMARY KEY,
    geolocation_zip_code_prefix VARCHAR(10)   NOT NULL,
    geolocation_lat             FLOAT         NOT NULL,
    geolocation_lng             FLOAT         NOT NULL,
    geolocation_city            VARCHAR(50)   NOT NULL,
    geolocation_state           VARCHAR(6)    NOT NULL
);