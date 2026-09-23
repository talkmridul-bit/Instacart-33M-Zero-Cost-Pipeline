# Instacart-33M-Zero-Cost-Pipeline
Processing 33 Million+ Instacart dataset rows on a local Core i3 / 4GB RAM machine with $0.00 OPEX. Proves that smart R memory management and stream pipelining beat brute-force cloud infrastructure.

## 🚀 Overview
Common industry practice dictates spinning up expensive distributed clusters (like Spark or Snowflake) the moment a dataset crosses a few million rows. This case study challenges that assumption by processing **33 Million+ rows** of complex Instacart data on a constrained local machine under extreme hardware limitations.

* **Dataset:** Instacart Market Basket Analysis (33M+ rows)
* **Environment:** Local single-node machine (Intel Core i3, 4GB Total RAM)
* **OS Overhead:** ~2GB occupied by Windows 10, leaving a razor-thin working memory margin.
* **Cost:** **$0.00** (Zero cloud infrastructure, purely local execution)
* **Tech Stack:** R (`tidyverse`, `readr`)

---

## 📊 Data Architecture & Pipeline Flow

The ingestion and cleaning pipeline is designed to eliminate Out-Of-Memory (OOM) crashes by aggressively shrinking the dataset footprint *before* memory allocations expand.

[ Raw CSV Data (33M+ Rows) ]
│
▼
[ Stream Ingestion & Type Casting ] ──► (Enforces strict 32-bit integers to prevent R type inflation)
│
▼
[ Filtering & Deduplication ]     ──► (Strips invalid keys & duplicate rows instantly)
│
▼
[ Streamlined Export ]            ──► (Writes clean output safely via write.csv with 0 OOM crashes)

🔑 Key Engineering Takeaways

    Explicit Type Casting: 
           Default auto-guessing in R inflates memory footprints. Forcing strict 32-bit integers (as.integer) instantly drops 
           active RAM overhead.

    Early Filtering:
           
           Filtering out unwanted keys and garbage rows during ingestion saves gigabytes of temporary swap space.

    Systems Thinking over Brute Force: 
          Proper single-node stream optimization often negates the need for costly cloud clusters on medium-to-large datasets.
