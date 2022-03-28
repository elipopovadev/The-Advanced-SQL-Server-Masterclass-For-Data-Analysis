USE [AdventureWorks2019]
GO


/* Exercise 1
Create a stored procedure called "NameSearch" that allows users to search the Person.Person table for a pattern provided by the user.
The user should be able to search by either first name, last name, or middle name.
You can return all columns from the table; that is to say, feel free to user SELECT *.
The stored procedure should take two arguments:
@NameToSearch: The user will be expected to enter either "first", "middle", or "last". This way, they do not have to remember exact column names.
@SearchPattern: The user will provide a text string to search for. */

CREATE or ALTER PROCEDURE dbo.NameSearch(@NameToSearch VARCHAR(100), @SearchPattern VARCHAR(100))
AS
BEGIN
		DECLARE @DynamicVariable VARCHAR(MAX)
		SET @DynamicVariable = 'SELECT * FROM Person.Person 
		where '
		SET @DynamicVariable = @DynamicVariable + ' ' + @NameToSearch + 'Name'
		SET @DynamicVariable = @DynamicVariable + ' LIKE ' + '''' + '%' +  @SearchPattern + '%' + ''''
		EXEC(@DynamicVariable)
END

dbo.NameSearch 'FIRST', 'KEN'
dbo.NameSearch 'MIDDLE', 'T'
dbo.NameSearch 'LAST', 'SHE'


/* Exercise 2
Modify your "NameSearch" procedure to accept a third argument - @MatchType, with an INT datatype -  that specifies the match type:
    1 means "exact match"
    2 means "begins with"
    3 means "ends with"
    4 means "contains" */

CREATE or ALTER PROCEDURE dbo.NameSearch(@NameToSearch VARCHAR(100), @SearchPattern VARCHAR(100), @MatchType INT)
AS
BEGIN

	DECLARE @DynamicVariable VARCHAR(MAX)
	SET @DynamicVariable = 'SELECT * FROM Person.Person 
	where '
	SET @DynamicVariable = @DynamicVariable + ' ' + @NameToSearch + 'Name'
			IF  @MatchType = 1
				SET @DynamicVariable = @DynamicVariable + ' LIKE ' + '''' + @SearchPattern + ''''
			ELSE IF @MatchType = 2
				SET @DynamicVariable = @DynamicVariable + ' LIKE ' + '''' + @SearchPattern + '%' + ''''
			ELSE IF @MatchType = 3
				SET @DynamicVariable = @DynamicVariable + ' LIKE ' + '''' + '%' + @SearchPattern + ''''
			ELSE IF @MatchType = 4
				SET @DynamicVariable = @DynamicVariable + ' LIKE ' + '''' + '%' +  @SearchPattern + '%' + ''''
    EXEC(@DynamicVariable)
END

dbo.NameSearch 'FIRST', 'KEN', 1
dbo.NameSearch 'MIDDLE', 'T', 2
dbo.NameSearch 'LAST', 'HE', 3
dbo.NameSearch 'FIRST', 'KEN', 4

