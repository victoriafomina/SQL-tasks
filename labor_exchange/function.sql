USE [labor_exchange]
GO
/****** Object:  UserDefinedFunction [dbo].[VacanciesForPosition]    Script Date: 10.06.2020 18:38:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION dbo.VacanciesForPosition(@position NVARCHAR(30)) 
RETURNS @result_table TABLE(education NVARCHAR(30), salary INT, company NVARCHAR(30), insurance INT) 
AS
BEGIN
    INSERT INTO @result_table 
	SELECT education, salary, company, insurance FROM vacancy GROUP BY SALARY;
	return;
END
