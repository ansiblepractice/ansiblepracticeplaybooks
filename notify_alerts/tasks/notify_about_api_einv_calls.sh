#!/bin/bash
OldDate=$(date -d "now() - 60 minutes" +"%Y-%m-%d %H:%M:%S")
Date1=$(date +"%Y-%m-%d %H:%M:%S")
mysqlEnvironmentConfig="-u USERNAME -pPASSWORD -h HOSTNAME DBNAME"
gst_api_log_query="select count(distinct o.org_name) as api_einv_calls FROM prod_inc_asp_db.gst_api_log as a  
inner join prod_inc_asp_db.om_org_business_places as b on a.ref_id = b.org_bp_id
inner join prod_inc_asp_db.om_organizations as o on b.org_id = o.org_id
where a.action='ERP_EINV_GEN_API' and a.created_ts between '$OldDate' and '$Date1';"
mysql $mysqlEnvironmentConfig -e "$gst_api_log_query"
