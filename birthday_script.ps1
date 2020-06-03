$ExchangeServer = "mail.yourdomain.com"
$SMTPPort = "25"
$FromAddress = "AnniversaryTeam <AnniversaryTeam@yourdomain.com>"

# Function to create report email
function SendNotification{
 $Msg = New-Object Net.Mail.MailMessage
 $Smtp = New-Object Net.Mail.SmtpClient($ExchangeServer, $SMTPPort);
 $Msg.From = $FromAddress
 $Msg.To.Add($ToAddress)
 $Msg.Subject = "Happy Birthday"
 $Msg.Body = $EmailBody
 $Msg.IsBodyHTML = $true
 $Smtp.Send($Msg)
}

# Import user list and information from .CSV file and get today's date
$Date = Get-Date
$Users = Import-Csv "D:\birthday1.csv"
 
# Send notification to each user in the list whose anniversary is today
Foreach ($User in $Users) {
if ($Date.Day -eq $User.Anniversary_day -and $Date.Month -eq $User.Anniversary_month) {
 $ToAddress = $User.Email
 $Name = $User.FirstName
 $EmailBody = @"
 <html>
 <head>
 </head>
 <body>
 <p>Dear $Name,</p>
 
 <p>Wishing you a very happy Birthday</p>
 
 <p>Regards,</p>
 
 <p>Anniversary Team</p>
 </body>
 </html>
"@
Write-Host "Sending notification to $Name ,$ToAddress,$EmailBody" -ForegroundColor Yellow
 #Write-Host "Sending notification to $Name ($ToAddress)" -ForegroundColor Yellow
 #SendNotification
}
} 