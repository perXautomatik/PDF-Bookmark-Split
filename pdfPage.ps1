
function page
{ 
 $arr = @($input)
 [array]::reverse($arr)
 $arr
}
    dir $path\*.pdf | Sort-Object -Property Name -Descending | foreach-object{   
       

        $param1 = $cpdfPath + ".exe"
        $fileName = $_.FullName
        $RessultPath = $path + 'merge.pdf'

        $NumberOfPages = &$cpdfPath $flag $fileName
        
        if($NumberOfPages)
        {
            if($i -eq 1) 
            {
                & $cpdfPath $_.FullName 1 -o $RessultPath
            }
                & $cpdfPath $_.FullName 1 -merge $RessultPath -o $RessultPath
                 Out-Host -InputObject $i
        }

        else
        {
            $_.FullName
        }

        $i = $i + 1
    }                        
   