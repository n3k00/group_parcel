abstract final class AppStrings {
  static const appName = 'Group Parcel';
  static const appTagline = 'Counter operations';
  static const settingsAction = 'Settings';
  static const settingsTitle = 'Settings';
  static const appVersionTitle = 'App Version';

  static const profileTitle = 'Profile';
  static const profileSubtitle =
      'Edit account code and future profile settings.';
  static const fromTownTitle = 'From Town';
  static const fromTownSubtitle =
      'Choose the default source town for the form.';
  static const voucherHeaderTitle = 'Receipt Header';
  static const voucherHeaderSubtitle =
      'Edit the subtitle, address, and phone shown on the receipt header.';
  static const receiptSettingsTitle = 'Receipt Settings';
  static const receiptSettingsSubtitle =
      'Live preview, font size, and receipt padding controls.';
  static const toTownTitle = 'To Town';
  static const toTownSubtitle = 'Add or remove destination towns.';
  static const printerSettingsTitle = 'Printer Settings';
  static const printerSettingsSubtitle =
      'Choose the printer preset used for receipt output.';
  static const backupRestoreTitle = 'Backup and Restore';
  static const backupRestoreSubtitle =
      'Manage local offline data backup and restore tools.';
  static const fullBackupTitle = 'Full Backup';
  static const fullBackupSubtitle =
      'Create a zip backup with the SQLite database and parcel images.';
  static const lightBackupTitle = 'Light Backup';
  static const lightBackupSubtitle =
      'Create a backup that includes the SQLite database only.';
  static const restoreBackupTitle = 'Restore Backup';
  static const restoreBackupSubtitle =
      'Restore parcel data from a light backup or a full zip backup.';
  static const noBackupFilesFound =
      'No backup files were found in the Group Parcel Backups folder.';
  static const chooseBackupFileTitle = 'Choose Backup File';
  static const chooseBackupFileSubtitle =
      'Select a saved .zip or database backup file to restore.';
  static const browseDevice = 'Browse Device';
  static const backupFoldersEmpty =
      'No backup files were found in the default backup folders.';
  static const backupPermissionBlocked =
      'Storage permission is blocked. Open Android settings and allow file access first.';
  static const selectBackupTool = 'Select a backup tool.';
  static const creatingFullBackup = 'Creating full backup...';
  static const creatingLightBackup = 'Creating light backup...';
  static const restoringBackup = 'Restoring backup...';
  static const restoreWarning =
      'This will replace the current local parcel database.';
  static const fullBackupCreated = 'Full backup created successfully.';
  static const lightBackupCreated = 'Light backup created successfully.';
  static const databaseRestored = 'Database restored successfully.';
  static const backupRestored = 'Backup restored successfully.';
  static const backupFileMissing = 'Selected backup file could not be found.';
  static const unsupportedBackupFormat = 'Unsupported backup format.';
  static const backupMissingDatabase =
      'The selected backup is missing the database file.';

  static const headerFontSizeTitle = 'Header Font Size';
  static const bodyFontSizeTitle = 'Body Font Size';
  static const receiptPaddingTitle = 'Receipt Padding';
  static const livePreviewTitle = 'Live Preview';
  static const saveReceiptSettings = 'Save Receipt Settings';
  static const receiptSettingsSaved = 'Receipt settings saved.';

  static const titleLabel = 'Title';
  static const subtitleLabel = 'Subtitle';
  static const addressLabel = 'Address';
  static const phoneLabel = 'Phone';
  static const phoneNumbersLabel = 'Phone Numbers';
  static const labelLabel = 'Label';
  static const valueLabel = 'Value';
  static const topLabel = 'Top';
  static const horizontalLabel = 'Horizontal';
  static const bottomLabel = 'Bottom';

  static const voucherHeaderSaved = 'Receipt header settings saved.';
  static const saveChanges = 'Save Changes';
  static const requiredField = 'Required.';
  static const accountCodeLabel = 'Account Code';
  static const profileSaved = 'Profile settings saved.';

  static const noSourceTowns = 'No source towns available.';
  static const defaultFromTownUpdated = 'Default from town updated.';
  static const newDestinationTownLabel = 'New destination town';
  static const addAction = 'Add';
  static const deleteToTownTitle = 'Delete To Town';
  static const cancelAction = 'Cancel';
  static const deleteAction = 'Delete';

  static const printerPresetLight = 'Light';
  static const printerPresetLightSubtitle =
      'Lighter print density for thin paper or sharp black text.';
  static const printerPresetBalanced = 'Balanced';
  static const printerPresetBalancedSubtitle =
      'Recommended default for most receipts.';
  static const printerPresetDark = 'Dark';
  static const printerPresetDarkSubtitle =
      'Darker print density for bold output.';

  static String restoreFromFilePrompt(String path) =>
      'Restore from:\n$path\n\n$restoreWarning';
}
