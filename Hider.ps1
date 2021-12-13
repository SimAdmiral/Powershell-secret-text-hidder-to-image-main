Add-Type -AssemblyName System.Drawing


function TextToImage {
    
    param ([String]$TextPath, [String]$OutPath, [Int32]$width){

    }
    

    $String = Get-Content $TextPath -Raw


    $out = [system.Text.Encoding]::Default.GetBytes($String) | %{[System.Convert]::ToString($_,2).PadLeft(8,'0') }
    
    $y = $out.Length/$width
    $y =  [math]::Ceiling($y)
    $y = [int]$y

    $y1 = [math]::Round($y/3)
#crete file which will fit automaticaly it means Bitmap y, width
    $bmp = new-object System.Drawing.Bitmap $width,($y1)
    $graphics = [System.Drawing.Graphics]::FromImage($bmp)
    $c = 0
    $i=0
    

    while ($true){

        if ($i -ge $out.Length){
            $r=0
        }else{
            $r = [Convert]::ToInt32($out[$i],2)
        }

        if ($i+1 -ge $out.Length){
            $g=0
        }else{
            $g = [Convert]::ToInt32($out[$i+1],2)
        }

        if ($i+2 -ge $out.Length){
            $b=0
        }else{
            $b = [Convert]::ToInt32($out[$i+2],2) 
        }
    
        $TextBrush = New-Object Drawing.SolidBrush([System.Drawing.Color]::FromArgb($r, $g, $b))
        
        $graphics.FillRectangle($TextBrush, $c, $n ,1,1)
        
        $i+=3   
        $c++
        if($c%$width -eq 0) {
            $n++
            $c=0
        }

        if ($i -ge $out.Length) {
            break
        }

    }

    $graphics.Dispose() 
    #$bmp.RotateFlip("Rotate90FlipNone")
    $bmp.Save($OutPath) 

    

    #explorer $OutPath
    #Invoke-Item $OutPath  

}





#TextToImage -TextPath .\text.txt -OutPath .\test.png -width 10
