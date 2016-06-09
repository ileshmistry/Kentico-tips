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

SELECT
  [UserSettingsID],
  [UserSettingsUserID],
  [UserLogActivities]
FROM [dbo].[CMS_UserSettings]
GO

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

SELECT
  u.[UserID],
  s.[UserSettingsUserID],
  u.[FullName],
  u.[Email],
  s.[UserLogActivities]
FROM [dbo].[CMS_User] u
INNER JOIN [dbo].[CMS_UserSettings] s
  ON u.[UserID] = s.[UserSettingsUserID]
ORDER BY u.[UserID] ASC

BEGIN TRAN Live
UPDATE s
SET s.[UserLogActivities] = 0
FROM [dbo].[CMS_UserSettings] s
INNER JOIN [dbo].[CMS_User] u
  ON u.[UserID] = s.[UserSettingsUserID]
WHERE u.[Email] LIKE '%@mmtdigital%'
OR u.[Email] LIKE '%@christie%'
COMMIT TRAN Live
