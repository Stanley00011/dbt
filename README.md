# SmartWaterFlow: Real-Time Anomaly Detection for Urban Water Infrastructure

SmartWaterFlow is an end-to-end data engineering pipeline that simulates and processes smart meter data to detect critical events in urban water systems, such as leaks, pressure anomalies, and meter outages, in real time.

Built using modern data tools including **BigQuery**, **dbt**, and **Looker Studio**, this project showcases how scalable, cloud-native data infrastructure can support smarter and more sustainable cities.


## Project Objective

Water infrastructure is one of the most critical yet under-monitored utilities in many cities.  
**SmartWaterFlow** addresses this gap by:

- Simulating water meter data (flow rate, pressure, and location)
- Processing and transforming it with modern data stack best practices
- Detecting anomalies that may indicate leaks, outages, or pressure spikes
- Visualising trends and issues on a real-time, interactive dashboard

This system is designed to be easily extendable to:
- IoT/edge sensor networks
- Smart city water governance
- Maintenance and operational intelligence platforms


## Architecture Overview

```text
        Simulated Meter Data (Python)
                  ↓
         BigQuery Raw Table (CSV Upload)
                  ↓
           dbt Cloud Models (4 Layers)
                  ↓
       Final Tables with Anomalies + Location
                  ↓
       Looker Studio Dashboard (Live Insights)

```
## Tech Stack
| Layer           | Tool                   |
| --------------- | ---------------------- |
| Data Simulation | Python (Pandas, NumPy) |
| Data Storage    | Google BigQuery        |
| Transformation  | dbt Cloud (v1.7)       |
| Visualization   | Looker Studio          |
| Version Control | GitHub                 |


## dbt Model Layers

| Model                          | Purpose                                   |
| ------------------------------ | ----------------------------------------- |
| `stg_meter_readings`           | Cleans and types raw readings             |
| `int_flow_summary`             | Calculates hourly average flow & pressure |
| `mart_anomalies`               | Flags leak/offline/spike/normal events    |
| `mart_anomalies_with_location` | Adds latitude/longitude for mapping       |

### Dashboard Overview
[View the live dashboard](https://lookerstudio.google.com/reporting/4307c571-bed6-4dc2-b3c6-3165ec7f696b)

### Charts:

Anomaly Status Breakdown – Pie chart showing % of leaks, spikes, etc.

Anomalies Over Time – Time series chart for detecting trends

Smart Meter Anomaly Map – Google Maps view of meter statuses

Average Flow Over Time – Line chart of L/min readings

Average Pressure Over Time – Line chart of psi readings

Recent Detected Anomalies – Filterable table showing latest issues

### Why This Project Matters
Water loss from leaks and undetected anomalies costs cities billions annually. This project demonstrates how data engineers can:

Rapidly simulate and process streaming data

Build modular, testable transformation layers

Create operational dashboards for immediate insight

Enable proactive maintenance and smarter urban systems

<pre> ```bash smartwaterflow-pipeline/ ├── dbt_project.yml ├── models/ │ └── smart_waterflow_project/ │ ├── stg_meter_readings.sql │ ├── int_flow_summary.sql │ ├── mart_anomalies.sql │ ├── mart_anomalies_with_location.sql │ ├── schema.yml │ └── sources.yml ├── data_simulation/ │ └── simulate_meter_data.py ``` </pre>
Notes

The dataset is simulated to resemble smart water meter output, with geolocation centered near Lagos, Nigeria.

The project demonstrates a scalable, modular architecture suitable for utility-scale applications.

Easily extensible to integrate with real-time IoT sensor networks, utility APIs, or edge data streams.

Designed with a strong focus on data pipeline reliability, observability, and anomaly detection logic.

Author
Olajide Ajao
Data Analyst & Aspiring Data Engineer
Passionate about smart infrastructure, analytics, and urban resilience







