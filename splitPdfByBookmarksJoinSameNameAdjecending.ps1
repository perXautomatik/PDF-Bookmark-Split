##[Ps1 To Exe]
##
##NcDBCIWOCzWE8pGP3wFk4Fn9fms5bM7L6IqDwZK36+X8hwvACZcVWURLpi36N0O8S+JfUvEc+tUdWX0=
##Kd3HDZOFADWE8uK1
##Nc3NCtDXThU=
##Kd3HFJGZHWLWoLaVvnQnhQ==
##LM/RF4eFHHGZ7/K1
##K8rLFtDXTiS5
##OsHQCZGeTiiZ4NI=
##OcrLFtDXTiS5
##LM/BD5WYTiiZ4tI=
##McvWDJ+OTiiZ4tI=
##OMvOC56PFnzN8u+VslQ=
##M9jHFoeYB2Hc8u+VslQ=
##PdrWFpmIG2HcofKIo2QX
##OMfRFJyLFzWE8uK1
##KsfMAp/KUzWJ0g==
##OsfOAYaPHGbQvbyVvnQX
##LNzNAIWJGmPcoKHc7Do3uAuO
##LNzNAIWJGnvYv7eVvnQX
##M9zLA5mED3nfu77Q7TV64AuzAgg=
##NcDWAYKED3nfu77Q7TV64AuzAgg=
##OMvRB4KDHmHQvbyVvnQX
##P8HPFJGEFzWE8tI=
##KNzDAJWHD2fS8u+Vgw==
##P8HSHYKDCX3N8u+Vgw==
##LNzLEpGeC3fMu77Ro2k3hQ==
##L97HB5mLAnfMu77Ro2k3hQ==
##P8HPCZWEGmaZ7/K1
##L8/UAdDXTlaDjofG5iZk2Uj8QGN7P/m/vKWs0I6sw8T1+yjYWYooeVBxpTnwDV+pF/cKUJU=
##Kc/BRM3KXhU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            if( $_.Extension -ine ".pdf" ){ 
                throw "The file $($_.FullName) is not a pdf file."
            } 
            if(-not (Test-Path $_.FullName)) {
                throw "The file '$($_.FullName)' does not exist!"
            }
            $true
        })][System.IO.FileInfo[]]$File
        )

        try{
    Add-Type -LiteralPath ".\PdfSharp-gdi.dll" #our dll dependency, expected to be located in projects root folder.
    } catch {
    throw $Error
    }

    $DestinationFile = $file | Split-Path -Parent #dest = input folder

    if((Test-Path $DestinationFile) -and $DestinationFile.IsReadOnly -and -not $Force) {
        throw "Destination file '$($DestinationFile.FullName)' is read only"
    }

    [System.IO.DirectoryInfo]$DestinationDirectory = $DestinationFile
    if(-not (Test-Path $DestinationDirectory)) {
        try {
            $DestinationDirectory = New-Item -Path $DestinationDirectory -ItemType Directory -Force:$Force
        } catch {
            throw "Error in $($MyInvocation.MyCommand.Name). Could not create directory '$($Path)'. $Error[0]"
        }
    }
    	
	$document = [PdfSharp.Pdf.IO.PdfReader]::Open($file.FullName, [PdfSharp.Pdf.IO.PdfDocumentOpenMode]::Import)
    $curentTitle = "" 
    $i = 1
    Write-Verbose "---------------------------------------------testing---------------------------------------------" 
     
    Write-Verbose $document.pages[3].key
    
    
    Write-Verbose 
    Write-Verbose "---------------------------------------------testingend---------------------------------------------" 


    Foreach($rootb In $document.Outlines)
    {   
     $nonullable = $rootb.Title

     if ($nonullable) {
      Write-Progress -Id 0 "Delar $curentTitle" -PercentComplete ($i/$document.Outlines.count*100)   
      $i++;  
        if ((!(("\" + $rootb.Title + ".pdf") -eq $curentTitle )) -AND (!($curentTitle.toString() -eq "")) )
        {
            Write-Verbose "---------------------------------------------savepast---------------------------------------------" 
            $output =  Join-Path -Path $DestinationFile -ChildPath $curentTitle
            Write-Verbose $output
            $currentDoc.save($output);$currentDoc.close
        }          
        if (!(("\" + $rootb.Title + ".pdf") -eq $curentTitle ))
        {       
            Write-Verbose "---------------------------------------------New---------------------------------------------" 
            $newdocx = New-Object PdfSharp.Pdf.PdfDocument
            $newdocx.Version = $document.Version;
            $newdocx.Info.Title = $document.Info.Title
            $newdocx.Info.Creator = $document.Info.Creator
            $currentDoc = $newdocx
        }
            Write-Verbose "---------------------------------------------addPages---------------------------------------------" 
            $currentDoc.AddPage($rootb.DestinationPage)

            $curentTitle = "\" + $rootb.Title + ".pdf"
            $var = $rootb.DestinationPage


            Write-Verbose "---------------------------------------------ValueOfPage---------------------------------------------" 
            
            Write-Verbose $document.Elements.GetArray($var.Contents)
            
            
            
            
            break
            }
              
                
    }
    Write-Verbose "---------------------------------------------saveToOutput---------------------------------------------" 
    $newdocx.save($output);$newdocx.close;Remove-Variable newdocx
