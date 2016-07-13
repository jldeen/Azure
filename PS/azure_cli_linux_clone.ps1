#-----fill in these variables

$rgName = "LVMTest"

$template = "C:\Templates\Template1.json" # local file path specified

$vmName = ”LVMTestVM”

$vhdName = "JDVHDTest"

 

#-----stop the vm
azure vm deallocate -g $rgName -n $vmName

#-----generalize the image
azure vm generalize $rgName -n $vmName

#-----capture the image
azure vm capture $rgName $vmName $vhdName -t $template

#stage2 - Staging

$rgName = "LVMTest"
$vNet = "LVMTest"
$subnet = "default"
$pip = "LVMIP"
$nic = "LVMNic"
$vmName = "LVMTestVM"

# ---- powershell VM Removal ----

Login-AzureRmAccount
Remove-AzureRmVM -ResourceGroupName $rgName –Name $vmName -Force

#azure group create $rgName -l "westus"

#azure network vnet create $rgName $vNet -l "westus"

#azure network vnet subnet create $rgName $vNet $subnet

# ---- Network Creation -----

azure network public-ip create $rgName $pip -l "westus"

azure network nic create $rgName $nic -k $subnet -m $vNet -p $pip -l "westus"

azure network nic show $rgName $nic

$id = "/subscriptions/2f6472b1-f49b-4d88-87cf-30d3083413b5/resourceGroups/LVMTest/providers/Microsoft.Network/networkInterfaces/LVMNic"

#stage3 - Deploy

$deployName = "LVMDemo"
$template = "C:\Templates\Template1.json" # local file path specified

azure group deployment create $rgName $deployName -f $template