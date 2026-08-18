# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "jupyter",
# META     "jupyter_kernel_name": "python3.12"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "023336ad-ad68-40ff-b90a-063128753fb0",
# META       "default_lakehouse_name": "demolakehouse",
# META       "default_lakehouse_workspace_id": "0631bff8-b82c-4800-bc4f-b1f6cd2b9cfc",
# META       "known_lakehouses": [
# META         {
# META           "id": "023336ad-ad68-40ff-b90a-063128753fb0"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

# Install LakeBench and its optional extras
!pip install lakebench[tpch_datagen]==1.2.0


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "jupyter_python"
# META }

# CELL ********************

# Generate TPC-DS data into the attached Lakehouse's Files area

from lakebench.datagen import TPCHDataGenerator

datagen = TPCHDataGenerator(
    scale_factor=300,
    target_folder_uri='/lakehouse/default/Files/tpch_sf1'
)
datagen.run()


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "jupyter_python"
# META }
