Source_path = r'C:\Users\elmal\Downloads\project\Task 1\online_retail.csv'

from dotenv import load_dotenv
import os
load_dotenv()

# Get the credentials from environment variables
MYSQL_USER = os.getenv('MYSQL_USER')
MYSQL_PASSWORD = os.getenv('MYSQL_PASSWORD')
MYSQL_HOST = os.getenv('MYSQL_HOST')
MYSQL_DB = os.getenv('MYSQL_DB')