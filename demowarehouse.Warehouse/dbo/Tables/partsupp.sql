CREATE TABLE [dbo].[partsupp] (

	[ps_partkey] bigint NOT NULL, 
	[ps_suppkey] bigint NOT NULL, 
	[ps_availqty] int NOT NULL, 
	[ps_supplycost] decimal(12,2) NOT NULL, 
	[ps_comment] varchar(199) NOT NULL
);