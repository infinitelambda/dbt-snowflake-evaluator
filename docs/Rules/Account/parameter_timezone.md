# Parameter Timezone

## Model name

```
parameter_timezone
```

## Description

Snowflake uses America/Los Angeles as default timezone which can lead some strange issues. It’s not a problem if you use the same timezone (mostly UTC is suggested) or timezone_ltz datatypes, but with ntz you can be in trouble. :slight_smile: 

## SQL

```
SHOW PARAMETERS IN ACCOUNT;
select *
from
    table(result_scan(last_query_id()))
where True
    and parameter_value = parameter_default
    and parameter_key = 'TIMEZONE';
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/sql-reference/parameters#label-timezone)

> Specifies the time zone for the session.
> 
> Values: You can specify a time zone name or a link name from release 2021a of the IANA Time Zone Database (e.g. America/Los_Angeles, Europe/London, UTC, Etc/GMT, etc.).
>
> Default: America/Los_Angeles

## How to Remediate

Setting up UTC as the default timezone:

```
-- session level
show parameters like 'TIMEZONE';

key	        value	            default	          
TIMEZONE	America/Los_Angeles	America/Los_Angeles

-- same but account level
show parameters like 'TIMEZONE' in account;

-- alter to UTC timezone
ALTER ACCOUNT SET TIMEZONE = 'UTC';
```