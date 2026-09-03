# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "jupyter",
# META     "jupyter_kernel_name": "python3.12"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "bfa3b424-c643-4ac3-91f8-c01e560e5ce9",
# META       "default_lakehouse_name": "warehouse_training_lab_sample_data",
# META       "default_lakehouse_workspace_id": "3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3",
# META       "known_lakehouses": [
# META         {
# META           "id": "bfa3b424-c643-4ac3-91f8-c01e560e5ce9"
# META         }
# META       ]
# META     },
# META     "warehouse": {
# META       "default_warehouse": "cbe97f0f-af6b-be79-4b93-578fd2554691",
# META       "known_warehouses": [
# META         {
# META           "id": "cbe97f0f-af6b-be79-4b93-578fd2554691",
# META           "type": "Datawarehouse"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

# Install LakeBench and its optional extras
!pip install lakebench[tpch_datagen,tpcds_datagen]==1.2.0


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "jupyter_python"
# META }

# CELL ********************

# Generate TPC-H data into the attached Lakehouse's Files area

from lakebench.datagen import TPCHDataGenerator

datagen = TPCHDataGenerator(
    scale_factor=1,
    target_folder_uri='/lakehouse/default/Files/tpch_sf1'
)
datagen.run()


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "jupyter_python"
# META }

# CELL ********************

# Generate TPC-DS data into the attached Lakehouse's Files area

from lakebench.datagen import TPCDSDataGenerator

datagen = TPCDSDataGenerator(
    scale_factor=1,
    target_folder_uri='/lakehouse/default/Files/tpcds_sf1'
)
datagen.run()


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "jupyter_python"
# META }
