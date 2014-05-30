define lsp::userrights (
  $policy = $title,
  $setting,
) {
  include lsp::maps::userrights

  # Fail logic
  $mapping = $lsp::maps::userrights::map[$policy]
  if !$mapping { fail("managing $policy not yet implemented") }

  ## Template uses:
  #   - $mapping
  #   - $setting
  exec { "$policy user rights assignment":
    command  => template('lsp/userrights_set.ps1.erb'),
    unless   => template('lsp/userrights_check.ps1.erb'),
    provider => powershell,
  }

}
