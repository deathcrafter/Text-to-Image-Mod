<#
.Synopsis
   Convert Text to Image. Automate your screenshots.
.DESCRIPTION
   Convert Text to Image. Redirect your output into variable/file and then convert it to image. With our preset styles easily automate your screenshot capturing routine for your blog, twitter, etc.
   Image formats supported: Png, Bmp, Gif, Jpeg, Tiff.
.EXAMPLE
    PS C:\> t2i -ImageText "`r`nTesting Text2Image Powershell Module`r`n" -ImageStyle PuTTY  -Verbose
    VERBOSE: Performing the operation "New-Image" on target "'
    Testing Text2Image Powershell Module
    '. Using PuTTY style".
#>
function ConvertTo-Image
{
    [CmdletBinding(SupportsShouldProcess=$true,
                  PositionalBinding=$false,
                  ConfirmImpact='Medium')]
    [Alias('txt2img')]
    Param
    (
        # Text which should be converted to Image
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Alias("Text")] 
        [string]
        $ImageText,

        # Generated Image Style
        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false)]
        [ValidateNotNull()]
        [ValidateSet("Transparent","SolidColor")]
        [Alias("BackgroundMode")]
        $ImageStyle="Transparent",

        #Background color in solid mode
        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false)]
        [Alias("SolidColor")]
        $SColor='255,30,30,30',

        #FontFace
        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false)]
        [Alias("FontFace","font")]
        $Face="Segoe UI",

        #FontSize
        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false)]
        [Alias("FontSize","size")]
        $FSize="11",

        #FontColor
        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false)]
        [Alias("FontColor")]
        $FColor="White",

                
        # New Image Format
        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false)]
        [ValidateSet("Png", "Bmp", "Gif", "Jpeg", "Tiff")]
        [Alias("ImageType","type")]
        $ImageFormat="Png",

        # New Image Output Path. Default to Current Lcoation
        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false)]
        [Alias("ImagePath","path")]
        $OutputPath,

        # New Image Name
        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false)]
        [Alias("name","ImageName")]
        $NewImageName="NewImage"

    )

    Begin
    {
    }
    Process
    {
        if ($pscmdlet.ShouldProcess("'$($ImageText)'. Using $ImageStyle style"))
        {
            try
              {
                  
                  switch ($ImageStyle)
                  {
                      'Transparent' {
                        $ImageStyleObjProps=@{
                            FontName=$Face
                            FontSize=$FSize
                            TextColor=[System.Drawing.Brushes]::$FColor
                            BackgroundColor=[System.Drawing.Color]::FromArgb(0,0,0,0)
                        }
                        break
                      }
                      'SolidColor' {
                        $aCache = [regex]::Match($SColor, "^(\d{0,3}?)\,?\s*?(\d{0,3})\,\s*?(\d{0,3})\,\s*?(\d{0,3})$").captures.groups[1].value
                        $aCol = $(if($aCache){$aCache}else{255})
                        $rCol = [regex]::Match($SColor, "^(\d{0,3}?)\,?\s*?(\d{0,3})\,\s*?(\d{0,3})\,\s*?(\d{0,3})$").captures.groups[2].value
                        $gCol = [regex]::Match($SColor, "^(\d{0,3}?)\,?\s*?(\d{0,3})\,\s*?(\d{0,3})\,\s*?(\d{0,3})$").captures.groups[3].value
                        $bCol = [regex]::Match($SColor, "^(\d{0,3}?)\,?\s*?(\d{0,3})\,\s*?(\d{0,3})\,\s*?(\d{0,3})$").captures.groups[4].value
                        $ImageStyleObjProps=@{
                            FontName=$Face
                            FontSize=$FSize
                            TextColor=[System.Drawing.Brushes]::$FColor
                            BackgroundColor=[System.Drawing.Color]::FromArgb($aCol,$rCol,$gCol,$bCol)
                        }
                        break
                      }
                      Default {}
                  }
                  $ImageStyleObj=New-Object -TypeName psobject -Property $ImageStyleObjProps
                  $Format=[System.Drawing.Imaging.ImageFormat]::$ImageFormat
                  $FontObj=New-Object System.Drawing.Font $ImageStyleObj.FontName,$ImageStyleObj.FontSize
                  $BitmapObj=New-Object System.Drawing.Bitmap 1,1
                  $GraphicsObj=[System.Drawing.Graphics]::FromImage($BitmapObj)
                  $StringSize=$GraphicsObj.MeasureString($ImageText, $FontObj)
                  $BitmapObj=New-Object System.Drawing.Bitmap $([int]$StringSize.Width),$([int]$StringSize.Height)
                  $GraphicsObj=[System.Drawing.Graphics]::FromImage($BitmapObj)

                  $GraphicsObj.CompositingQuality=[System.Drawing.Drawing2D.CompositingQuality]::HighQuality
                  $GraphicsObj.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBilinear
                  $GraphicsObj.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
                  $GraphicsObj.SmoothingMode=[System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

                  $GraphicsObj.Clear($ImageStyleObj.BackgroundColor)
                  $GraphicsObj.DrawString($ImageText, $FontObj, $ImageStyleObj.TextColor, 0, 0)

                  $FontObj.Dispose()
                  $GraphicsObj.Flush()
                  $GraphicsObj.Dispose()
                  
                  if($null -eq $OutputPath){
                    $OutputPath=Get-Location
                    $OutputPath=$OutputPath.Path.Replace("\","\\")+"\\"
                  }else{
                    $OutputPath=$OutputPath.Replace("\","\\")+"\\"
                  }
                  
                  $ImageFileName="$OutputPath"+"$NewImageName.$($ImageFormat.ToLower())"
                  
                  $BitmapObj.Save("$ImageFileName", $Format);


              }
              catch 
              {
                Write-Verbose "Failed -  please review exception message for more details"
                Write-Output ("Catched Exception: - $($_.exception.message)")
              }
              
              
        }
    }
    End
    {
    }
}