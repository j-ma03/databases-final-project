# databases-final-project
Using publicly available data about Mexico and Dragon Ball to find out whether new releases of Dragon Ball episodes correlate to a drop in crime in Mexico

Access data here: https://livejohnshopkins-my.sharepoint.com/:f:/g/personal/jma82_jh_edu/IgB8mAnKwP4IQoMdjwphuxauAUK0mPuFTDQGVg7tynmArZs?e=0KYzhT

## Requirements:
- MySQL
- MySQL Workbench

## How to load data:
1. Create a new schema in MySQL Workbench
2. Right click your schema and click "Table Data Import Wizard"
3. Select your data and click Next until import is complete
4. Repeat for the remaining data files

*Note: CSV data is needed entirely for uploading to phpMyAdmin, but a JSON files were used for certain MySQLWorkbench queries
**Note: Due to the extremely large nature of reportedCrime.CSV, the easiest way we found to upload the data to phpMyAdmin was to establish the connection first and then load the data into MySQLWorkbench

## How to run queries:
1. Open queries.sql in MySQL Workbench
2. Click the lightning bolt icon in the top left corner. Query results should appear in the bottom half of the screen
