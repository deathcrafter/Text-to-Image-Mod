# Text2Image
Convert Text to Image. Redirect your output into variable/file and then convert it to image. With our various range of options, customize you text and save as an image.

Image formats supported: 
- png
- bmp
- gif
- jpeg
- tiff

## Install Module
```powershell
Install-Module -Name TextToImage
```

## Cmdlets
```powershell
ConvertTo-Image
```
or
```powershell
txt2img
```

## Dependencies
This module has no dependencies.

## Parameters
### ImageText or text (mandatory)
```powershell
ConvertTo-Image -text "lord death"
```
### BackgroundMode (Transparent(default)/Solid)
```powershell
ConvertTo-Image -text "lord death" -BackgroundMode "Transparent"
```
### SolidColor (format ARGB) (default 255,30,30,30 | only works with BackgroundMode Solid)
```powershell
ConvertTo-Image -text "lord death" -SolidColor "20,40,60,190"
```
### FontFace or font (default Segoe UI)
```powershell
ConvertTo-Image -text "lord death" -font "Comfortaa Regular"
```
### FontSize or size (default 11)
```powershell
ConvertTo-Image -text "lord death" -size 20
```
### FontColor (default White, check [here](https://docs.microsoft.com/en-us/dotnet/api/system.drawing.brushes?view=net-5.0#properties) for more colors)
```powershell
ConvertTo-Image -text "lord death" -FontColor "AliceBlue"
```
### ImageName or name (default NewIamge)
```powershell
ConvertTo-Image -text "lord death" -name LordDeath
```
### ImageType or type (Png(default)/Bmp/Gif/Jpeg/Tiff)
```powershell
ConvertTo-Image -text "lord death" -type "Jpeg"
```
### ImagePath or path (default current directory)
```powershell
ConvertTo-Image -text "lord death" -path "D:\Death\"
```
## EXAMPLE
```powershell
txt2img -ImageText "Testing text2image mod" -BackGroundMode "SolidColor" -SolidColor "200, 255, 0, 255" -FontFace "Segoe UI Variable Display Semilight" -FontSize 18 -FontColor "MidnightBlue" -ImageName "LordDeath" -ImageType "png"
```
Output:

![Example](https://github.com/deathcrafter/Text2Image/blob/master/LordDeath.png)
