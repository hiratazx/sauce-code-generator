@echo off
setlocal enabledelayedexpansion
set /a "rand=(%RANDOM% * 899999 / 32768) + 100000"
echo Random number: %rand%

set ps_script=%temp%\temp_ps_script.ps1
echo [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > %ps_script%
echo $template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02) >> %ps_script%
echo $toastXml = [xml] $template.GetXml() >> %ps_script%
echo $toastTextElements = $toastXml.GetElementsByTagName('text') >> %ps_script%
echo $toastTextElements[0].AppendChild($toastXml.CreateTextNode('Random Sauce Code Generator')) > $null >> %ps_script%
echo $toastTextElements[1].AppendChild($toastXml.CreateTextNode('%rand%')) > $null >> %ps_script%
echo $xml = New-Object Windows.Data.Xml.Dom.XmlDocument >> %ps_script%
echo $xml.LoadXml($toastXml.OuterXml) >> %ps_script%
echo $toast = New-Object Windows.UI.Notifications.ToastNotification $xml >> %ps_script%
echo $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('ItzKaguya') >> %ps_script%
echo $notifier.Show($toast) >> %ps_script%

powershell -executionpolicy bypass -file %ps_script%

del %ps_script%
