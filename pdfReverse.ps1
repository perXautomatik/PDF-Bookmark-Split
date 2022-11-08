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