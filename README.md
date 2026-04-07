# spike-dp-analysts (Approach 1 - Split Bundles)

## Approach

Both repos have their own Databricks Asset Bundle and deploy independently. This repo (analysts) owns the dbt project and deploys dbt workflows. The core repo builds the wheel, owns Spark source code, configs, schemas, and deploys bronze/silver workflows. The cross-repo contract is the **silver tables** -- dbt workflows in this repo trigger when silver tables are updated by the core repo.

## What This Repo Contains

| Component | Description |
|---|---|
| `dbt_project/` | Full dbt project -- models (gold layer), macros, tests, fixtures, profiles, packages |
| `workflows/` | 2 Databricks workflow YAMLs (dbt jobs) |
| `databricks.yml` | Databricks Asset Bundle config (bundle name: `dp-analysts`) |
| `pyproject.toml` | Python project config (dbt + sqlfluff dev dependencies only) |

## Workflows Owned

### Finance
- `tesco_sales_transactions` -- dbt build for `finance_gold` models, triggered by silver table updates

### CCS / Revenue Assurance
- `revenue_assurance_dbt` -- dbt build for `revenue_assurance_gold` models, triggered by silver table updates

## dbt Project Structure

```
dbt_project/
  models/
    finance_gold/              -- tesco_sales_transactions, online_sales_transactions
    revenue_assurance_gold/    -- usage models, blugem reconciliation + intermediates
    tesco_sources.yml          -- source definitions (silver tables from core repo)
    vm02_revenue_assurance_silver_sources.yml
  macros/                      -- generate_schema_name, assert_developer_prefix
  tests/                       -- generic tests, fixtures, unit tests
  profiles.yml                 -- Databricks connection profiles per environment
```

## CI/CD

| Pipeline | What It Does |
|---|---|
| `ci.yml` | Snyk scan, pre-commit (dbt-checkpoint, sqlfluff), dbt unit tests |
| `cd.yml` | Deploys to dev via `databricks bundle deploy` |

## Local Development

```bash
poetry install --with dev
cd dbt_project
export DEVELOPER_PREFIX=your_prefix
dbt deps
dbt build --target dev --vars '{"catalog": "eun_dev_906_dh_data_db"}'
```

## Relationship With spike-dp-core

```
spike-dp-core                          spike-dp-analysts
(separate repo)                        (this repo)
 Bronze/Silver workflows                dbt workflows
 Spark code + wheel                     dbt models (gold layer)
 configs + schemas                      profiles.yml
         |                                     |
         v                                     v
   Silver tables  ---- trigger ---->   dbt builds gold tables
```
