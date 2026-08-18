CREATE TABLE [dbo].[supplier] (

	[s_suppkey] bigint NOT NULL, 
	[s_name] char(25) NOT NULL, 
	[s_address] varchar(40) NOT NULL, 
	[s_nationkey] int NOT NULL, 
	[s_phone] char(15) NOT NULL, 
	[s_acctbal] decimal(12,2) NOT NULL, 
	[s_comment] varchar(101) NOT NULL
);