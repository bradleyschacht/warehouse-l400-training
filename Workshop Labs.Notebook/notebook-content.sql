-- Fabric notebook source

-- METADATA ********************

-- META {
-- META   "kernel_info": {
-- META     "name": "sqldatawarehouse"
-- META   },
-- META   "dependencies": {
-- META     "warehouse": {
-- META       "default_warehouse": "b9e4f7ae-a6a9-8dcd-4856-d0aa8df7e81a",
-- META       "known_warehouses": [
-- META         {
-- META           "id": "b9e4f7ae-a6a9-8dcd-4856-d0aa8df7e81a",
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


COPY INTO dbo.lineitem_clustered        FROM 'https://scbradlstorage01.dfs.core.windows.net/sampledata/TPC-H/GB_300/Delta_VOrder_Disabled/lineitem/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - lineitem_clustered - COPY INTO');
COPY INTO dbo.lineitem_clustered_bad    FROM 'https://scbradlstorage01.dfs.core.windows.net/sampledata/TPC-H/GB_300/Delta_VOrder_Disabled/lineitem/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - lineitem_clustered_bad - COPY INTO');
COPY INTO dbo.customer                  FROM 'https://scbradlstorage01.dfs.core.windows.net/sampledata/TPC-H/GB_300/Delta_VOrder_Disabled/customer/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - customer - COPY INTO');
COPY INTO dbo.nation                    FROM 'https://scbradlstorage01.dfs.core.windows.net/sampledata/TPC-H/GB_300/Delta_VOrder_Disabled/nation/*.parquet'     WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - nation - COPY INTO');
COPY INTO dbo.orders                    FROM 'https://scbradlstorage01.dfs.core.windows.net/sampledata/TPC-H/GB_300/Delta_VOrder_Disabled/orders/*.parquet'     WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - orders - COPY INTO');
COPY INTO dbo.part                      FROM 'https://scbradlstorage01.dfs.core.windows.net/sampledata/TPC-H/GB_300/Delta_VOrder_Disabled/part/*.parquet'       WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - part - COPY INTO');
COPY INTO dbo.partsupp                  FROM 'https://scbradlstorage01.dfs.core.windows.net/sampledata/TPC-H/GB_300/Delta_VOrder_Disabled/partsupp/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - partsupp - COPY INTO');
COPY INTO dbo.region                    FROM 'https://scbradlstorage01.dfs.core.windows.net/sampledata/TPC-H/GB_300/Delta_VOrder_Disabled/region/*.parquet'     WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - region - COPY INTO');
COPY INTO dbo.supplier                  FROM 'https://scbradlstorage01.dfs.core.windows.net/sampledata/TPC-H/GB_300/Delta_VOrder_Disabled/supplier/*.parquet'   WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - supplier - COPY INTO');


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


DECLARE @loops_to_run INT = 4
DECLARE @loop INT = 1

WHILE @loop <= @loops_to_run
BEGIN

    select
        l_returnflag,
        l_linestatus,
        sum(l_quantity) as sum_qty,
        sum(l_extendedprice) as sum_base_price,
        sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
        sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
        avg(l_quantity) as avg_qty,
        avg(l_extendedprice) as avg_price,
        avg(l_discount) as avg_disc,
    count_big(*) as count_order /* count(*) as count_order */
    from
        MyLakehouse.dbo.[lineitem_100_000010000]
    where
        l_shipdate <=  dateadd(day, -88, '1998-12-01') /*  l_shipdate <= date '1998-12-01' - interval '88' day (3)  */
    group by
        l_returnflag,
        l_linestatus
    order by
        l_returnflag,
        l_linestatus
    option (label = 'Lakehouse Optimization - lineitem_100_000010000');
    select
        l_returnflag,
        l_linestatus,
        sum(l_quantity) as sum_qty,
        sum(l_extendedprice) as sum_base_price,
        sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
        sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
        avg(l_quantity) as avg_qty,
        avg(l_extendedprice) as avg_price,
        avg(l_discount) as avg_disc,
    count_big(*) as count_order /* count(*) as count_order */
    from
        MyLakehouse.dbo.[lineitem_100_000050000]
    where
        l_shipdate <=  dateadd(day, -88, '1998-12-01') /*  l_shipdate <= date '1998-12-01' - interval '88' day (3)  */
    group by
        l_returnflag,
        l_linestatus
    order by
        l_returnflag,
        l_linestatus
    option (label = 'Lakehouse Optimization - lineitem_100_000050000');
    select
        l_returnflag,
        l_linestatus,
        sum(l_quantity) as sum_qty,
        sum(l_extendedprice) as sum_base_price,
        sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
        sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
        avg(l_quantity) as avg_qty,
        avg(l_extendedprice) as avg_price,
        avg(l_discount) as avg_disc,
    count_big(*) as count_order /* count(*) as count_order */
    from
        MyLakehouse.dbo.[lineitem_100_002000000]
    where
        l_shipdate <=  dateadd(day, -88, '1998-12-01') /*  l_shipdate <= date '1998-12-01' - interval '88' day (3)  */
    group by
        l_returnflag,
        l_linestatus
    order by
        l_returnflag,
        l_linestatus
    option (label = 'Lakehouse Optimization - lineitem_100_002000000');
    select
        l_returnflag,
        l_linestatus,
        sum(l_quantity) as sum_qty,
        sum(l_extendedprice) as sum_base_price,
        sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
        sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
        avg(l_quantity) as avg_qty,
        avg(l_extendedprice) as avg_price,
        avg(l_discount) as avg_disc,
    count_big(*) as count_order /* count(*) as count_order */
    from
        MyLakehouse.dbo.[lineitem_100_010000000]
    where
        l_shipdate <=  dateadd(day, -88, '1998-12-01') /*  l_shipdate <= date '1998-12-01' - interval '88' day (3)  */
    group by
        l_returnflag,
        l_linestatus
    order by
        l_returnflag,
        l_linestatus
    option (label = 'Lakehouse Optimization - lineitem_100_010000000');
    select
        l_returnflag,
        l_linestatus,
        sum(l_quantity) as sum_qty,
        sum(l_extendedprice) as sum_base_price,
        sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
        sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
        avg(l_quantity) as avg_qty,
        avg(l_extendedprice) as avg_price,
        avg(l_discount) as avg_disc,
    count_big(*) as count_order /* count(*) as count_order */
    from
        MyLakehouse.dbo.[lineitem_100_default]
    where
        l_shipdate <=  dateadd(day, -88, '1998-12-01') /*  l_shipdate <= date '1998-12-01' - interval '88' day (3)  */
    group by
        l_returnflag,
        l_linestatus
    order by
        l_returnflag,
        l_linestatus
    option (label = 'Lakehouse Optimization - lineitem_100_default');

SET @Loop = @Loop + 1
END

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- # 🚚 Data ingestion

-- CELL ********************

TRUNCATE TABLE dbo.lineitem;
COPY INTO dbo.lineitem FROM 'https://scbradlstorage01.dfs.core.windows.net/sampledata/TPC-H/GB_300/Delta_VOrder_Disabled/lineitem/*.parquet' WITH (FILE_TYPE = 'PARQUET') OPTION (LABEL = 'Load - lineitem - COPY INTO');

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
FROM OPENROWSET(BULK 'https://scbradlstorage01.dfs.core.windows.net/sampledata/TPC-H/GB_300/Delta_VOrder_Disabled/lineitem/*.parquet')
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
-- ❗ Begin by creating a snapshot of the data warehouse. To do this, navigate back to the workspace item list, open the warehouse, and go to manage snapshots on the ribbon. 

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

-- Try time travel.

DECLARE @BeforeTheAccident VARCHAR(23) = (SELECT CONVERT(VARCHAR(23), DATEADD(MINUTE, -5, GETDATE()), 126))
EXEC ('SELECT COUNT(*) FROM dbo.nation OPTION (FOR TIMESTAMP AS OF ''' + @BeforeTheAccident + ''')');

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

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

-- First, let's break up the compute and make sure our large ETL processesa and reporting have enough resources to complete in their allotted amount of time using custom SQL pools. This can be done through code or through the workspace settings. 

-- MARKDOWN ********************

-- #### ➗ Custom SQL Pools

-- MARKDOWN ********************

-- Before proceeding, be sure to change the kernel to **Spark** -> **PySpark (Python)** on the ribbon.

-- CELL ********************

import requests
import json
from notebookutils import mssparkutils
import struct
import itertools
import pyodbc
import base64
import uuid
import pandas as pd

-- METADATA ********************

-- META {
-- META   "language": "python",
-- META   "language_group": "synapse_pyspark"
-- META }

-- MARKDOWN ********************

-- **Check custom SQL pool configuration**

-- CELL ********************

# Get the current workspace ID from the runtime context
workspace_id = mssparkutils.runtime.context.get('currentWorkspaceId') 

# Prepare the API endpoint to retrieve the SQL pools configuration for the workspace
url = f'https://api.fabric.microsoft.com/v1/workspaces/{workspace_id}/warehouses/sqlPoolsConfiguration'
response = requests.request(method='get', url=url, headers={'Authorization': f'Bearer {mssparkutils.credentials.getToken("pbi")}'})

# If the request is successful, pretty-print the JSON response; otherwise, print the error text
if response.status_code == 200:
    print(json.dumps(response.json(), indent=4))
else:
    print(response.text)

-- METADATA ********************

-- META {
-- META   "language": "python",
-- META   "language_group": "synapse_pyspark"
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

# Retrieve the current workspace ID from the Spark runtime context
workspace_id = mssparkutils.runtime.context.get('currentWorkspaceId') 

# Construct the API endpoint for updating the SQL pools configuration in the workspace
url = f'https://api.fabric.microsoft.com/v1/workspaces/{workspace_id}/warehouses/sqlPoolsConfiguration'
response = requests.request(method='patch', url=url, json=body, headers={'Authorization': f'Bearer {notebookutils.credentials.getToken("pbi")}'})

# Output the result: print a success message or the error text
if response.status_code == 200:
    print("SQL Custom Pools configured successfully.")
else:
    print(response.text)


-- METADATA ********************

-- META {
-- META   "language": "python",
-- META   "language_group": "synapse_pyspark"
-- META }

-- MARKDOWN ********************

-- **Sample queries**
-- 
-- Run a couple of sample queries and observe the behavior of the custom SQL pools through query insights in a few minutes. 

-- CELL ********************

# Retrieve the current workspace and tenant IDs from Spark runtime context and Spark configuration
workspace_id = mssparkutils.runtime.context.get('currentWorkspaceId') 
tenant_id = spark.conf.get('trident.tenant.id')

# Build the server name for the warehouse/sql endpoint
sql_endpoint=f'''{base64.b32encode(uuid.UUID(tenant_id).bytes_le).decode("utf-8").lower().strip("=")}-{base64.b32encode(uuid.UUID(workspace_id).bytes_le).decode("utf-8").lower().strip("=")}.datawarehouse.fabric.microsoft.com'''

warehouse_name='MyWarehouse'

token = mssparkutils.credentials.getToken("pbi")

# Convert the token to bytes and interleave with zeros to build Azure AD token structure for ODBC
value = bytes(token, "UTF-8")
encoded_bytes = bytes(itertools.chain.from_iterable(zip(value, itertools.repeat(0))))
tokenstruct = struct.pack("<i", len(encoded_bytes)) + encoded_bytes

# Build the ODBC connection string for SQL Server driver (Windows authentication and database selection)
connection_string = (
    f"DRIVER={{ODBC Driver 18 for SQL Server}};"
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










# Build the ODBC connection string for SQL Server driver (Windows authentication and database selection)
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
-- META   "language_group": "synapse_pyspark"
-- META }

-- MARKDOWN ********************

-- **Disabling custom SQL pools**
-- 
-- The following code sample could be used to reset the workspace back to the default split of SELECT/NONSELECT.
-- 
-- ```python
--     body = { 
--       # Disable custom SQL pools
--       "customSQLPoolsEnabled": False, 
--       # clear the configuration
--       "customSQLPools": [] 
--     } 
-- 
--     # Get the current workspace ID from the runtime context
--     workspace_id = mssparkutils.runtime.context.get('currentWorkspaceId') 
-- 
--     # Prepare the API endpoint to retrieve the SQL pools configuration for the workspace
--     url = f'https://api.fabric.microsoft.com/v1/workspaces/{workspace_id}/warehouses/sqlPoolsConfiguration'
--     response = requests.request(method='get', url=url, headers={'Authorization': f'Bearer {mssparkutils.credentials.getToken("pbi")}'})
-- 
--     # If the request is successful, print a success note; otherwise, print the error text
--     if response.status_code == 200:
--         print("SQL Custom Pools disabled.")
--     else:
--         print(response.text)
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

-- Using query insights, explore the time and cost savings from the various clustering configurations.

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

-- #### 💲 Collecting query cost information

-- CELL ********************

-- Get the list of distributed statement ids to look up
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
    label


-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- Take a distributed_statement_id to look up in the timepoint detail of the capacity metrics report or use real-time events.

-- MARKDOWN ********************

-- # 🚀 SQL analytics endpoint

-- MARKDOWN ********************

-- The same SQL ending that powers the warehouse also powers the SQL analytics endpoint over lakehouses and database mirrors. For the lakehouse specifically there are a few considerations to be aware of. Primarily, metadata sync and Delta table file sizes. 

-- MARKDOWN ********************

-- #### 🔄️ Metadata Sync

-- MARKDOWN ********************

-- Before proceeding, be sure to change the kernel to **Spark** -> **PySpark (Python)** on the ribbon.

-- CELL ********************

import requests
import json
from notebookutils import mssparkutils
import requests
import time

workspace_id = mssparkutils.runtime.context.get('currentWorkspaceId') 

url = f'https://api.fabric.microsoft.com/v1/workspaces/{workspace_id}/sqlEndpoints'
response = requests.request(method='get', url=url, headers={'Authorization': f'Bearer {mssparkutils.credentials.getToken("pbi")}'})

sql_endpoint_id = response.json()["value"][0]["id"]

fabric_api = "https://api.fabric.microsoft.com/v1"
access_token = mssparkutils.credentials.getToken("pbi")

headers = {
    "Authorization": f"Bearer {access_token}",
    "Content-Type": "application/json"
}

# Optional payload
payload = {
    "timeout": {
        "timeUnit": "Seconds",
        "value": 60
    }
}

response = requests.post(
    f"{fabric_api}/workspaces/{workspace_id}/sqlEndpoints/{sql_endpoint_id}/refreshMetadata",
    headers=headers,
    json=payload
)

# ✅ Synchronous completion
if response.status_code == 200:
    status = response.json()["value"]
    print("✅ Refresh completed:")
    for table in status:
        print(table)

# ✅ Asynchronous (LRO)
elif response.status_code == 202:
    operation_id = response.headers["x-ms-operation-id"]
    retry_after = int(response.headers.get("Retry-After", 5))
    location = response.headers["Location"]

    print("🔄️ Refresh in progress...")
    time.sleep(retry_after)

    # Poll LRO status
    while True:
        poll = requests.get(location, headers=headers)
        if poll.status_code == 200:
            result = poll.json()["value"]
            print("✅ Refresh completed:")
            for table in result:
                print(table)
            break
        time.sleep(retry_after)

else:
    response.raise_for_status()

-- METADATA ********************

-- META {
-- META   "language": "python",
-- META   "language_group": "synapse_pyspark"
-- META }

-- MARKDOWN ********************

-- Before proceeding, be sure to change the kernel to **T-SQL Analytics** -> **T-SQL** on the ribbon.

-- MARKDOWN ********************

-- #### 🎯 Optimizing lake file sizes

-- CELL ********************

SELECT
    COUNT(*) AS run_count,
    FORMAT(
        CASE
            WHEN CHARINDEX('default', label, 0) > 0 THEN 0
            ELSE CONVERT(INT, SUBSTRING(label, 39, 9))
        END, '#,###'
    ) AS rows_per_file,
    label,
    FORMAT(AVG(DATEDIFF(MILLISECOND, start_time, end_time))/1000., '#,###.#') AS avg_runtime,
    FORMAT(MIN(DATEDIFF(MILLISECOND, start_time, end_time))/1000., '#,###.#') AS min_runtime,
    FORMAT(MAX(DATEDIFF(MILLISECOND, start_time, end_time))/1000., '#,###.#') AS max_runtime,
    AVG(data_scanned_remote_storage_mb + data_scanned_memory_mb + data_scanned_disk_mb) AS avg_data_scanned,
    FORMAT(AVG(allocated_cpu_time_ms), '#,###') AS avg_cpu_time_ms
FROM day_01_lakehouse.queryinsights.exec_requests_history
-- WHERE 
--     label IN ('Lakehouse Optimization - lineitem_100_000010000', 'Lakehouse Optimization - lineitem_100_000050000')    
GROUP BY label
ORDER BY AVG(DATEDIFF(MILLISECOND, start_time, end_time))/1000.

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- **How do optimize file sizes**
-- 
-- These limits can be set before writing data or before running an OPTIMIZE command to improve performance of existing tables written with sub-optimal file sizes. 
-- 
-- ```python
--     from delta.tables import DeltaTable
-- 
--     # Set the maximum number of records per file to 2 million rows during writes.
--     spark.conf.set("spark.sql.files.maxRecordsPerFile", 2000000)
-- 
--     # Set the maximum file size to approximately 4GB
--     spark.conf.set("spark.databricks.delta.optimize.maxFileSize", 400 * 1024 * 1024 * 1024)
-- 
--     # Run OPTIMIZE on existing tables.
--     spark.sql("OPTIMIZE myTable")
-- ```
-- 
-- Now, compare the optimized table performance to the non-optimized. 

-- CELL ********************

SELECT
    COUNT(*) AS run_count,
    FORMAT(
        CASE
            WHEN CHARINDEX('default', label, 0) > 0 THEN 0
            ELSE CONVERT(INT, SUBSTRING(label, 39, 9))
        END, '#,###'
    ) AS rows_per_file,
    label,
    FORMAT(AVG(DATEDIFF(MILLISECOND, start_time, end_time))/1000., '#,###.#') AS avg_runtime,
    FORMAT(MIN(DATEDIFF(MILLISECOND, start_time, end_time))/1000., '#,###.#') AS min_runtime,
    FORMAT(MAX(DATEDIFF(MILLISECOND, start_time, end_time))/1000., '#,###.#') AS max_runtime,
    AVG(data_scanned_remote_storage_mb + data_scanned_memory_mb + data_scanned_disk_mb) AS avg_data_scanned,
    FORMAT(AVG(allocated_cpu_time_ms), '#,###') AS avg_cpu_time_ms
FROM day_01_lakehouse.queryinsights.exec_requests_history
WHERE 
    label IN ('Lakehouse Optimization - lineitem_100_000010000', 'Lakehouse Optimization - lineitem_100_000050000', 'Lakehouse Optimization - lineitem_100_default', 'Lakehouse Optimization - lineitem_100_002000000', 'Lakehouse Optimization - lineitem_100_010000000')
GROUP BY label
ORDER BY AVG(DATEDIFF(MILLISECOND, start_time, end_time))/1000.

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

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

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- MARKDOWN ********************

-- Be sure to set the workspace and warehouse ids in the query below before running it.

-- CELL ********************

DECLARE @workspace_id VARCHAR(36) = ''
DECLARE @warehouse_id VARCHAR(36) = ''

EXEC('
SELECT
    al.action_id,
    aa.name AS action_name,
    al.event_time,
    al.server_principal_name,
    al.client_ip,
    al.application_name,
    al.statement
FROM sys.fn_get_audit_file_v2
    (''https://onelake.blob.fabric.microsoft.com/' + @workspace_id + '/' + @warehouse_id + '/Audit/sqldbauditlogs/'', default, default, default, default) AS al
LEFT JOIN sys.dm_audit_actions AS aa ON al.action_id COLLATE Latin1_General_100_CI_AS_KS_WS_SC_UTF8 = aa.action_id
ORDER BY event_time DESC
')

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }
