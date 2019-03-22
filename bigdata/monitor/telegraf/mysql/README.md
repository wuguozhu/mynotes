# MySQL性能指标监控

本文将指导您完成创建交互式、实时和动态仪表板的每个步骤，以便使用Telegraf、Influxdb和Grafana监视MySQL实例。安装完telegraf后修改 `/etc/telegraf/telegraf.conf`:

```
# # Read metrics from one or many mysql servers
 [[inputs.mysql]]
    servers = ["root:Alnitak1234!@tcp(localhost:3306)/?tls=false"]
       perf_events_statements_digest_text_limit  = 120
   perf_events_statements_limit              = 250
   perf_events_statements_time_limit         = 86400
#   ## if the list is empty, then metrics are gathered from all databasee tables
   table_schema_databases                    = []
#   ## gather metrics from INFORMATION_SCHEMA.TABLES for databases provided above list
   gather_table_schema                       = false
#   ## gather thread state counts from INFORMATION_SCHEMA.PROCESSLIST
   gather_process_list                       = true
#   ## gather user statistics from INFORMATION_SCHEMA.USER_STATISTICS
   gather_user_statistics                    = true
#   ## gather auto_increment columns and max values from information schema
   gather_info_schema_auto_inc               = true
#   ## gather metrics from INFORMATION_SCHEMA.INNODB_METRICS
   gather_innodb_metrics                     = true
#   ## gather metrics from SHOW SLAVE STATUS command output
   gather_slave_status                       = true
#   ## gather metrics from SHOW BINARY LOGS command output
   gather_binary_logs                        = false
#   ## gather metrics from PERFORMANCE_SCHEMA.TABLE_IO_WAITS_SUMMARY_BY_TABLE
   gather_table_io_waits                     = false
#   ## gather metrics from PERFORMANCE_SCHEMA.TABLE_LOCK_WAITS
   gather_table_lock_waits                   = false
#   ## gather metrics from PERFORMANCE_SCHEMA.TABLE_IO_WAITS_SUMMARY_BY_INDEX_USAGE
   gather_index_io_waits                     = false
#   ## gather metrics from PERFORMANCE_SCHEMA.EVENT_WAITS
   gather_event_waits                        = false
#   ## gather metrics from PERFORMANCE_SCHEMA.FILE_SUMMARY_BY_EVENT_NAME
   gather_file_events_stats                  = false
#   ## gather metrics from PERFORMANCE_SCHEMA.EVENTS_STATEMENTS_SUMMARY_BY_DIGEST
   gather_perf_events_statements             = false
#   ## Some queries we may want to run less often (such as SHOW GLOBAL VARIABLES)
   interval_slow                   = "30m"
```
You can now import the `` file by opening the dashboard dropdown menu and clicking **Import**:

现在可以导入`Performance-metrics-for-Mysql.json`。打开dashboard下拉菜单，点击`Import`:

如果本文对您有所帮助，请给个`start`本人将不胜感激，谢谢！

本文参考了以下文章：
https://dzone.com/articles/mysql-monitoring-with-telegraf-influxdb-amp-grafan
https://github.com/influxdata/telegraf/tree/master/plugins/inputs/mysql

感谢以上原创作者。

