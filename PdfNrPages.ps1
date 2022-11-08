$result = @()
$path = "C:\Users\crbk01\Desktop\Ny mapp\Södra"

dir $path\*.pdf | foreach-object{
 $NumberOfPages = & "C:\Users\crbk01\Desktop\cpdf" -pages $_.FullName
 $details = @{
 NumberOfPages = $NumberOfPages 
 Name = $_.Name
 }
 $result += New-Object PSObject -Property $details 
}
$result
$result | export-csv -Path $path\pdf.csv
echo "Th result has been saved in $path\pdf.csv file"