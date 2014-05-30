define lsp::userrights (
  policy,
  setting,
) {
  include lsp::maps::userrights

  # Fail logic
  $mapping = $lsp::maps::userrights::map[$title]
  if !$mapping { fail("managing $title not yet implemented") }

  ## Template uses:
  #   - $mapping
  #   - $setting
  exec { "$title user rights assignment":
    command  => template('lsp/userrights_set.ps1.erb'),
    unless   => template('lsp/userrights_check.ps1.erb'),
    provider => powershell,
  }

}
