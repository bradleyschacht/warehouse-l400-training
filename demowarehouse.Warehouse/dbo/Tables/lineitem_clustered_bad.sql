CREATE TABLE [dbo].[lineitem_clustered_bad] (

	[l_orderkey] bigint NOT NULL, 
	[l_partkey] bigint NOT NULL, 
	[l_suppkey] bigint NOT NULL, 
	[l_linenumber] int NOT NULL, 
	[l_quantity] decimal(12,2) NOT NULL, 
	[l_extendedprice] decimal(12,2) NOT NULL, 
	[l_discount] decimal(12,2) NOT NULL, 
	[l_tax] decimal(12,2) NOT NULL, 
	[l_returnflag] char(1) NOT NULL, 
	[l_linestatus] char(1) NOT NULL, 
	[l_shipdate] date NOT NULL, 
	[l_commitdate] date NOT NULL, 
	[l_receiptdate] date NOT NULL, 
	[l_shipinstruct] char(25) NOT NULL, 
	[l_shipmode] char(10) NOT NULL, 
	[l_comment] varchar(44) NOT NULL
)
 WITH (CLUSTER BY([l_linenumber]));