<!-- Erfindung -->

<div class='erfindung'>

	<h1>Geschichte</h1>
	 <p>???? Wann das erste Komplement (NOT-Gatter) mit Transistoren gebaut wurde, ist mir nicht bekannt.</p>

	 
	<h1>Verwendung und Nutzen</h1>
	 <p>Analog zum Komplement mit Relais, wird auch hier ein BIT umgekehrt. Aus true wird false, aus 1 wird 0 und jeweils umgekehrt. </p>

	 
	<h1>Funktionsweise und Aufbau</h1>
	 <p><b>Fall IN=1</b>: Liegt bei IN Strom an (mind. 0.6 Volt gegenüber der Basis), so schaltet der linke Transistor durch. Das heißt, zwischen C (Collector) und E (Emitter) im Transistor fließt Storm. Es wird dem Strom zwischen C und E kein Widerstand entgegengesetzt. Somit ist aber zwischen C und E auch kaum ein Spannungsunterschied zu messen. Somit liegt aber an der Basis B des rechten Transistors keine Spannung gegenüber dem Emitter und der rechte Transitor ist komplett geschlossen. Es kommt kein Strom zum Ausgang (OUT).<br />
		                      <b>Fall IN=0</b>: Liegt nun im Gegensatz am Input kein Strom an, so ist der linke Transistor gesperrt. Zwischen C und E liegt theoretisch ein beliebig großer Widerstand. Somit können die 4.7kOhm, die 56kOhm und die zweiten 4.7kOhm als Spannungsteiler aufgefasst werden, welche bei B (des rechten Transistors) eine Spannung von ca. 0.65 Volt zeigt. Somit startet der rechte Transitor durch und zwischen C und E (des rechten Transitors) liegt quasi kein Widerstand. Der Ausgang erhält nun die vollen 9 Volt der Versorgung des NOT-Gatters (pinke Rahmen).</p>

	<h1>Fun-Facts</h1>
	 <p>Die oben abgebildete Schaltung funktioniert tatsächlich und wurde mehrfach getestet. Obschon die Schaltung erst mit einem Schaltstrom im Transitor von 0.7V komplett schalten sollte, so ergibt sich die Rechnung, dass der Schaltstrom für einen 0-Eingang (0V am IN) tatsächlich 0.65V an die Basis liefert. Anscheinend scheint bereits 0.55V für den verwendeten Transistor BC548C auszureichen, um ihn «einzuschalten» (<a href='https://www.mouser.ch/datasheet/2/308/bc546-d-1190617.pdf'>S. DATASHEET</a>).</p>

	 <h1>Quellenangaben</h1>
	<p> .... Quellenangaben .... </p>
</div>