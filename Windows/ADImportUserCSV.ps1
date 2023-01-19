$Datei = "C:\import1.csv"

$CSVImport = Import-Csv $Datei -Delimiter ";" -Encoding Default

foreach ($Benutzer in $CSVImport)
{
    New-ADUser -Path "OU=Anwender,DC=Maluschke,DC=lan" -Surname $Benutzer.lastname -GivenName $Benutzer.firstname -SamAccountName $Benutzer.username -UserPrincipalName $Benutzer.username -AccountPassword ($Benutzer.password | ConvertTo-SecureString -AsPlainText -Force) -Enabled:$true -DisplayName "$($Benutzer.firstname) $($Benutzer.lastname)" -Name "$($Benutzer.firstname) $($Benutzer.lastname)" -EmailAddress $Benutzer.Email  
    
    $user = $Benutzer.username
    $userpass = $Benutzer.password
    
    $willkommen = "Willkommen $($Benutzer.firstname) $($Benutzer.lastname), `n`n"
    $willkommen += "dieses Laufwerk gehört ganz Ihnen alleine.`n"
    $willkommen += "Kein anderer kann die Dateien einsehen.`n`n"
    $willkommen += "!!! Bitte gehen sie mit dem Speicherplatz sorgsam um. !!!`n`n`n"
    $willkommen += "Ihr Anmeldename lautet:  $($user)`n"
    $willkommen += "Ihr Passwort lautet:  $($userpass)`n`n"
    $willkommen += "Bitte ändern Sie umgehend nach der Anmeldung Ihr Passwort ab.`n`n`n"
    $willkommen += "Besten gruß aus der IT"

    New-Item -Name $Benutzer.username -ItemType Directory -Path „A:\“
    New-Item -Name „Homelaufwerk.txt“ -ItemType File -value $willkommen -Path „A:\$user"
    }
 New-Item -Name „Gruppenlaufwerk.txt“ -ItemType File -value "Hier können alle Ihre Dateien Austauschen" -Path „B:\"    