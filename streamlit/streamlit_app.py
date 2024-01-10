# Import python packages
import streamlit as st
from snowflake.snowpark.context import get_active_session

# Write directly to the app
st.title("Example Streamlit App :snowflake:")

# Get the current credentials
session = get_active_session()

rule_results = session.sql('''
select 
    RULE_ID,
    RULE_CATEGORY,
    RULE_NAME,
    RULE_DESCRIPTION,
    RULE_DOCLINK,
    CNT_RULE_VIOLATIONS 
from BR_MAINTENANCE.SAE_MART.AGG_RESULTS
order by RULE_STATUS, RULE_CATEGORY, RULE_NAME desc
''').collect()

for rule_result in rule_results:
    if rule_result["CNT_RULE_VIOLATIONS"] == 0:
        title = '🟢 ' + rule_result["RULE_CATEGORY"] + ' / ' + rule_result["RULE_NAME"]
    else:
        title = '🔴 ' + rule_result["RULE_CATEGORY"] + ' / ' + rule_result["RULE_NAME"] + ' (' + str(rule_result["CNT_RULE_VIOLATIONS"]) + ')'
    with st.expander(title):
        st.markdown(rule_result["RULE_DESCRIPTION"])
        st.markdown(rule_result["RULE_DOCLINK"])

        gr = session.sql(f'select * from br_maintenance.sae_mart.{rule_result["RULE_ID"]}')
        st.dataframe(gr)