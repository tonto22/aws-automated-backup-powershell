$Instances = (Get-Ec2Instance).Instances | select InstanceId, InstanceType, @{Name="InstanceName";Expression={$_.tags | where key -eq "Name" | select Value -expand Value}}, PrivateIpAddress 
foreach ($instance in $instances) {
    $volumes = @(get-ec2volume) | ? { $_.Attachments.InstanceId -eq $instance.InstanceId}
    write-host $instance.InstanceId $volumes.VolumeId
}