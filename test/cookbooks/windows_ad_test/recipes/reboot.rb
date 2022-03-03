%w(
  Microsoft-Windows-GroupPolicy-ServerAdminTools-Update
  ServerManager-Core-RSAT
  ServerManager-Core-RSAT-Role-Tools
  RSAT-AD-Tools-Feature
  RSAT-ADDS-Tools-Feature
  ActiveDirectory-Powershell
  DirectoryServices-DomainController-Tools
  DirectoryServices-AdministrativeCenter
  DirectoryServices-DomainController
).each do |feature|
  windows_feature feature do
    action :install
    install_method :windows_feature_dism
    all true
    # notifies :reboot_now, 'reboot[ADDS]', :immediately
    notifies :run, 'powershell_script[Reboot]', :immediately
  end
end

reboot 'ADDS' do
  delay_mins 1
  action :nothing
  returns [0, 35, 1190]
end
