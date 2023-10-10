# Introduction 
Dit project is onderdeel van de Bartosz CI/CD pipeline en bevat testen voor het Bartosz testobject Nop.Commerce.

# Getting Started
Om de testen te kunnen draaien heb je Python nodig, dus installeer de nieuwste versie van Python (huidig: 3.10.1).
Installeer daarna Robot Framework door de volgende stappen:
1. Open een command prompt of Powershell in de projectmap.
2. voer het volgende commando uit: pip install -r requirements.txt
3. Download de keepass.key zip van Teams (https://bartoszict.sharepoint.com/:u:/s/BartoszTraineeship/EWS1papAV2lGkrp73PFY0cIBq688iW-DEXH7ZXLJFy3vUA?e=g99RgK) en pak hem uit in je user folder  (C:\Users\<username>)

# Build and Test
Om testen te draaien of te bouwen installeer je (bijvoorbeeld) Eclipse met de plugin Robot EDitor (RED) (N.B. deze editor werkt niet goed met robot framework v4.0 en hoger! De versie die wij gebruiken is 3.2.2).
Maar je mag ook een andere IDE gebruiken.
Draaien van de testen kan handmatig via de IDE, of via de commandline/powershell: 

robot -v ENV:<omgeving, dev of test> -i Regression .

(hiermee draai je alle testen met tag Regression op de gewenste omgeving)

testoutput: report.html, log.html, output.xml


# Contribute
TODO: Voor later: iets over branches en pull requests, nieuwe library: pip freeze > requirements.txt