# --- Details -----

$rgName = "LVMTest" 
$vmName = "LVMTest"
#local file path specified
$template = "Template1.json"
$vhdName = "CoolVHDTest"
$deploy = "deploytest"

# ---- Network info -----

azure network public-ip create $rgName LVMTest2 -l $location

$virtualNetwork = "LVMTest"
$subnet = "default"
$PIP = "LVMTest2"
$NSG = "LVMTest"
$Location = "WestUS"

azure network nic create $rgName $vm_nic -k $subnet -m $virtualNetwork -p $PIA -l $Location

# ---- New VM Details --------

$vm_userName = "jldeen"
$vm_passWord = "Dichtertest1"
$vm_nic = "lvmtest234"
$ID = "/subscriptions/2f6472b1-f49b-4d88-87cf-30d3083413b5/resourceGroups/LVMTest/providers/Microsoft.Network/networkInterfaces/lvmtest234"

# ---------- Begin Capture -----------
azure config mode arm

azure login
az
#verify subscriptions available
azure account list

#stop the vm
azure vm deallocate -g $rgName -n $vmName

#generalize the image
azure vm generalize –g $rgName -n $vmName

#capture the image
azure vm capture $rgName $vmName $vhdName -t $template

# ---------- End Capture -----------

# ---------- Begin Deployment -----------

#deployment
azure vm create <your-resource-group-name> <your-new-vm-name> eastus Linux -d "https://xxxxxxxxxxxxxx.blob.core.windows.net/vhds/<your-new-VM-prefix>.vhd" -Q "https://xxxxxxxxxxxxxx.blob.core.windows.net/system/Microsoft.Compute/Images/vhds/<your-image-prefix>-osDisk.xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.vhd" -z Standard_A0 -u $vm_userName -p $vm_passWord -f $nicName