CREATE TABLE [dbo].[customer] (

	[c_custkey] bigint NOT NULL, 
	[c_name] varchar(25) NOT NULL, 
	[c_address] varchar(40) NOT NULL, 
	[c_nationkey] int NOT NULL, 
	[c_phone] char(15) NOT NULL, 
	[c_acctbal] decimal(12,2) NOT NULL, 
	[c_mktsegment] char(10) NOT NULL, 
	[c_comment] varchar(117) NOT NULL
);