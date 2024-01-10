# Store the data from the sys views/show commands
dbt run -s 01_landing --full-refresh

# Stage layer is empty

# Conform layer also empty at the moment

# Mart
dbt run -s 04_mart.rules
dbt run -s 04_mart.agg

# Semantic Layer
# MF example query for the central-app
# mf query --metrics cnt_rule_violations --group-by rule,rule__category,rule__name,rule__description,rule__doclink,rule__status,rule__identifiers --csv rules_results.csv
