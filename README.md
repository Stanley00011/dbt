# SmartWaterFlow: Anomaly Detection for Urban Water Infrastructure

SmartWaterFlow is an end-to-end data engineering pipeline that simulates and analyses smart water meter data to detect leaks, pressure anomalies, and outages, delivering insights that support scalable, sustainable urban water systems.

Built with modern data tools including **Python**, **BigQuery**, **dbt Cloud**, and **Looker Studio**, this project showcases how scalable, cloud-native data infrastructure can support smart infrastructure, utility resilience, and proactive maintenance workflows.


## Project Objective

Urban water systems lose billions annually to undetected leaks and inefficiencies.  
**SmartWaterFlow** simulates and analyses water flow and pressure from smart meters to:

- Simulating water meter data (flow rate, pressure, and location)
- Transform and aggregate data using dbt and SQL best practices
- Detect and classify anomalies based on thresholds and logic
- Visualise system behaviour in a cloud-native dashboard

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

| Model                  | Description                                               |
| ---------------------- | --------------------------------------------------------- |
| `stg_meter_readings`   | Cleans, deduplicates, and types raw meter data            |
| `int_flow_summary`     | Hourly aggregates + rolling 3-hour avg + flow deltas      |
| `dim_meters`           | Meter metadata (type, district, location, status)         |
| `mart_anomalies`       | Classifies readings as leak, spike, offline, or normal    |
| `mart_anomaly_summary` | Aggregated anomaly counts by meter type, district, status |

### Dashboard Overview
[View the live dashboard](https://lookerstudio.google.com/reporting/4307c571-bed6-4dc2-b3c6-3165ec7f696b)

### Charts:

Anomaly Status Breakdown – Pie chart showing anomaly distribution

Anomalies Over Time – Time series trend by hour

Smart Meter Anomaly Map – Geospatial bubble view

Recent Detected Anomalies – Filterable table of latest events

Pressure vs. Flow – Bubble chart for identifying usage extremes

3-Hour Rolling Average Flow (L/min) – Smoothed time-based trend line

Anomaly % by Meter Type – Summary bar chart from anomaly mart

### Why This Project Matters
Water loss from leaks and undetected anomalies costs cities billions annually. This project demonstrates how data engineers can:

Rapidly simulate and process streaming data

Build modular, testable transformation layers

Create operational dashboards for immediate insight

Enable proactive maintenance and smarter urban systems

### Repository Structure

```bash
smartwaterflow-pipeline/
├── dbt_project.yml
├── models/
│   └── smart_waterflow_project/
│       ├── stg_meter_readings.sql
│       ├── int_flow_summary.sql
│       ├── mart_anomalies.sql
│       ├── mart_anomaly_summary.sql
│       ├── dim_meters.sql
│       ├── schema.yml
│       └── sources.yml
├── data_simulation/
│   └── simulate_meter_data.py

```

### Notes

The dataset is simulated to resemble smart water meter output, with geolocation centered near Lagos, Nigeria.

The project demonstrates a scalable, modular architecture suitable for utility-scale applications.

Easily extensible to integrate with real-time IoT sensor networks, utility APIs, or edge data streams.

Designed with a strong focus on data pipeline reliability, observability, and anomaly detection logic.

#### Author
Olajide Ajao
Data Analyst & Aspiring Data Engineer
Passionate about smart infrastructure, analytics, and urban resilience







