CREATE TABLE [dbo].[orders] (

	[o_orderkey] bigint NOT NULL, 
	[o_custkey] bigint NOT NULL, 
	[o_orderstatus] char(1) NOT NULL, 
	[o_totalprice] decimal(12,2) NOT NULL, 
	[o_orderdate] date NOT NULL, 
	[o_orderpriority] char(15) NOT NULL, 
	[o_clerk] char(15) NOT NULL, 
	[o_shippriority] int NOT NULL, 
	[o_comment] varchar(79) NOT NULL
);