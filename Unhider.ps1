
#Convert Binary(in ascii text) to ascii
function Convert-Binary-Ascii {
    Param ([string]$binary)
        if ($binary.length % 8 -eq 0) {
            $asciiText = ''
            $binaryArray = $binary  -split '(........)' | ? { $_ };
            ForEach($line in $($binaryArray)) {
                $_ = [Convert]::ToString([Convert]::ToInt32($line, 2), 16)
                $asciiText += [char][byte]"0x$_"
        }
        return $asciiText
    } else {
        throw "Binary string must be divisible by 8. I.e. a multiple of 8"
    }
}

#Convert ascii to binary text
function Convert-Ascii-Binary {
    Param ([string]$ascii)
    $binarytext = ""
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($ascii)
    ForEach ($line in $($bytes)){
        if ($line -ne "0") {
            $tmp = [Convert]::ToString($Line,2)
            if ($tmp.length -ne 8) {
                $zeros = "0" * (8 - $tmp.length)
                $binarytext += $zeros + $tmp
            } 
        }
    }
    return $binarytext
}

Add-Type -AssemblyName System.Drawing


function ImageToText {
    
    param ([String]$ImagePath){

    }

        
    $BitMap = [System.Drawing.Bitmap]::FromFile($ImagePath)
    #get bitmap height and width

    for ( $y = 0; $y -lt $BitMap.height; $y++ ) {
        for ($x =0 ; $x -lt $BitMap.width; $x++) {
            $pixel = $BitMap.GetPixel($x,$y)
            $R = $pixel | select -ExpandProperty R
            $G = $pixel | select -ExpandProperty G
            $B = $pixel | select -ExpandProperty B
            
            $R = [Convert]::ToString($R,2)
            $G = [Convert]::ToString($G,2)
            $B = [Convert]::ToString($B,2)
            
            while ($R.Length -lt 8){
            $R = '0' + $R
            }
            
            while ($G.Length -lt 8){
            $G = '0' + $G
            }
            
            while ($B.Length -lt 8){
            $B = '0' + $B
            }
            
            $t1=Convert-Binary-Ascii -binary $R
            $t2=Convert-Binary-Ascii -binary $G
            $t3=Convert-Binary-Ascii -binary $B
            
            if ($t1 -eq ' ') {
            Write-Host "" -NoNewline
            }else{
            Write-Host $t1 -NoNewline
            }
            
            if ($t2 -eq ' ') {
            Write-Host "" -NoNewline
            }else{
            Write-Host $t2 -NoNewline
            }
            
            if ($t3 -eq ' ') {
            Write-Host "" -NoNewline
            }else{
            Write-Host $t3 -NoNewline
            }        
        }
    }
    
}

