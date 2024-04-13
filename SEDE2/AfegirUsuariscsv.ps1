Import-Csv C:\prueba2.csv | ForEach-Object { 
$Name = $_.Nombre +" "+ $_.Apellido
$Correo = $_.Cuenta + “@chatsbd.es”
$Descripcion = $_.Puesto +" de "+ $_.Departamento + " " + $_.Sede
$Cuenta = $_.Cuenta
New-ADUser `
-GivenName $_.Nombre `
-Surname $_.Apellido `
-SamAccountName $_.Nombre `
-Office $_.Sede `
-Title $_.Puesto `
-Department $_.Departamento `
-Name $Name `
-DisplayName $Name `
-UserPrincipalName "$Correo"  `
-Description $Descripcion `
-EmailAddress $Correo `
-AccountPassword (ConvertTo-SecureString "Super3ies1234." -AsPlainText -Force) `
-Path "OU=$($_.Departamento),DC=chatsbd,DC=es" `
-ChangePasswordAtLogon 1 `
-Enabled $true
}
