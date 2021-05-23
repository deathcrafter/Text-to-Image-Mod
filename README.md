# Text2Image
Convert Text to Image. Redirect your output into variable/file and then convert it to image. With our preset styles easily automate your screenshot capturing routine for your blog, twitter, etc.Image formats supported: Png, Bmp, Gif, Jpeg, Tiff.

## Install Module
Sorry, for personal use.😔
But you can use it if you know how to.

## Cmdlets
```powershell
Text-ToImage
```

## Dependencies
This module has no dependencies.

## Parameters
### ImageText or text (mandatory)
```powershell
Text-ToImage -text "lord death"
```
### BackgroundMode (Transparent(default)/Solid)
```powershell
Text-ToImage -text "lord death" -Style "Transparent"
```
### SolidColor (format ARGB) (default 255,30,30,30 | only works with BackgroundMode Solid)
```powershell
Text-ToImage -text "lord death" -SolidColor "20,40,60,190"
```
### FontFace or font (default Segoe UI)
```powershell
Text-ToImage -text "lord death" -font "Comfortaa Regular"
```
### FontSize or size (default 11)
```powershell
Text-ToImage -text "lord death" -size 20
```
### FontColor (default White, check [here](https://docs.microsoft.com/en-us/dotnet/api/system.drawing.brushes?view=net-5.0#properties) for more colors)
```powershell
Text-ToImage -text "lord death" -FontColor "AliceBlue"
```
### ImageName or name (default NewIamge)
```powershell
Text-ToImage -text "lord death" -name LordDeath
```
### ImageType or type (Png(default)/Bmp/Gif/Jpeg/Tiff)
```powershell
Text-ToImage -text "lord death" -type "Jpeg"
```
### ImagePath or path (default current directory)
```powershell
Text-ToImage -text "lord death" -path "D:\Death\"
```
## EXAMPLE
```powershell
Text-ToImage -ImageText "Testing text2image mod" -BackGroundMode "Solid" -SolidColor "200, 255, 0, 255" -FontFace "Segoe UI Variable Display Semilight" -FontSize 18 -FontColor "MidnightBlue" -ImageName "LordDeath" -ImageType "png" 
```
![Example](https://github.com/deathcrafter/Text2Image/blob/master/LordDeath.png)
