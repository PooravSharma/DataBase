﻿/*
Deployment script for A3frontend

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "A3frontend"
:setvar DefaultFilePrefix "A3frontend"
:setvar DefaultDataPath "C:\Users\30045900\AppData\Local\Microsoft\VisualStudio\SSDT\A3frontend"
:setvar DefaultLogPath "C:\Users\30045900\AppData\Local\Microsoft\VisualStudio\SSDT\A3frontend"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creating Table [dbo].[CustomerDetail]...';


GO
CREATE TABLE [dbo].[CustomerDetail] (
    [CustomerNo]    INT           IDENTITY (1, 1) NOT NULL,
    [Name]          NVARCHAR (50) NOT NULL,
    [StreetAddress] NVARCHAR (50) NOT NULL,
    [City]          NVARCHAR (50) NOT NULL,
    [State]         NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([CustomerNo] ASC)
);


GO
PRINT N'Creating Table [dbo].[InvoiceItems]...';


GO
CREATE TABLE [dbo].[InvoiceItems] (
    [Invoice]       INT NOT NULL,
    [Item_ID]       INT NOT NULL,
    [Item_Quantity] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Invoice] ASC, [Item_ID] ASC)
);


GO
PRINT N'Creating Table [dbo].[InvoiceTable]...';


GO
CREATE TABLE [dbo].[InvoiceTable] (
    [Invoice]      INT  IDENTITY (1, 1) NOT NULL,
    [Invoice_Date] DATE NOT NULL,
    [CustomerNo]   INT  NOT NULL,
    PRIMARY KEY CLUSTERED ([Invoice] ASC)
);


GO
PRINT N'Creating Table [dbo].[ItemDetail]...';


GO
CREATE TABLE [dbo].[ItemDetail] (
    [Item_ID]          INT             IDENTITY (1, 1) NOT NULL,
    [Item_Description] NVARCHAR (50)   NOT NULL,
    [Item_Price]       DECIMAL (15, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Item_ID] ASC)
);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Invoice]...';


GO
ALTER TABLE [dbo].[InvoiceItems] WITH NOCHECK
    ADD CONSTRAINT [FK_Invoice] FOREIGN KEY ([Invoice]) REFERENCES [dbo].[InvoiceTable] ([Invoice]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Item_ID]...';


GO
ALTER TABLE [dbo].[InvoiceItems] WITH NOCHECK
    ADD CONSTRAINT [FK_Item_ID] FOREIGN KEY ([Item_ID]) REFERENCES [dbo].[ItemDetail] ([Item_ID]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[InvoiceTable]...';


GO
ALTER TABLE [dbo].[InvoiceTable] WITH NOCHECK
    ADD FOREIGN KEY ([CustomerNo]) REFERENCES [dbo].[CustomerDetail] ([CustomerNo]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[InvoiceItems] WITH CHECK CHECK CONSTRAINT [FK_Invoice];

ALTER TABLE [dbo].[InvoiceItems] WITH CHECK CHECK CONSTRAINT [FK_Item_ID];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.InvoiceTable'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Checking constraint: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Constraint verification failed:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occurred while verifying constraints', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Update complete.';


GO
