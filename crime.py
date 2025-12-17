import pandas as pd
try:
    df = pd.read_csv('CRIME.csv')
except FileNotFoundError:
    print("Error: 'CRIME.csv' not found. Please check the file path.")
    exit()
id_vars = ['YEAR', 'INEGI', 'ENTITY', 'MODE', 'TYPE', 'SUBTYPE']
value_vars = [
    'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
    'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'
]

df_reformatted = pd.melt(
    df,
    id_vars=id_vars,       
    value_vars=value_vars, 
    var_name='MONTH_NAME', 
    value_name='COUNT'     
)
month_map = {
    'JANUARY': 1, 'FEBRUARY': 2, 'MARCH': 3, 'APRIL': 4, 'MAY': 5, 'JUNE': 6,
    'JULY': 7, 'AUGUST': 8, 'SEPTEMBER': 9, 'OCTOBER': 10, 'NOVEMBER': 11, 'DECEMBER': 12
}
df_reformatted['MONTH'] = df_reformatted['MONTH_NAME'].map(month_map)
df_reformatted = df_reformatted.drop(columns=['MONTH_NAME'])
df_reformatted = df_reformatted[['YEAR', 'INEGI', 'ENTITY', 'MODE', 'TYPE', 'SUBTYPE', 'MONTH', 'COUNT']]

# CSV Output
df_reformatted.to_csv('CRIME_Reformatted.csv', index=False)
print("Successfully created 'CRIME_Reformatted.csv'")

# JSON Output (one record per line)
df_reformatted.to_json('CRIME_Reformatted.json', orient='records', lines=True)
print("Successfully created 'CRIME_Reformatted.json'")
