CREATE TABLE [dbo].[nation] (

	[n_nationkey] int NOT NULL, 
	[n_name] char(25) NOT NULL, 
	[n_regionkey] int NOT NULL, 
	[n_comment] varchar(152) NOT NULL
);