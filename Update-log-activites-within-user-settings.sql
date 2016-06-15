USE [YOUR DB NAME]
GO

-- Check the number of the users you are looking to perform the change e.g. MMT Digital and Kentico email addresses
SELECT
  [UserID],
  [FullName],
  [Email],
  [UserIsGlobalAdministrator]
FROM [dbo].[CMS_User]
WHERE [Email] LIKE '%@mmtdigital%'
OR [Email] LIKE '%@kentico%'
GO

-- Identify what columns you may require to be shown/used
SELECT
  [UserSettingsID],
  [UserSettingsUserID],
  [UserLogActivities]
FROM [dbo].[CMS_UserSettings]
GO

--  Combine two tables (CMS_User and CMS_UserSettings) together to show you list of all users with the User Setting for Log activities
SELECT
  u.[UserID],
  s.[UserSettingsUserID],
  u.[FullName],
  u.[Email],
  s.[UserLogActivities]
FROM [dbo].[CMS_User] u
INNER JOIN [dbo].[CMS_UserSettings] s
  ON u.[UserID] = s.[UserSettingsUserID]
WHERE u.[Email] LIKE '%@mmtdigital%'
OR [Email] LIKE '%@kentico%'
ORDER BY u.[UserID] ASC

-- Change the User Setting for Log activities for the users to be set to false
BEGIN TRAN Live
UPDATE s
SET s.[UserLogActivities] = 0
FROM [dbo].[CMS_UserSettings] s
INNER JOIN [dbo].[CMS_User] u
  ON u.[UserID] = s.[UserSettingsUserID]
WHERE u.[Email] LIKE '%@mmtdigital%'
OR u.[Email] LIKE '%@kentico%'
COMMIT TRAN Live
