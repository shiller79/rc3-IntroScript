param (
    [string] $talkname
)
#---------------------------------------------------------------------------------------------------
# Konfiguration
#---------------------------------------------------------------------------------------------------

$intro_blank = "intro\_RC3_OnAir_2_Intro_1_speaker_B_Community_blank.mp4"  #Vorlage für Intro, hier wird das Overlay eingebeldet
$outro_blank = "outro\_RC3_OnAir_3_Outro_2_clean_B_Community.mp4" #Outro-Video, wir unverändert angehängt
$overlay_start_sec = "5.4" #Zeitmarke in Sekunden bei der das Overlay eingebeldet wird
$overlay_end_sec = "7.6" # Zeitmarke in Sekunden bei der das Overlay wieder ausgeblendet wird

$overlay_dir = "intro\png\"
$temp_dir = "temp"
$talk_dir = "cut"
$out_dir = "final"
$ffmpegpath = "ffmpeg" #ggf. Den Path zum ffmpeg binary eintragen (z.b. "C:\progarmme\ffmpeg\ffmpeg.exe")
#---------------------------------------------------------------------------------------------------


# Verzeichnisse in absolute Pfade ändern (wenn nicht schon vorhanden)
$overlay_dir = Resolve-Path -Path $overlay_dir
$intro_blank = Resolve-Path -Path $intro_blank
$outro_blank = Resolve-Path -Path $outro_blank
$temp_dir = Resolve-Path -Path $temp_dir
$talk_dir = Resolve-Path -Path $talk_dir
$out_dir = Resolve-Path -Path $out_dir


#---------------------------------------------------------------------------------------------------
Write-Host "Overlay über Intro einbelden und als temporäres .ts Container ablegen" -ForegroundColor Blue -BackgroundColor White
#---------------------------------------------------------------------------------------------------
$filename_overlay = Join-Path $overlay_dir ($talkname +".png")
$filename_intromp4 = Join-Path $temp_dir "tempintro.mp4"
$filename_introts = Join-Path $temp_dir "tempintro.ts"

$arguments = "-y -i $intro_blank -i `"$filename_overlay`" -filter_complex `"[0:v][1:v] overlay=0:0:enable='between(t,$overlay_start_sec,$overlay_end_sec)'`" `"$filename_intromp4`""
Start-Process -Wait -NoNewWindow -FilePath $ffmpegpath -ArgumentList $arguments 

$arguments = "-y -i `"$filename_intromp4`" -c copy -bsf:v h264_mp4toannexb -f mpegts `"$filename_introts`""
Start-Process -Wait -NoNewWindow -FilePath $ffmpegpath -ArgumentList $arguments 

#---------------------------------------------------------------------------------------------------
Write-Host "Talk temporät in ts-Container convertieren" -ForegroundColor Blue -BackgroundColor White
#---------------------------------------------------------------------------------------------------
$filename_talkmkv = Join-Path $talk_dir ($talkname + ".mkv")
$filename_talkts = Join-Path $temp_dir "temptalk.ts"
$arguments = "-y -i `"$filename_talkmkv`" -c copy -bsf:v h264_mp4toannexb -f mpegts `"$filename_talkts`""
Start-Process -Wait -NoNewWindow -FilePath $ffmpegpath -ArgumentList $arguments 

#---------------------------------------------------------------------------------------------------
Write-Host "Outro temporät in ts-Container convertieren wenn noch nicht vorhanden" -ForegroundColor Blue -BackgroundColor White
#---------------------------------------------------------------------------------------------------
$tempfile = Join-Path $temp_dir "tempoutro.ts"
if (!(Test-Path -Path $tempfile)) {
    $arguments = "-y -i `"$outro_blank`" -c copy -bsf:v h264_mp4toannexb -f mpegts `"$tempfile`""
    Start-Process -Wait -NoNewWindow -FilePath $ffmpegpath -ArgumentList $arguments 
}

#---------------------------------------------------------------------------------------------------
Write-Host "Intro + Talk + Outro zusammenführen und als mp4 speichern" -ForegroundColor Blue -BackgroundColor White
#---------------------------------------------------------------------------------------------------
Push-Location #Aktelles verzeichiss auf den Stack ablegen
$outfilename = Join-Path $out_dir ($talkname + ".mp4")

Set-Location $temp_dir #ins Tempverzeichnis wechseln
$arguments = "-y -i `"concat:tempintro.ts|temptalk.ts|tempoutro.ts`" -c copy -bsf:a aac_adtstoasc `"$outfilename`""
Start-Process -Wait -NoNewWindow -FilePath $ffmpegpath -ArgumentList $arguments
Pop-Location #Verzeichs vom Stack abrufen und zurück wechseln