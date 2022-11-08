         
    $emptyPage = "G:\sbf\Livsmiljö\Gemensamt\mapbasic program projekt\organiserarFörMailboxen\tomtPdfBlad.pdf"
    $path = "C:\Users\crbk01\Desktop\Utförandeintyg"
    $i = 1
    $cpdfPath = "C:\Users\crbk01\OneDrive\cpdf" 
    $flag = "-pages"

     cd (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)
. .\pdfPage.ps1

page $emptyPage $path $i $cpdfPath $flag