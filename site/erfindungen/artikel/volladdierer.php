<!-- Erfindung -->


<div class='erfindung'>

	<h1>Geschichte</h1>
	<p>Wann der erste Volladdierer gebaut wurde, ist mir nicht
	bekannt. Definitiv musste bereits Zuse addieren können. Das addieren
	mit Relais geht vom Prinzip jedoch genau gleich, wie mit Röhren oder
	Transistoren.</p>
	 
	<h1>Verwendung und Nutzen</h1>
	<p>Im Wesentlichen können mit einem Mehr-Bit-Addierer zwei
		Binärzahlen zusammengezählt werden. Dank der speziellen Kodierung
		im 2er-Komplement können damit auch Zahlen subtrahiert werden.</p>

		<h1>Funktionsweise und Aufbau</h1>

	<p>Um
	zwei Ziffern zusammenzuzählen reicht ein sog. <b>Halbaddierer</b> (HA). Dieser
	liefert von der Summe von zwei Ziffern die Summenziffer plus den
		Übertrag.
		Im Binärsystem ist der Übertrag nichts anderes als die
		"AND"-Verknüpfung der beiden Ziffern während die Summe das "XOR"
		darstellt.</p>
<p>
Ein <b>Volladdierer</b> (VA) addiert nicht nur zwei, sondern drei
Stellen. Dies ist ab der 2. Ziffer nötig, denn jede vorangehende
Ziffer könnte ja einen Übertrag liefern.</p>

<p>Der abgebildete <b>Vier-Bit-Addierer</b> besteht aus einem
	Halbaddierer (für die Einerziffer) und aus drei Volladdierern (für
	die Zweier-, die Vierer- und die Achterziffer). A1 bis A4
	bezeichnen die erste Zahl während B1 bis B4 die zweite Zahl
	bezeichnen. Die Zahlen sind binär codiert; so bezeichnet A1 die
	Einerziffer, A2 die Zweierziffer, A3 die Viererziffer und A4 die
	Achterziffer (Analog B1 bis B4). C1 bis C5 werden zur Summe der
	beiden Zahlen A und B.</p>

	<h1>Fun-Facts</h1>
	<p>Der 4-Bit-Addierer mit Relais nachgebaut ist eine schöne
	Demonstration, wie ein Computer im innersten zwei Zahlen miteinander
	addieren kann. Die Umsetzung mit Transistoren (Bild) ist durchaus
	schwieriger, Fehleranfälliger und es ist auch durchaus schwieriger
	Fehler zu finden; mit anderen Worten: Der 4-Bit-Addierer mit
	Transistoren ist wohl unser Meisterwerk, dennoch niemals so spannend,
	wie mit Relais nachgebaut. Bei den Relais hört man die Addition.</p>

	<h1>Quellenangaben</h1>
	<p>Die Webseite <a href='https://www.waitingforfriday.com'>waiting for friday</a> hat mich auf die Idee gebracht,
	einen 4-Bit-Addierer auch mit Transistoren nachzubauen. Ich habe
	jedoch andere Werte in den Widerständen genommen, sodass sich die
	Widerstände farblich besser voneinander abheben. Zudem haben wir
	das XOR jeweils mit lediglich 5 Transistoren gebaut.</p>
</div>
