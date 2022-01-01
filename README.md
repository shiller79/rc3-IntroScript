
    IntroScript/
	    |   add-intro.ps1
	    ├── cut/       # geschnittene Video 
	    ├── final/     # Videos inkl. Intro und Outro
	    ├── intro/     # Intro Videos
	    |   └── png/   # Overlays
	    ├── outro/     # Outro Videos
	    ├── temp/      # Temp Ordner
	    ├── uncut/     # ungeschnittee Vidoes

	      
1. Dateien vom [Styleguid](https://style.rc3.world/13_Video/) herunterladen
	- Vorlage für Intro [mit Speaker einbelndung](https://style.rc3.world/13_Video/2_Intros/RC3_OnAir_2_Intro_1_speaker/_RC3_OnAir_2_Intro_1_speaker_B_Community_blank.mp4) nach "intro" herunterladen
	- Overlay [Vorlage](https://style.rc3.world/13_Video/2_Intros/RC3_OnAir_2_Intro_1_speaker/_RC3_OnAir_2_Intro_1_speaker_Type.psd) herunterladen
	- Cleanes [Outro](https://style.rc3.world/13_Video/3_Outros/RC3_OnAir_3_Outro_2_clean/_RC3_OnAir_3_Outro_2_clean_B_Community.mp4) nach "outro" herunterladen 
	- [Schriftarten](https://style.rc3.world/13_Video/2_Intros/RC3_OnAir_2_Intro_1_speaker/Fonts/) herunterladen und installieren
2. Overlays erstellen
	- Anleitung https://style.rc3.world/13_Video/2_Intros/RC3_OnAir_2_Intro_1_speaker/_RC3_OnAir_2_Intro_1_speaker_Info.jpg
		- [photopea.com](https://photopea.com) öffnen
		- "Vom Computer öffnen"
		- [Vorlage](https://style.rc3.world/13_Video/2_Intros/RC3_OnAir_2_Intro_1_speaker/_RC3_OnAir_2_Intro_1_speaker_Type.psd)  aus Schritt 1 auswählen
		- Text für Headline anpassen (nur Kleinbuchstaben, Farbe und Schrittgröße nicht ändern)
		- Text für Speaker anpassen (Farbe und Schrittgröße nicht ändern)
		- Ebene "Reference" ausbleden (Augensymbol)
		- Datei->Exportieren als -> png
		- PNG im Ordner intro/png mit dem Talknamen speichern (z.b. talk01.png)
3. Videos vom Produktionsrechner auf lokalen Rechner herunterladen (wenn nicht am Produktionsrechner geschnitten wird)
	- hierfür ist der Ordner "uncut" vorgesehen 
4. Video mit Schnittprogramm schneiden 
	- z.B. mit [AVIDEMUX](http://avidemux.sourceforge.net/download.html)
	- Wenn bei Aufnahme alles OK war, muss hier in der Regel nur Anfang und Ande abeschnitten werden
	- geschnittenes Video in Ornder "cut" ablegen und den gleichen Namen wie dem Overlay geben (z.b. "talk01.mkv")
5. Script starten
	-	bei Bedarf  Script im Editor Öffnen und Werte für $intro_blank und $outro_blank anpassen
			add-intro.ps1 talk01
    - Fertiges Video wird im Ordner "final" abgelegt

	 
