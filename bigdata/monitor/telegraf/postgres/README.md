# PostgreSQL Database Performance Component.
Monitoring PostgreSQL Database with Telegraf and InfluxDB and Grafana

- PostgreSQL:`9.6.0`
- Telegraf:`1.9.0`
- Influxdb:`1.7.0`
- Grafana:`5.2.2`

## Editing Telegraf Config 
Navigate to your Telegraf config file and find the [[inputs.postgresql]] section.  If you’re using a centOS install Telegraf,this path `/etc/telegraf/telegraf.conf` should get you to the default config file. Otherwise, feel free to refer to the [Telegraf docs](https://docs.influxdata.com/telegraf/v1.7) for further reference.
```
##Simple Example
[[inputs.postgresql]]
address = "host=localhost user=postgres password=postgres dbname=hive"
ignored_databases = ["template0","template1"]
```
## Import the Grafana json config file to grafana dashboard

To the Grafana home `Create`->`Import`->`Upload .json File` 


