CREATE TABLE [dbo].[part] (

	[p_partkey] bigint NOT NULL, 
	[p_name] varchar(55) NOT NULL, 
	[p_mfgr] char(25) NOT NULL, 
	[p_brand] char(10) NOT NULL, 
	[p_type] varchar(25) NOT NULL, 
	[p_size] int NOT NULL, 
	[p_container] char(10) NOT NULL, 
	[p_retailprice] decimal(12,2) NOT NULL, 
	[p_comment] varchar(23) NOT NULL
);