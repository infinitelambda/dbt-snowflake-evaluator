{{ config(
  sql_header="SHOW NETWORK POLICIES;"
) }}

select
    "name" as __id,
    --
    "created_on" as created_on,
    "name" as name,
    "comment" as comment,
    "entries_in_allowed_ip_list" as entries_in_allowed_ip_list,
    "entries_in_blocked_ip_list" as entries_in_blocked_ip_list,
    "entries_in_allowed_network_rules" as entries_in_allowed_network_rules,
    "entries_in_blocked_network_rules" as entries_in_blocked_network_rules
from
    table(result_scan(last_query_id()))
