         
    $emptyPage = "G:\sbf\Livsmiljö\Gemensamt\mapbasic program projekt\organiserarFörMailboxen\tomtPdfBlad.pdf"
    $path = "C:\Users\crbk01\Desktop\Ny Mapp\Utförandeintyg"
    $list = "C:\Users\crbk01\Desktop\Södra.txt"
    $NumberOfPages = 1
    $cpdfPath = "C:\Users\crbk01\OneDrive\cpdf" 
    $flag = "-pages"   
 
 function reverse
{ 
 $arr = @($input)
 [array]::reverse($arr)
 $arr
}
    $count = (Get-Content $list).Count


     Get-Content $list | reverse | foreach {

        $line = $_
        $param1 = $cpdfPath + ".exe"
        $fileName = $path + '\' + $line.Replace("`"","") +'.pdf'
        $RessultPath = $path + 'merge.pdf'
        
        if ($NumberOfPages -eq 1) 
        {
            & $cpdfPath $fileName 1 -o $RessultPath
        }
        else {
            & $cpdfPath $fileName 1 -merge $RessultPath -o $RessultPath
        }
            $NumberOfPages = &$cpdfPath $flag $RessultPath
            $NumberOfPages = $NumberOfPages + "/" + $count
            Out-Host -InputObject $NumberOfPages

        }
   Remove-Item –path $list