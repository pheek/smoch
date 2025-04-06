<!-- Erfindung -->

<div class='erfindung'>

	<h1>Geschichte</h1>
	 <p>Wann das erste Bit mit Transistoren gebaut wurde, ist mir nicht bekannt. Wahrscheinlich war das Bit bereits mit Röhren realisiert worden, denn der Schaltungsaufbau ist im Grundprinzip obiger Schaltung identisch. (Hinweise gerne an phi@smoch.ch)</p>

	 
	<h1>Verwendung und Nutzen</h1>
	<p>Ein Bit ist die kleinste digitale Informationseinheit. Damit
	kann z. B. eine Null von einer Eins unterschieden werden, es kann
	"true" im Gegensatz zu "false" modelliert werden, es kann das
		Ergebnis einer NOT-Operation auch gespeichert werden.</p>

	<p>Obschon ein Bit die kleinste Informationseinheit ist, so kann
	damit ein ganzer Programmablauf durch eine einzige Selektion
	verändert werden; Beispiel: Ein Web-Shop kann in einem einzigen Bit
	speichern, ob der aktuelle Benutzer eingeloggt ist oder nicht und
	somit komplett andere Inhalte anzeigen.</p>
	 
	<h1>Funktionsweise und Aufbau</h1>
	 <p>Die beiden Leitungen "SET" bzw. "RESET" setzen bzw. löschen das Bit.
	 In der Schaltung sind dies das grüne (SET) bzw. das orange (RESET) Kabel.
	 
	 Wird bei SET eine Spannung angelegt, so schaltet der linke Transistor durch und der rechte wird blockiert, sodass an der OUT-Leitung eine Spannung erzeugt wird. Die OUT-Leitung ist im Exponat das gelbe Kabel.
	 </p>

<p>Die beiden weiteren Anschlüsse (rot/schwarz) dienen der Stromversorgung. Es reicht nämlich ein ganz kurzer «Stromstoß» bei SET bzw. RESET, um das Flip-Flop in den anderen Zustand zu versetzen. Danach bleibt die Output-Leitung bis auf weitere Anweisung (SET, RESET) im selben Zustand. Damit nach einem SET (auch von wenigen Millisekunden) das Bit bei OUT erhalten bleibt, muss permanent eine Stromversorgung anliegen. Dies macht diesen Speicher zum «flüchtigen Speicher»; wird die Stromversorgung unterbrochen (Ausschlten des PC), so verliert das Bit seinen definierten Zustand.</p>

	<p>Die obige Schaltung wurde mit 9 Volt getestet. Beim
	gesperrten rechten Transistor liefert der Output ca. 7.5 Volt, was
	noch gut reicht, um weitere Transistoren anzusteuern.</p>


	<h1>Trivia</h1>
	 <p>Die obige Schaltung wurde einen <a href='https://www.smoch.ch/skript/Grundlagen_Digitaltechnik_2020_04_18_V1.19.pdf'>Kurs</a>
	 entwickelt. Die Widerstände sind nicht diejenigen, welche meistens
	 zusammen mit dem BC548C verwendet werden. Die Widerstände wurden so
		 gewählt, dass die Farben gut unterschieden werden können.</p>
	 
	 <h1>Quellenangaben</h1>
	<p>Dieses Exponat wurde vom Kurator persönlich gebaut. Der
	Schaltplan stimmt mit der Schaltung überein.</p>

</div>
