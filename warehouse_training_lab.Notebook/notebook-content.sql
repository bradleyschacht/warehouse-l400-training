-- Fabric notebook source

-- METADATA ********************

-- META {
-- META   "kernel_info": {
-- META     "name": "sqldatawarehouse"
-- META   },
-- META   "dependencies": {
-- META     "warehouse": {
-- META       "default_warehouse": "cbe97f0f-af6b-be79-4b93-578fd2554691",
-- META       "known_warehouses": [
-- META         {
-- META           "id": "cbe97f0f-af6b-be79-4b93-578fd2554691",
-- META           "type": "Datawarehouse"
-- META         }
-- META       ]
-- META     }
-- META   }
-- META }

-- MARKDOWN ********************

-- # Getting started
-- 
-- Before you begin:
-- 
-- 1. Change the workspace collation setting to case insensitive. While not required, this will help ensure a more smooth experience. 
-- 1. From the workspace item view, select **New** from the top left corner of the screen and create a new warehouse. 
-- 1. _If necessary:_ From the ribbon of this notebook, change the runtime to use T-SQL by selecting the **PySpark (Python)** dropdown menu and selecting the **T-SQL** runtime under the **T-SQL Analytics** section. 
-- 1. Using the explorer pane on the left side of the screen select **Add data items** and use the OneLake catalog to add the warehouse created in step 2 above. 

-- MARKDOWN ********************

-- # 🛠️ Lab setup
-- 
-- Be sure to replace the workspace_id and lakehouse_id variables with the appropriate values for where your sample data is stored.

-- CELL ********************

DROP TABLE IF EXISTS dbo.customer;
DROP TABLE IF EXISTS dbo.lineitem;
DROP TABLE IF EXISTS dbo.lineitem_clustered;
DROP TABLE IF EXISTS dbo.lineitem_clustered_bad;
DROP TABLE IF EXISTS dbo.lineitem_data_factory;
DROP TABLE IF EXISTS dbo.lineitem_insert_into;
DROP TABLE IF EXISTS dbo.lineitem_openrowset;
DROP TABLE IF EXISTS dbo.nation;
DROP TABLE IF EXISTS dbo.orders;
DROP TABLE IF EXISTS dbo.part;
DROP TABLE IF EXISTS dbo.partsupp;
DROP TABLE IF EXISTS dbo.region;
DROP TABLE IF EXISTS dbo.supplier;


CREATE TABLE dbo.customer
    (
        c_custkey           BIGINT          NOT NULL,
        c_name              VARCHAR(25)     NOT NULL,
        c_address           VARCHAR(40)     NOT NULL,
        c_nationkey         INT             NOT NULL,
        c_phone             CHAR(15)        NOT NULL,
        c_acctbal           DECIMAL(12, 2)  NOT NULL,
        c_mktsegment        CHAR(10)        NOT NULL,
        c_comment           VARCHAR(117)    NOT NULL
    );


CREATE TABLE dbo.lineitem
    (
        l_orderkey          BIGINT          NOT NULL,
        l_partkey           BIGINT          NOT NULL,
        l_suppkey           BIGINT          NOT NULL,
        l_linenumber        INT             NOT NULL,
        l_quantity          DECIMAL(12, 2)  NOT NULL,
        l_extendedprice     DECIMAL(12, 2)  NOT NULL,
        l_discount          DECIMAL(12, 2)  NOT NULL,
        l_tax               DECIMAL(12, 2)  NOT NULL,
        l_returnflag        CHAR(1)         NOT NULL,
        l_linestatus        CHAR(1)         NOT NULL,
        l_shipdate          DATE            NOT NULL,
        l_commitdate        DATE            NOT NULL,
        l_receiptdate       DATE            NOT NULL,
        l_shipinstruct      CHAR(25)        NOT NULL,
        l_shipmode          CHAR(10)        NOT NULL,
        l_comment           VARCHAR(44)     NOT NULL
    );


CREATE TABLE dbo.lineitem_clustered
    (
        l_orderkey          BIGINT          NOT NULL,
        l_partkey           BIGINT          NOT NULL,
        l_suppkey           BIGINT          NOT NULL,
        l_linenumber        INT             NOT NULL,
        l_quantity          DECIMAL(12, 2)  NOT NULL,
        l_extendedprice     DECIMAL(12, 2)  NOT NULL,
        l_discount          DECIMAL(12, 2)  NOT NULL,
        l_tax               DECIMAL(12, 2)  NOT NULL,
        l_returnflag        CHAR(1)         NOT NULL,
        l_linestatus        CHAR(1)         NOT NULL,
        l_shipdate          DATE            NOT NULL,
        l_commitdate        DATE            NOT NULL,
        l_receiptdate       DATE            NOT NULL,
        l_shipinstruct      CHAR(25)        NOT NULL,
        l_shipmode          CHAR(10)        NOT NULL,
        l_comment           VARCHAR(44)     NOT NULL
    )
WITH (CLUSTER BY (l_shipdate));


CREATE TABLE dbo.lineitem_clustered_bad
    (
        l_orderkey          BIGINT          NOT NULL,
        l_partkey           BIGINT          NOT NULL,
        l_suppkey           BIGINT          NOT NULL,
        l_linenumber        INT             NOT NULL,
        l_quantity          DECIMAL(12, 2)  NOT NULL,
        l_extendedprice     DECIMAL(12, 2)  NOT NULL,
        l_discount          DECIMAL(12, 2)  NOT NULL,
        l_tax               DECIMAL(12, 2)  NOT NULL,
        l_returnflag        CHAR(1)         NOT NULL,
        l_linestatus        CHAR(1)         NOT NULL,
        l_shipdate          DATE            NOT NULL,
        l_commitdate        DATE            NOT NULL,
        l_receiptdate       DATE            NOT NULL,
        l_shipinstruct      CHAR(25)        NOT NULL,
        l_shipmode          CHAR(10)        NOT NULL,
        l_comment           VARCHAR(44)     NOT NULL
    )
WITH (CLUSTER BY (l_linenumber));


CREATE TABLE dbo.lineitem_data_factory
    (
        l_orderkey          BIGINT          NOT NULL,
        l_partkey           BIGINT          NOT NULL,
        l_suppkey           BIGINT          NOT NULL,
        l_linenumber        INT             NOT NULL,
        l_quantity          DECIMAL(12, 2)  NOT NULL,
        l_extendedprice     DECIMAL(12, 2)  NOT NULL,
        l_discount          DECIMAL(12, 2)  NOT NULL,
        l_tax               DECIMAL(12, 2)  NOT NULL,
        l_returnflag        CHAR(1)         NOT NULL,
        l_linestatus        CHAR(1)         NOT NULL,
        l_shipdate          DATE            NOT NULL,
        l_commitdate        DATE            NOT NULL,
        l_receiptdate       DATE            NOT NULL,
        l_shipinstruct      CHAR(25)        NOT NULL,
        l_shipmode          CHAR(10)        NOT NULL,
        l_comment           VARCHAR(44)     NOT NULL
    );


CREATE TABLE dbo.lineitem_insert_into
    (
        l_orderkey          BIGINT          NOT NULL,
        l_partkey           BIGINT          NOT NULL,
        l_suppkey           BIGINT          NOT NULL,
        l_linenumber        INT             NOT NULL,
        l_quantity          DECIMAL(12, 2)  NOT NULL,
        l_extendedprice     DECIMAL(12, 2)  NOT NULL,
        l_discount          DECIMAL(12, 2)  NOT NULL,
        l_tax               DECIMAL(12, 2)  NOT NULL,
        l_returnflag        CHAR(1)         NOT NULL,
        l_linestatus        CHAR(1)         NOT NULL,
        l_shipdate          DATE            NOT NULL,
        l_commitdate        DATE            NOT NULL,
        l_receiptdate       DATE            NOT NULL,
        l_shipinstruct      CHAR(25)        NOT NULL,
        l_shipmode          CHAR(10)        NOT NULL,
        l_comment           VARCHAR(44)     NOT NULL
    );


CREATE TABLE dbo.lineitem_openrowset
    (
        l_orderkey          BIGINT          NOT NULL,
        l_partkey           BIGINT          NOT NULL,
        l_suppkey           BIGINT          NOT NULL,
        l_linenumber        INT             NOT NULL,
        l_quantity          DECIMAL(12, 2)  NOT NULL,
        l_extendedprice     DECIMAL(12, 2)  NOT NULL,
        l_discount          DECIMAL(12, 2)  NOT NULL,
        l_tax               DECIMAL(12, 2)  NOT NULL,
        l_returnflag        CHAR(1)         NOT NULL,
        l_linestatus        CHAR(1)         NOT NULL,
        l_shipdate          DATE            NOT NULL,
        l_commitdate        DATE            NOT NULL,
        l_receiptdate       DATE            NOT NULL,
        l_shipinstruct      CHAR(25)        NOT NULL,
        l_shipmode          CHAR(10)        NOT NULL,
        l_comment           VARCHAR(44)     NOT NULL
    );


CREATE TABLE dbo.nation
    (
        n_nationkey         INT             NOT NULL,
        n_name              CHAR(25)        NOT NULL,
        n_regionkey         INT             NOT NULL,
        n_comment           VARCHAR(152)    NOT NULL
    );


CREATE TABLE dbo.orders
    (
        o_orderkey          BIGINT          NOT NULL,
        o_custkey           BIGINT          NOT NULL,
        o_orderstatus       CHAR(1)         NOT NULL,
        o_totalprice        DECIMAL(12, 2)  NOT NULL,
        o_orderdate         DATE            NOT NULL,
        o_orderpriority     CHAR(15)        NOT NULL,
        o_clerk             CHAR(15)        NOT NULL,
        o_shippriority      INT             NOT NULL,
        o_comment           VARCHAR(79)     NOT NULL
    );


CREATE TABLE dbo.part
    (
        p_partkey           BIGINT          NOT NULL,
        p_name              VARCHAR(55)     NOT NULL,
        p_mfgr              CHAR(25)        NOT NULL,
        p_brand             CHAR(10)        NOT NULL,
        p_type              VARCHAR(25)     NOT NULL,
        p_size              INT             NOT NULL,
        p_container         CHAR(10)        NOT NULL,
        p_retailprice       DECIMAL(12, 2)  NOT NULL,
        p_comment           VARCHAR(23)     NOT NULL
    );


CREATE TABLE dbo.partsupp
    (
        ps_partkey          BIGINT          NOT NULL,
        ps_suppkey          BIGINT          NOT NULL,
        ps_availqty         INT             NOT NULL,
        ps_supplycost       DECIMAL(12, 2)  NOT NULL,
        ps_comment          VARCHAR(199)    NOT NULL
    );


CREATE TABLE dbo.region
    (
        r_regionkey         INT             NOT NULL,
        r_name              VARCHAR(25)     NOT NULL,
        r_comment           VARCHAR(152)    NOT NULL
    );


CREATE TABLE dbo.supplier
    (
        s_suppkey           BIGINT          NOT NULL,
        s_name              CHAR(25)        NOT NULL,
        s_address           VARCHAR(40)     NOT NULL,
        s_nationkey         INT             NOT NULL,
        s_phone             CHAR(15)        NOT NULL,
        s_acctbal           DECIMAL(12, 2)  NOT NULL,
        s_comment           VARCHAR(101)    NOT NULL
    );

COPY INTO dbo.lineitem_clustered        FROM 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/lineitem/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - lineitem_clustered - COPY INTO');
COPY INTO dbo.lineitem_clustered_bad    FROM 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/lineitem/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - lineitem_clustered_bad - COPY INTO');
COPY INTO dbo.customer                  FROM 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/customer/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - customer - COPY INTO');
COPY INTO dbo.nation                    FROM 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/nation/*.parquet'     WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - nation - COPY INTO');
COPY INTO dbo.orders                    FROM 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/orders/*.parquet'     WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - orders - COPY INTO');
COPY INTO dbo.part                      FROM 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/part/*.parquet'       WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - part - COPY INTO');
COPY INTO dbo.partsupp                  FROM 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/partsupp/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - partsupp - COPY INTO');
COPY INTO dbo.region                    FROM 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/region/*.parquet'     WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - region - COPY INTO');
COPY INTO dbo.supplier                  FROM 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/supplier/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - supplier - COPY INTO');

select top 10
    l_orderkey,
    sum(l_extendedprice * (1 - l_discount)) as revenue,
    o_orderdate,
    o_shippriority
from
    customer,
    orders,
    lineitem_clustered
where
    c_mktsegment = 'MACHINERY'
    and c_custkey = o_custkey
    and l_orderkey = o_orderkey
    and (o_orderdate > '1995-03-01' and o_orderdate <  '1995-03-30')
    and (l_shipdate >  '1995-03-01' and l_shipdate < '1995-03-30')
group by
    l_orderkey,
    o_orderdate,
    o_shippriority
order by
    revenue desc,
    o_orderdate
option (label = 'Lab Prep Query - Clustering: Enabled');


select top 10
    l_orderkey,
    sum(l_extendedprice * (1 - l_discount)) as revenue,
    o_orderdate,
    o_shippriority
from
    customer,
    orders,
    lineitem_clustered_bad
where
    c_mktsegment = 'MACHINERY'
    and c_custkey = o_custkey
    and l_orderkey = o_orderkey
    and (o_orderdate > '1995-03-01' and o_orderdate <  '1995-03-30')
    and (l_shipdate >  '1995-03-01' and l_shipdate < '1995-03-30')
group by
    l_orderkey,
    o_orderdate,
    o_shippriority
order by
    revenue desc,
    o_orderdate
option (label = 'Lab Prep Query - Clustering: Enabled - Bad');

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- # 🚚 Data ingestion

-- CELL ********************

TRUNCATE TABLE dbo.lineitem;
COPY INTO dbo.lineitem FROM 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/lineitem/*.parquet' WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - lineitem - COPY INTO');

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

TRUNCATE TABLE dbo.lineitem_insert_into;
INSERT INTO dbo.lineitem_insert_into
SELECT
    *
FROM dbo.lineitem
OPTION (LABEL = 'Load - lineitem - INSERT INTO');

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

TRUNCATE TABLE dbo.lineitem_openrowset;
INSERT INTO dbo.lineitem_openrowset
SELECT
    *
FROM OPENROWSET(BULK 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/lineitem/*.parquet')
OPTION (LABEL = 'Load - lineitem - OPENROWSET');

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- 💡 **_Optional activity_** 
-- 
-- Create a copy activity in a Fabric Data Factory pipeline that loads the line item table from the same storage account into the warehouse table dbo.lineitem_datafactory. Run the pipeline and wait 5-10 minutes after it completes before moving on to the next cell in this notebook. The wait time is for the data to flow into the query insights tables.

-- CELL ********************

SELECT
    UPPER(distributed_statement_id) AS distributed_statement_id,
    submit_time,
    start_time,
    end_time,
    DATEDIFF(SECOND, start_time, end_time) AS runtime_in_seconds,
    row_count,
    program_name,
    label,
    sql_pool_name,
    allocated_cpu_time_ms,
    data_scanned_remote_storage_mb + data_scanned_memory_mb + data_scanned_disk_mb AS total_data_scanned,
    data_scanned_remote_storage_mb,
    data_scanned_disk_mb,
    data_scanned_memory_mb,
    command
FROM queryinsights.exec_requests_history
WHERE
    status = 'Succeeded'
    AND (
        label IN ('Load - lineitem - COPY INTO', 'Load - lineitem - OPENROWSET', 'Load - lineitem - INSERT INTO')
        OR (program_name LIKE 'Data Integration%' AND command LIKE 'COPY INTO%')
    )
ORDER BY
    allocated_cpu_time_ms

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- _Run these sample queries. The results will be used in a later lab._

-- CELL ********************

select
    ps_partkey,
    sum(ps_supplycost * ps_availqty) as value
from
    partsupp,
    supplier,
    nation
where
    ps_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'CHINA'
group by
    ps_partkey having
        sum(ps_supplycost * ps_availqty) > (
            select
                sum(ps_supplycost * ps_availqty) * 0.0000003333
            from
                partsupp,
                supplier,
                nation
            where
                ps_suppkey = s_suppkey
                and s_nationkey = n_nationkey
                and n_name = 'CHINA'
        )
order by
    value desc
option (label = 'Sample Query: 1');


select top 10
    l_orderkey,
    sum(l_extendedprice * (1 - l_discount)) as revenue,
    o_orderdate,
    o_shippriority
from
    customer,
    orders,
    lineitem
where
    c_mktsegment = 'MACHINERY'
    and c_custkey = o_custkey
    and l_orderkey = o_orderkey
    and (o_orderdate > '1995-03-01' and o_orderdate <  '1995-03-30')
    and (l_shipdate >  '1995-03-01' and l_shipdate < '1995-03-30')
group by
    l_orderkey,
    o_orderdate,
    o_shippriority
order by
    revenue desc,
    o_orderdate
option (label = 'Sample Query: 2');


select top 100
    s_acctbal,
    s_name,
    n_name,
    p_partkey,
    p_mfgr,
    s_address,
    s_phone,
    s_comment
from
    part,
    supplier,
    partsupp,
    nation,
    region
where
    p_partkey = ps_partkey
    and s_suppkey = ps_suppkey
    and p_size = 38
    and p_type like '%TIN'
    and s_nationkey = n_nationkey
    and n_regionkey = r_regionkey
    and r_name = 'EUROPE'
    and ps_supplycost = (
        select
            min(ps_supplycost)
        from
            partsupp,
            supplier,
            nation,
            region
        where
            p_partkey = ps_partkey
            and s_suppkey = ps_suppkey
            and s_nationkey = n_nationkey
            and n_regionkey = r_regionkey
            and r_name = 'EUROPE'
    )
order by
    s_acctbal desc,
    n_name,
    s_name,
    p_partkey
option (label = 'Sample Query: 3');

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- # ⚙️ Data transformation

-- MARKDOWN ********************

-- Data transformation methods are largely unchanged from SQL Server or Synapse Analytics. Some capabilities are different such as the exclusion of partitions which were used for large update operations in Synapse Analytics. Fabric warehouse unlocks new ETL patterns and data recovery options which are not available in other SQL engines in the Microsoft ecosystem or could operate in a different manner. Let's explore a few of those options:
-- 
-- - Snapshots
-- - Time travel
-- - Table clones
-- - Recovery points

-- MARKDOWN ********************

-- #### 📸 Warehouse snapshots
-- 
-- ❗ Begin by creating a snapshot of the data warehouse. To do this, navigate back to the workspace item list, open the warehouse, and go to manage snapshots on the ribbon. Be sure to give the snapshot the name **MySnapshot** to avoid errors in the cells below.

-- CELL ********************

SELECT * FROM MySnapshot.dbo.nation

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

TRUNCATE TABLE dbo.nation

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

SELECT * FROM MySnapshot.dbo.nation

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

SELECT * FROM dbo.nation

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

-- Recover the deleted data from the snapshot if it has the relevant data.

/*
INSERT INTO dbo.nation
SELECT * FROM MySnapshot.dbo.nation
*/

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- This method only helps if you are using snapshots and most customers today are not leveraging snapshots for reporting. What other options do you have?

-- MARKDOWN ********************

-- #### 🗑️ Recovering from ETL failures or accidental changes

-- MARKDOWN ********************

-- Time travel + table clone is an excellent path to recover from data consistency issues introduced by DML operations. 

-- CELL ********************

DECLARE @BeforeTheAccident VARCHAR(23) = (SELECT CONVERT(VARCHAR(23), DATEADD(MINUTE, -5, GETDATE()), 126))
EXEC ('SELECT COUNT(*) FROM dbo.nation OPTION (FOR TIMESTAMP AS OF ''' + @BeforeTheAccident + ''')');

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

DROP TABLE IF EXISTS dbo.nation_recovery
DECLARE @BeforeTheAccident VARCHAR(23) = (SELECT CONVERT(VARCHAR(23), DATEADD(MINUTE, -5, GETDATE()), 126))
EXEC ('CREATE TABLE dbo.nation_recovery AS CLONE OF dbo.nation AT ''' + @BeforeTheAccident + '''')

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

INSERT INTO dbo.nation
SELECT * FROM dbo.nation_recovery

SELECT 'dbo.nation'          AS table_name, COUNT(*) AS record_count FROM dbo.nation            UNION ALL
SELECT 'dbo.nation_recovery' AS table_name, COUNT(*) AS record_count FROM dbo.nation_recovery
ORDER BY table_name

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- #### ♻️ Restore points
-- 
-- ❗ Begin by creating a restore point for the data warehouse. To do this, navigate to the warehouse settings, go to the restore points page, and select add a restore point.
-- 
-- Consider adding this as a step at the beginning of batch ETL processes.

-- CELL ********************

SELECT 'dbo.nation'             AS table_name, COUNT(*) AS record_count FROM dbo.nation            UNION ALL
SELECT 'MySnapshot.dbo.nation'  AS table_name, COUNT(*) AS record_count FROM MySnapshot.dbo.nation
ORDER BY table_name

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

DROP TABLE dbo.nation

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

-- Note: This will fail!
-- Try time travel.

DECLARE @BeforeTheAccident VARCHAR(23) = (SELECT CONVERT(VARCHAR(23), DATEADD(MINUTE, -5, GETDATE()), 126))
EXEC ('SELECT COUNT(*) FROM dbo.nation OPTION (FOR TIMESTAMP AS OF ''' + @BeforeTheAccident + ''')');

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

-- Note: This will fail!
-- Go get the table from the snapshot.

INSERT INTO dbo.nation
SELECT * FROM MySnapshot.dbo.nation

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- _Restore the warehouse to our last restore point._

-- CELL ********************

SELECT * FROM dbo.nation

-- Or recreate and load the table.
/*
CREATE TABLE dbo.nation
    (
        n_nationkey         INT             NOT NULL,
        n_name              CHAR(25)        NOT NULL,
        n_regionkey         INT             NOT NULL,
        n_comment           VARCHAR(152)    NOT NULL
    );

COPY INTO dbo.nation FROM 'https://onelake.dfs.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/bfa3b424-c643-4ac3-91f8-c01e560e5ce9/Files/sampledata/nation/*.parquet'     WITH (FILE_TYPE = 'PARQUET');
*/

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- #### 🧬 Table clones
-- 
-- A solid ETL proof recovery method that does not require a full warehouse restore is the use of table clones. Keep in mind:
-- 
-- - Schema changes break history
-- - Dropped & recreated tables lose history
-- - Commands fail if referencing a time before the table was created

-- CELL ********************

-- Try to time travel to a point wihin the retention period but before the table was created and to a point outside the retention window. 

DECLARE @within_retention_window VARCHAR(23)

-- Within the retention window, before table was created.
BEGIN TRY
    
    SET @within_retention_window = (SELECT CONVERT(VARCHAR(23), DATEADD(DAY, -5, GETDATE()), 126))

    EXEC('
        SELECT TOP 1 *
        FROM dbo.nation
        OPTION (FOR TIMESTAMP AS OF ''' + @within_retention_window + ''')'
    )

END TRY
BEGIN CATCH
    
    SELECT
        ERROR_NUMBER() AS error_number,
        ERROR_SEVERITY() AS error_severity,
        ERROR_STATE() AS error_state,
        ERROR_MESSAGE() AS error_message;

END CATCH


-- Prior to the warehouse being created, therefore outisde the retention window.
BEGIN TRY
    
    SET @within_retention_window = (SELECT CONVERT(VARCHAR(23), DATEADD(DAY, -50, GETDATE()), 126))

    EXEC('
        SELECT TOP 1 *
        FROM dbo.nation
        OPTION (FOR TIMESTAMP AS OF ''' + @within_retention_window + ''')'
    )

END TRY
BEGIN CATCH
    
    SELECT
        ERROR_NUMBER() AS error_number,
        ERROR_SEVERITY() AS error_severity,
        ERROR_STATE() AS error_state,
        ERROR_MESSAGE() AS error_message;

END CATCH

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- _ETL safe table cloning. This method will not invalidate snapshots until the rename operation at which point the snapshot can be rolled forward._

-- CELL ********************

DROP TABLE IF EXISTS dbo.nation_etl
DROP TABLE IF EXISTS dbo.nation_old
DROP TABLE IF EXISTS dbo.nation_bad_data

DECLARE @clone_as_of_time VARCHAR(23) = (SELECT CONVERT(VARCHAR(23), DATEADD(MINUTE, -1, GETDATE()), 126))
EXEC ('CREATE TABLE dbo.nation_etl AS CLONE OF dbo.nation AT ''' + @clone_as_of_time + '''')

UPDATE dbo.nation_etl
SET n_comment = ''

SELECT * FROM dbo.nation
SELECT * FROM dbo.nation_etl;
GO

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

-- Rename the objects

sp_rename 'dbo.nation', 'nation_old'
GO
sp_rename 'dbo.nation_etl', 'nation'
GO

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

-- Oh no! Something is wrong.

SELECT * FROM dbo.nation
SELECT * FROM dbo.nation_old

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

-- We can recover from our old version still even without a restore point.
sp_rename 'dbo.nation', 'nation_bad_data'
GO
sp_rename 'dbo.nation_old', 'nation'
GO

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

-- Investigate the ETL issues using the bad data table, make changes, correct records all without affecting the previous version of the data.

SELECT * FROM dbo.nation
SELECT * FROM dbo.nation_bad_data

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

-- Schema changes don't break clones, but do break snapshots.

ALTER TABLE dbo.nation ADD my_new_column INT
ALTER TABLE dbo.nation_bad_data ADD investigation_results VARCHAR(MAX)

SELECT * FROM dbo.nation
SELECT * FROM dbo.nation_bad_data

ALTER TABLE dbo.nation DROP COLUMN my_new_column
ALTER TABLE dbo.nation_bad_data DROP COLUMN investigation_results

SELECT * FROM dbo.nation
SELECT * FROM dbo.nation_bad_data

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

-- ...and it resets time travel.

DECLARE @within_retention_window VARCHAR(23) = (SELECT CONVERT(VARCHAR(23), DATEADD(MINUTE, -5, GETDATE()), 126))

EXEC('SELECT * FROM dbo.nation OPTION (FOR TIMESTAMP AS OF ''' + @within_retention_window + ''')')

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- #### ✅ Comparing snapshots, time travel and clones

-- MARKDOWN ********************

-- | Question                                 | Answer               |
-- | ---------------------------------------- | -------------------- |
-- | Do schema changes break existing clones? | **No** ✅                                                |
-- | Are clones affected by source DDL?       | **No** ✅                                                |
-- | Do schema changes reset time travel?     | **Yes** ⚠️                                               |
-- | Best way to preserve old schema + data?  | **Create a clone** ✅                                    |
-- | Are snapshots affected by source DDL?    | **Yes** ⚠️ - Adding new tables does not break snapshots  |
-- 
-- <br>
-- <br>
-- 
-- | Feature         | Schema handling                                         |
-- | --------------- | ------------------------------------------------------- |
-- | **📸 Snapshot**    | Uses *current* schema + historical data → breaks at DDL (relies on time travel) |
-- | **⌚ Time travel** | Uses *current* schema → breaks at DDL                   |
-- | **🧬 Clone**       | Owns schema metadata → never breaks                     |


-- MARKDOWN ********************

-- # 🕵️ Monitoring and tuning

-- CELL ********************

SELECT
    UPPER(distributed_statement_id) AS distributed_statement_id,
    submit_time,
    start_time,
    end_time,
    DATEDIFF(SECOND, start_time, end_time) AS runtime_in_seconds,
    row_count,
    program_name,
    label,
    sql_pool_name,
    allocated_cpu_time_ms,
    data_scanned_remote_storage_mb + data_scanned_memory_mb + data_scanned_disk_mb AS total_data_scanned,
    data_scanned_remote_storage_mb,
    data_scanned_disk_mb,
    data_scanned_memory_mb,
    command
FROM queryinsights.exec_requests_history
WHERE
    status = 'Succeeded'
    AND (
        label IN ('Sample Query: 1', 'Sample Query: 2', 'Sample Query: 3', 'Load - lineitem - COPY INTO', 'Load - lineitem - OPENROWSET', 'Load - lineitem - INSERT INTO')
    )
ORDER BY
    allocated_cpu_time_ms

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- First, let's break up the compute and make sure our large ETL processes and reporting have enough resources to complete in their allotted amount of time using custom SQL pools. This can be done through code or through the workspace settings. 

-- MARKDOWN ********************

-- #### ➗ Custom SQL Pools

-- MARKDOWN ********************

-- Before proceeding, be sure to change the kernel to **Python** -> **Python** on the ribbon.

-- CELL ********************

import requests
import json
import sempy.fabric as fabric
from sempy.fabric import FabricRestClient
import struct
import itertools
import pyodbc
import base64
import uuid
import pandas as pd

-- METADATA ********************

-- META {
-- META   "language": "python",
-- META   "language_group": "jupyter_python"
-- META }

-- MARKDOWN ********************

-- **Check custom SQL pool configuration**

-- CELL ********************

# Get the current workspace ID
workspace_id = str(fabric.resolve_workspace_id()) 

# Use SemPy's Fabric REST client
client = FabricRestClient()

# Prepare the API endpoint to retrieve the SQL pools configuration for the workspace
response = client.get(
    f"/v1/workspaces/{workspace_id}/warehouses/sqlPoolsConfiguration?beta=true"
)

# If the request is successful, pretty-print the JSON response; otherwise, print the error text
if response.status_code == 200:
    print(json.dumps(response.json(), indent=4))
else:
    print(response.text)

-- METADATA ********************

-- META {
-- META   "language": "python",
-- META   "language_group": "jupyter_python"
-- META }

-- MARKDOWN ********************

-- **Configure custom SQL pools on the workspace**

-- CELL ********************

body = { 
  # Enable custom SQL pools
  "customSQLPoolsEnabled": True, 
  # Define custom SQL pools
  "customSQLPools": [ 
    { 
      "name": "ETL", 
      "isDefault": False, 
      "maxResourcePercentage": 50,         # Allocate up to 50% of resources to ETL
      "optimizeForReads": False, 
      "classifier": { 
        "type": "Application Name", 
        "value": [ 
          "ETL", 
          "Load", 
          "Pipeline"
        ] 
      } 
    }, 
    { 
      "name": "Reporting", 
      "isDefault": False, 
      "maxResourcePercentage": 45,         # Allocate up to 45% of resources to Reporting
      "optimizeForReads": False, 
      "classifier": { 
        "type": "Application Name", 
        "value": [ 
          "Reports" 
        ] 
      } 
    }, 
    { 
      "name": "Adhoc", 
      "isDefault": True,                   # Adhoc is the default pool
      "maxResourcePercentage": 5,          # Allocate up to 5% of resources to Adhoc requests
      "optimizeForReads": False, 
      "classifier": { 
        "type": "Application Name", 
        "value": [] 
      }
    } 
  ] 
}

# Retrieve the current workspace ID
workspace_id = str(fabric.resolve_workspace_id())

# Use SemPy's Fabric REST client
client = FabricRestClient()

# Construct the API endpoint for updating the SQL pools configuration in the workspace
response = client.patch(
    f"/v1/workspaces/{workspace_id}/warehouses/sqlPoolsConfiguration?beta=true",
    json=body
)

# Output the result: print a success message or the error text
if response.status_code == 200:
    print("SQL Custom Pools configured successfully.")
else:
    print(response.text)


-- METADATA ********************

-- META {
-- META   "language": "python",
-- META   "language_group": "jupyter_python"
-- META }

-- MARKDOWN ********************

-- **Sample queries**
-- 
-- Run a couple of sample queries and observe the behavior of the custom SQL pools through query insights in a few minutes. 

-- CELL ********************

# Get token using Python NotebookUtils
token = notebookutils.credentials.getToken("pbi")

# Get current workspace ID using SemPy
workspace_id = str(fabric.resolve_workspace_id())

# Get tenant ID from the token claims instead of spark.conf
payload = token.split(".")[1]
payload += "=" * (-len(payload) % 4)
claims = json.loads(base64.urlsafe_b64decode(payload))
tenant_id = claims["tid"]

# Build the Fabric SQL endpoint server name
tenant_part = base64.b32encode(uuid.UUID(tenant_id).bytes_le).decode("utf-8").lower().strip("=")
workspace_part = base64.b32encode(uuid.UUID(workspace_id).bytes_le).decode("utf-8").lower().strip("=")

sql_endpoint = f"{tenant_part}-{workspace_part}.datawarehouse.fabric.microsoft.com"

warehouse_name = "day_02_warehouse"

# Build Azure AD token structure for ODBC
value = bytes(token, "UTF-8")
encoded_bytes = bytes(itertools.chain.from_iterable(zip(value, itertools.repeat(0))))
tokenstruct = struct.pack("<i", len(encoded_bytes)) + encoded_bytes

# Build the connection string. Notice that no app name is included.
connection_string = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    f"SERVER={sql_endpoint};"
    f"Database={warehouse_name}"
)

# T-SQL query to aggregate customer revenue by year/month and compute year-to-date revenue
sql_query = """
select
    ps_partkey,
    sum(ps_supplycost * ps_availqty) as value
from
    partsupp,
    supplier,
    nation
where
    ps_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'CHINA'
group by
    ps_partkey having
        sum(ps_supplycost * ps_availqty) > (
            select
                sum(ps_supplycost * ps_availqty) * 0.0000003333
            from
                partsupp,
                supplier,
                nation
            where
                ps_suppkey = s_suppkey
                and s_nationkey = n_nationkey
                and n_name = 'CHINA'
        )
order by
    value desc
OPTION (LABEL = 'Custom SQL Pools - No application name')
"""

# Open ODBC connection using Azure AD token and execute the query, printing all results and any SQL messages
with pyodbc.connect(connection_string, attrs_before = { 1256:tokenstruct }) as conn:
    with conn.cursor() as cursor:
        cursor.execute(sql_query)
        rows = cursor.fetchall()
        # If there are rows, unpack each row (tuple) into a list for the DataFrame, else produce an empty DataFrame
        if rows:
            columns = [column[0] for column in cursor.description]
            records = [list(row) for row in rows]
            df = pd.DataFrame(records, columns=columns)
        else:
            df = pd.DataFrame()
        display(df)
    cursor.close()
conn.close()

# Build the connection string. Notice that no app name is "Reports".
connection_string = (
    f"DRIVER={{ODBC Driver 18 for SQL Server}};"
    f"SERVER={sql_endpoint};"
    f"Database={warehouse_name};"
    f"App=Reports"
)

# T-SQL query to aggregate customer revenue by year/month and compute year-to-date revenue
sql_query = """
select
    ps_partkey,
    sum(ps_supplycost * ps_availqty) as value
from
    partsupp,
    supplier,
    nation
where
    ps_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'CHINA'
group by
    ps_partkey having
        sum(ps_supplycost * ps_availqty) > (
            select
                sum(ps_supplycost * ps_availqty) * 0.0000003333
            from
                partsupp,
                supplier,
                nation
            where
                ps_suppkey = s_suppkey
                and s_nationkey = n_nationkey
                and n_name = 'CHINA'
        )
order by
    value desc
OPTION (LABEL = 'Custom SQL Pools - With application name "Reports"')
"""

# Open ODBC connection using Azure AD token and execute the query, printing all results and any SQL messages
with pyodbc.connect(connection_string, attrs_before = { 1256:tokenstruct }) as conn:
    with conn.cursor() as cursor:
        cursor.execute(sql_query)
        rows = cursor.fetchall()
        # If there are rows, unpack each row (tuple) into a list for the DataFrame, else produce an empty DataFrame
        if rows:
            columns = [column[0] for column in cursor.description]
            records = [list(row) for row in rows]
            df = pd.DataFrame(records, columns=columns)
        else:
            df = pd.DataFrame()
        display(df)
    cursor.close()
conn.close()

-- METADATA ********************

-- META {
-- META   "language": "python",
-- META   "language_group": "jupyter_python"
-- META }

-- MARKDOWN ********************

-- **Disabling custom SQL pools**
-- 
-- The following code sample could be used to reset the workspace back to the default split of SELECT/NONSELECT.
-- 
-- ```python
--   body = { 
--       # Disable custom SQL pools
--       "customSQLPoolsEnabled": False, 
--       # clear the configuration
--       "customSQLPools": [] 
--   } 
-- 
--   # Retrieve the current workspace ID
--   workspace_id = str(fabric.resolve_workspace_id())
-- 
--   # Use SemPy's Fabric REST client
--   client = FabricRestClient()
-- 
--   # Construct the API endpoint for updating the SQL pools configuration in the workspace
--   response = client.patch(
--       f"/v1/workspaces/{workspace_id}/warehouses/sqlPoolsConfiguration?beta=true",
--       json=body
--   )
-- 
--   # Output the result: print a success message or the error text
--   if response.status_code == 200:
--       print("SQL Custom Pools disabled.")
--   else:
--       print(response.text)
-- ```

-- MARKDOWN ********************

-- **We'll come back to this shortly**
-- 
-- For now, move on to the data clustering section while we wait for the queries to populate in query insights. Before proceeding, be sure to change the kernel to **T-SQL Analytics** -> **T-SQL** on the ribbon.

-- MARKDOWN ********************

-- #### 🗂️ Data clustering

-- MARKDOWN ********************

-- Next, let's explore how we can improve the performance of _Sample Query: 2_ using clustering. The tables were pre-populated during the _Lab setup_ section.
-- 
-- Since the data takes a little bit of time to make its way into query insights, run the cell below then move on to explore the code while we wait. 

-- CELL ********************

select top 10
    l_orderkey,
    sum(l_extendedprice * (1 - l_discount)) as revenue,
    o_orderdate,
    o_shippriority
from
    customer,
    orders,
    lineitem
where
    c_mktsegment = 'MACHINERY'
    and c_custkey = o_custkey
    and l_orderkey = o_orderkey
    and (o_orderdate > '1995-03-01' and o_orderdate <  '1995-03-30')
    and (l_shipdate >  '1995-03-01' and l_shipdate < '1995-03-30')
group by
    l_orderkey,
    o_orderdate,
    o_shippriority
order by
    revenue desc,
    o_orderdate
option (label = 'Tuning - Clustering: Disabled');

select top 10
    l_orderkey,
    sum(l_extendedprice * (1 - l_discount)) as revenue,
    o_orderdate,
    o_shippriority
from
    customer,
    orders,
    lineitem_clustered
where
    c_mktsegment = 'MACHINERY'
    and c_custkey = o_custkey
    and l_orderkey = o_orderkey
    and (o_orderdate > '1995-03-01' and o_orderdate <  '1995-03-30')
    and (l_shipdate >  '1995-03-01' and l_shipdate < '1995-03-30')
group by
    l_orderkey,
    o_orderdate,
    o_shippriority
order by
    revenue desc,
    o_orderdate
option (label = 'Tuning - Clustering: Enabled');


select top 10
    l_orderkey,
    sum(l_extendedprice * (1 - l_discount)) as revenue,
    o_orderdate,
    o_shippriority
from
    customer,
    orders,
    lineitem_clustered_bad
where
    c_mktsegment = 'MACHINERY'
    and c_custkey = o_custkey
    and l_orderkey = o_orderkey
    and (o_orderdate > '1995-03-01' and o_orderdate <  '1995-03-30')
    and (l_shipdate >  '1995-03-01' and l_shipdate < '1995-03-30')
group by
    l_orderkey,
    o_orderdate,
    o_shippriority
order by
    revenue desc,
    o_orderdate
option (label = 'Tuning - Clustering: Enabled - Bad');

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- **Setup and data loading**
-- 
-- We pre-populated 2 clustering tables: one aligned with the workload (lineitem_clustered) and one that is not (lineitem_clustered_bad). Other than the last line, WITH (CLUSTER BY (_colunn_name_here_)), there is no difference in the table definition.
-- 
-- ```sql
-- CREATE TABLE dbo.lineitem_clustered
--     (
--         l_orderkey          BIGINT          NOT NULL,
--         l_partkey           BIGINT          NOT NULL,
--         l_suppkey           BIGINT          NOT NULL,
--         l_linenumber        INT             NOT NULL,
--         l_quantity          DECIMAL(12, 2)  NOT NULL,
--         l_extendedprice     DECIMAL(12, 2)  NOT NULL,
--         l_discount          DECIMAL(12, 2)  NOT NULL,
--         l_tax               DECIMAL(12, 2)  NOT NULL,
--         l_returnflag        CHAR(1)         NOT NULL,
--         l_linestatus        CHAR(1)         NOT NULL,
--         l_shipdate          DATE            NOT NULL,
--         l_commitdate        DATE            NOT NULL,
--         l_receiptdate       DATE            NOT NULL,
--         l_shipinstruct      CHAR(25)        NOT NULL,
--         l_shipmode          CHAR(10)        NOT NULL,
--         l_comment           VARCHAR(44)     NOT NULL
--     )
-- WITH (CLUSTER BY (l_shipdate));
-- 
-- 
-- CREATE TABLE dbo.lineitem_clustered_bad
--     (
--         l_orderkey          BIGINT          NOT NULL,
--         l_partkey           BIGINT          NOT NULL,
--         l_suppkey           BIGINT          NOT NULL,
--         l_linenumber        INT             NOT NULL,
--         l_quantity          DECIMAL(12, 2)  NOT NULL,
--         l_extendedprice     DECIMAL(12, 2)  NOT NULL,
--         l_discount          DECIMAL(12, 2)  NOT NULL,
--         l_tax               DECIMAL(12, 2)  NOT NULL,
--         l_returnflag        CHAR(1)         NOT NULL,
--         l_linestatus        CHAR(1)         NOT NULL,
--         l_shipdate          DATE            NOT NULL,
--         l_commitdate        DATE            NOT NULL,
--         l_receiptdate       DATE            NOT NULL,
--         l_shipinstruct      CHAR(25)        NOT NULL,
--         l_shipmode          CHAR(10)        NOT NULL,
--         l_comment           VARCHAR(44)     NOT NULL
--     )
-- WITH (CLUSTER BY (l_linenumber));
-- ```
-- 
-- Loading these tables is also no different than loading any other table. The clustering magic all happens or you. 
-- 
-- ```sql
-- COPY INTO dbo.lineitem_clustered        FROM 'https://storageaccount.dfs.core.windows.net/container/lineitem/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - lineitem_clustered - COPY INTO');
-- COPY INTO dbo.lineitem_clustered_bad    FROM 'https://storageaccount.dfs.core.windows.net/container/lineitem/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - lineitem_clustered_bad - COPY INTO');
-- ```
-- 
-- There is a cost associated with loading a clustered table as this is a write-time optimization. Look at the cost difference between loading the non-clustered and clustered tables using query insights. Not only does it take longer to load the clustered tables it uses more CPU which in turn uses more of your Fabric capacity.


-- CELL ********************

SELECT
    UPPER(distributed_statement_id) AS distributed_statement_id,
    submit_time,
    start_time,
    end_time,
    DATEDIFF(SECOND, start_time, end_time) AS runtime_in_seconds,
    row_count,
    program_name,
    label,
    sql_pool_name,
    allocated_cpu_time_ms,
    data_scanned_remote_storage_mb + data_scanned_memory_mb + data_scanned_disk_mb AS total_data_scanned,
    data_scanned_remote_storage_mb,
    data_scanned_disk_mb,
    data_scanned_memory_mb,
    command
FROM queryinsights.exec_requests_history
WHERE
    status = 'Succeeded'
    AND (
        label IN ('Load - lineitem - COPY INTO', 'Load - lineitem_clustered - COPY INTO', 'Load - lineitem_clustered_bad - COPY INTO')
    )
ORDER BY
    allocated_cpu_time_ms

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- Using query insights, explore the query metrics from the various clustering configurations.

-- CELL ********************

SELECT
    UPPER(distributed_statement_id) AS distributed_statement_id,
    submit_time,
    start_time,
    end_time,
    DATEDIFF(SECOND, start_time, end_time) AS runtime_in_seconds,
    row_count,
    program_name,
    label,
    sql_pool_name,
    allocated_cpu_time_ms,
    data_scanned_remote_storage_mb + data_scanned_memory_mb + data_scanned_disk_mb AS total_data_scanned,
    data_scanned_remote_storage_mb,
    data_scanned_disk_mb,
    data_scanned_memory_mb,
    command
FROM queryinsights.exec_requests_history
WHERE
    status = 'Succeeded'
    AND (
        label IN ('Sample Query: 2', 'Tuning - Clustering: Disabled', 'Tuning - Clustering: Enabled', 'Tuning - Clustering: Enabled - Bad')
    )
ORDER BY
    allocated_cpu_time_ms

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- **Analyze the data**
-- 
-- How many times would you need to run Sample Query: 2 specifically to make up the additional CPU cost associated with loading the clustered version of the table?
-- 
-- What about on runtime rather than CPU?

-- MARKDOWN ********************

-- #### 🔍 Reviewing the impact of custom SQL pools
-- 
-- By this time our queries from the custom SQL pools section should be populated in query insights. Explore the results of the query below to see how the sample queries were routed with and without custom SQL pools. 

-- CELL ********************

SELECT
    UPPER(distributed_statement_id) AS distributed_statement_id,
    submit_time,
    start_time,
    end_time,
    DATEDIFF(SECOND, start_time, end_time) AS runtime_in_seconds,
    row_count,
    program_name,
    label,
    sql_pool_name,
    allocated_cpu_time_ms,
    data_scanned_remote_storage_mb + data_scanned_memory_mb + data_scanned_disk_mb AS total_data_scanned,
    data_scanned_remote_storage_mb,
    data_scanned_disk_mb,
    data_scanned_memory_mb,
    command
FROM queryinsights.exec_requests_history
WHERE
    status = 'Succeeded'
    AND (
        label IN ('Sample Query: 1', 'Custom SQL Pools - No application name', 'Custom SQL Pools - With application name "Reports"')
    )
ORDER BY
    allocated_cpu_time_ms

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- #### 💲 Collecting query consumption information

-- CELL ********************

-- Identify the window of time during which you'd like to explore query activity. 
DECLARE @window_start datetime2(7) = 'YYYY-MM-DD HH:MM:SS';
DECLARE @window_end   datetime2(7) = DATEADD(second, 30, @window_start);

SELECT
    UPPER(distributed_statement_id) AS distributed_statement_id,
    submit_time,
    start_time,
    end_time,
    DATEDIFF(SECOND, start_time, end_time) AS runtime_in_seconds,
    row_count,
    program_name,
    label,
    sql_pool_name,
    allocated_cpu_time_ms,
    data_scanned_remote_storage_mb + data_scanned_memory_mb + data_scanned_disk_mb AS total_data_scanned,
    data_scanned_remote_storage_mb,
    data_scanned_disk_mb,
    data_scanned_memory_mb,
    command
FROM queryinsights.exec_requests_history
WHERE
    start_time < @window_end
    AND end_time > @window_start
ORDER BY
    label,
    start_time;

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- # 🚀 SQL analytics endpoint

-- MARKDOWN ********************

-- The same SQL ending that powers the warehouse also powers the SQL analytics endpoint over lakehouses and database mirrors. For the lakehouse specifically there are a few considerations to be aware of. Primarily, metadata sync and Delta table file sizes. 

-- MARKDOWN ********************

-- #### 🔄️ Metadata Sync
-- 
-- The SQL analytics endpoint automatically detects the change and updates its SQL metadata via a background process. You can also manually refresh SQL analytics endpoint metadata via the Fabric portal, REST API, or T-SQL stored procedure.
-- 
-- In May 2026, the new metadata sync for the SQL analytics endpoint was announced as a preview feature. You can enable the new metadata sync process, which applies only to new SQL analytics endpoints. The new metadata sync option works to keep the data available for querying within seconds of it landing in the lakehouse.
-- 
-- When you enable the new metadata sync, new SQL analytics endpoints in the workspace sync faster when refreshing changes from underlying tables. **Currently, existing SQL analytics endpoints in that workspace remain on the legacy version of metadata sync.**
-- 
-- 
-- ##### Checking the status of a table
-- If you're using the new version of the metadata sync, you can use dynamic management views (DMVs) to get details about the most recent update to the SQL analytics endpoint. Use the sys.dm_db_external_tables_log_status DMV to get details about the latest metadata sync.
-- 
-- ```sql
-- SELECT * FROM sys.dm_db_external_tables_log_status;
-- ```
-- 
-- ##### Refreshing tables
-- 
-- Use the API only if you have schema changes, such as adding or deleting tables or columns, or changing types of columns, and need to refresh the entire item. For data-only changes in a SQL analytics endpoint, use the sys.sp_dw_refresh_ext_table system stored procedure to update a specific table.
-- 
-- ###### Stored Procedure
-- ```sql
-- EXEC sys.sp_dw_refresh_ext_table @tablename = "table_name"
-- ```
-- 
-- ###### API
-- ```python
-- import time
-- import sempy.fabric as fabric
-- from sempy.fabric import FabricRestClient
-- 
-- workspace_id = str(fabric.resolve_workspace_id())
-- client = FabricRestClient()
-- 
-- response = client.get(f"/v1/workspaces/{workspace_id}/sqlEndpoints")
-- response.raise_for_status()
-- 
-- sql_endpoints = response.json()["value"]
-- sql_endpoint_id = sql_endpoints[0]["id"]
-- 
-- payload = {
--     "timeout": {
--         "timeUnit": "Seconds",
--         "value": 60
--     }
-- }
-- 
-- response = client.post(
--     f"/v1/workspaces/{workspace_id}/sqlEndpoints/{sql_endpoint_id}/refreshMetadata",
--     json=payload
-- )
-- 
-- if response.status_code == 200:
--     status = response.json()["value"]
--     print("Refresh completed:")
--     for table in status:
--         print(table)
-- 
-- elif response.status_code == 202:
--     retry_after = int(response.headers.get("Retry-After", 5))
--     location = response.headers["Location"]
-- 
--     print("Refresh in progress...")
--     time.sleep(retry_after)
-- 
--     while True:
--         poll = client.get(location)
-- 
--         if poll.status_code == 200:
--             result = poll.json()["value"]
--             print("Refresh completed:")
--             for table in result:
--                 print(table)
--             break
-- 
--         poll.raise_for_status()
--         time.sleep(retry_after)
-- 
-- else:
--     response.raise_for_status()
-- ```


-- MARKDOWN ********************

-- #### 🎯 Optimizing lake file sizes

-- MARKDOWN ********************

-- When the SQL analytics endpoint reads tables stored in a lakehouse, query performance depends heavily on the physical layout of the underlying Parquet files.
-- 
-- A large number of small Parquet files creates overhead and negatively affects query performance. File size is equally important. The SQL analytics endpoint performs best when Parquet files are large enough to minimize file handling overhead but not so large that they limit parallel scan efficiency.
-- 
-- The code in this section will require a lakehouse that has tables in it and you need to change the references to your lakehouse name. This code is provided as an example only at this time.  
-- 
-- ##### Table Health Metrics
-- The sys.sp_get_table_health_metrics system stored procedure returns file-level storage health metrics for a Lakehouse table. The result set includes histogram distributions for file sizes, row counts, and deleted row counts, along with anomaly detection that identifies common storage conditions that degrade query performance.
-- 
-- ```sql
-- EXEC sp_get_table_health_metrics @table_name = 'table_name'
-- ```


-- MARKDOWN ********************

-- # 🔒 Securing your warehouse

-- MARKDOWN ********************

-- ❗ Head over to the warehouse settings and enable all events on the SQL audit logs page. 
-- 
-- After the audit is enabled, run a couple of sample queries to generate some activity to view in the log.

-- CELL ********************

select
    ps_partkey,
    sum(ps_supplycost * ps_availqty) as value
from
    partsupp,
    supplier,
    nation
where
    ps_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'CHINA'
group by
    ps_partkey having
        sum(ps_supplycost * ps_availqty) > (
            select
                sum(ps_supplycost * ps_availqty) * 0.0000003333
            from
                partsupp,
                supplier,
                nation
            where
                ps_suppkey = s_suppkey
                and s_nationkey = n_nationkey
                and n_name = 'CHINA'
        )
order by
    value desc
option (label = 'SQL Audit Query: 1');
GO


select top 100
    s_acctbal,
    s_name,
    n_name,
    p_partkey,
    p_mfgr,
    s_address,
    s_phone,
    s_comment
from
    part,
    supplier,
    partsupp,
    nation,
    region
where
    p_partkey = ps_partkey
    and s_suppkey = ps_suppkey
    and p_size = 38
    and p_type like '%TIN'
    and s_nationkey = n_nationkey
    and n_regionkey = r_regionkey
    and r_name = 'EUROPE'
    and ps_supplycost = (
        select
            min(ps_supplycost)
        from
            partsupp,
            supplier,
            nation,
            region
        where
            p_partkey = ps_partkey
            and s_suppkey = ps_suppkey
            and s_nationkey = n_nationkey
            and n_regionkey = r_regionkey
            and r_name = 'EUROPE'
    )
order by
    s_acctbal desc,
    n_name,
    s_name,
    p_partkey
option (label = 'SQL Audit Query: 2');
GO

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

SELECT
    al.action_id,
    aa.name AS action_name,
    al.event_time,
    al.server_principal_name,
    al.client_ip,
    al.application_name,
    al.statement
FROM sys.fn_get_audit_file_v2
    ('https://onelake.blob.fabric.microsoft.com/3f101a1f-34ab-4b8c-8249-32d5b6b9dfc3/d2554691-578f-4b93-be79-af6bcbe97f0f/Audit/sqldbauditlogs/', default, default, default, default) AS al
LEFT JOIN sys.dm_audit_actions AS aa ON al.action_id COLLATE Latin1_General_100_CI_AS_KS_WS_SC_UTF8 = aa.action_id
ORDER BY event_time DESC

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }
