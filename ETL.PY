import pandas as pd
import datetime
from sqlalchemy import create_engine
from sqlalchemy.exc import SQLAlchemyError
from parameters import Source_path, MYSQL_USER, MYSQL_PASSWORD, MYSQL_HOST, MYSQL_DB


def load_data(source_path):
    """Load the data from the specified CSV file."""
    try:
        df = pd.read_csv(source_path)
        return df
    except FileNotFoundError as e:
        print(f"Error: The file at {source_path} was not found. {e}")
        return None
    except pd.errors.EmptyDataError as e:
        print(f"Error: The file at {source_path} is empty. {e}")
        return None
    except Exception as e:
        print(f"Error while loading data: {e}")
        return None

def monitor_data_quality(df):
    """Monitor data quality by checking for missing values and invalid data."""
    quality_issues = {}
    
    # Checking for missing or extra columns in the source
    Columns = ['InvoiceNo', 'StockCode', 'Description', 'Quantity', 'InvoiceDate','UnitPrice', 'CustomerID', 'Country']
    if not df.columns.tolist() == Columns:
        quality_issues['Columns_Status'] = 'There are missing or extra columns in the data source'
        
    # Checking for missing values in some columns
    missing_customer_ids = df['CustomerID'].isnull().sum()
    if missing_customer_ids > 0:
        quality_issues['Missing_CustomerID'] = missing_customer_ids
    
    # Check for negative or zero quantities and unit prices
    invalid_quantities = df[df['Quantity'] <= 0].shape[0]
    invalid_prices = df[df['UnitPrice'] <= 0].shape[0]
    
    # validation for the price and quantity
    if invalid_quantities > 0:
        quality_issues['Invalid_Quantities'] = invalid_quantities
    if invalid_prices > 0:
        quality_issues['Invalid_Prices'] = invalid_prices
    
    if quality_issues:
        print("Data Quality Issues Detected:", quality_issues)
    else:
        print("No Data Quality Issues Detected")
    
    return quality_issues

def clean_data(df):
    """Clean the data by removing missing values and duplicates."""
    try:
        data = df.copy()
        data = data.dropna(subset=['CustomerID'])  # Remove rows where 'CustomerID' is null
        data.drop_duplicates(inplace=True)  # Drop duplicates
        data['InvoiceDate'] = pd.to_datetime(data['InvoiceDate'])  # Ensure 'InvoiceDate' is datetime
        return data
    except KeyError as e:
        print(f"Error: Missing column in the data. {e}")
        return None
    except Exception as e:
        print(f"Error during data cleaning: {e}")
        return None


def transform_data(data):
    """Transform the data by adding new columns and splitting into different tables."""
    try:
        data['InsertDate'] = datetime.datetime.now()
        data['TotalAmount'] = data['Quantity'] * data['UnitPrice']

        # Create separate tables
        Customers = data[['CustomerID', 'Country']].drop_duplicates(subset=['CustomerID'])
        Products = data[['StockCode', 'Description']].drop_duplicates(subset=['StockCode'])
        Sales_Transactions = data[['InvoiceNo', 'StockCode', 'CustomerID', 'Quantity', 'InvoiceDate', 'UnitPrice', 'TotalAmount', 'InsertDate']]

        return Customers, Products, Sales_Transactions
    except KeyError as e:
        print(f"Error: Missing column during transformation. {e}")
        return None, None, None
    except Exception as e:
        print(f"Error during data transformation: {e}")
        return None, None, None


def insert_data(table_name, table):
    """Insert the data into the MySQL database."""
    db_engine = create_engine(f'mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}/{MYSQL_DB}')
    try:
        table.to_sql(table_name, con=db_engine, index=False, if_exists='append')
        print(f"Data inserted successfully into the '{table_name}' table.")
    except SQLAlchemyError as e:
        print(f"Error inserting data into the '{table_name}' table: {e}")
    except Exception as e:
        print(f"Unexpected error during insertion into '{table_name}': {e}")


def main():
    """Main function to orchestrate the ETL process."""
    df = load_data(Source_path)
    if df is not None:
        monitor_data_quality(df)
        cleaned_data = clean_data(df)
        if cleaned_data is not None:
            Customers, Products, Sales_Transactions = transform_data(cleaned_data)
            if Customers is not None and Products is not None and Sales_Transactions is not None:
                insert_data('Customers', Customers)
                insert_data('Products', Products)
                insert_data('Sales_Transactions', Sales_Transactions)


if __name__ == "__main__":
    main()
