<!-- Erfindung -->

<div class='erfindung'>
          <p>ASCII steht für «american standard code for information interchange»; was so viel bedeutet, wie «amerikanische standardisierte Kodierung für Informationsaustausch».</p>
                                                                                                                                                                                
	<h1>Geschichte</h1>
       <p>Der ASCII ist eine Entwicklung der ASA (American Standards Associaton) und wurde 1963 als Standard "ASA X3.4-1963" veröffentlicht.</p>
       <p class='quelle'>(Quelle: Wikipedia 2020)</p>

	 
	<h1>Verwendung und Nutzen</h1>
                         <p>Der ASCII wird verwendet, um Zeichen (Buchstaben, Ziffern, Sonderzeichen, Steuerzeichen, ...) einheitlich zu interpretieren.
      Eine Umwandlung vom einen Gerät zum anderen entfällt, denn die übertragene Bitfolge ist bei Sender und Empfänger gleich.</p>

	<h1>Funktionsweise und Aufbau</h1>
<p>Auszug aus der ASCII Tabelle</p>
  <table>                             .__               .__     
     <tr><td>Wert</td><td>HEX</td><td>Binär    </td><td>Zeichen</td><td>Beschreibung                                                               </td></tr>
          
     <tr><td>   0</td><td>  0</td><td>0000 0000</td><td>       </td><td>Null-Zeichen; typischerweise zur STRING-Begrenzung in C-Programmiersprachen</td></tr>
     <tr><td>   1</td><td>  1</td><td>0000 0001</td><td>       </td><td>Start of Text                                                              </td></tr>
     <tr><td>   2</td><td>  2</td><td>0000 0010</td><td>       </td><td>End of Text                                                                </td></tr>

     <tr><td> ...</td><td>...</td><td>      ...</td><td>   ... </td><td>...                                                                        </td></tr>

     <tr><td>  32</td><td> 20</td><td>0010 0000</td><td>       </td><td>Space (Wortzwischenraum)                                                   </td></tr>
     <tr><td>  33</td><td> 21</td><td>0010 0001</td><td>   !   </td><td>Das erste druckbare Zeichen im ASCII ist das Ausrufezeichen.               </td></tr>

     <tr><td> ...</td><td>...</td><td>      ...</td><td>   ... </td><td>...                                                                        </td></tr>

     <tr><td>  48</td><td> 30</td><td>0011 0000</td><td>   0   </td><td>Die Ziffer Null                                                            </td></tr>
     <tr><td>  49</td><td> 31</td><td>0011 0001</td><td>   1   </td><td>Die Ziffer Eins                                                            </td></tr>
 
     <tr><td> ...</td><td>...</td><td>      ...</td><td>   ... </td><td>...                                                                        </td></tr>

     <tr><td>  64</td><td> 40</td><td>0100 0000</td><td>   @   </td><td>Affenschwanz                                                               </td></tr>
     <tr><td>  65</td><td> 41</td><td>0100 0001</td><td>   A   </td><td>Großbuchstabe A                                                            </td></tr>
     <tr><td>  66</td><td> 42</td><td>0100 0010</td><td>   B   </td><td>Großbuchstabe B                                                            </td></tr>
 
     <tr><td> ...</td><td>...</td><td>      ...</td><td>   ... </td><td>...                                                                        </td></tr>

     <tr><td>  96</td><td> 60</td><td>0110 0000</td><td>   `   </td><td>Backtic     <!--` -->                                                      </td></tr> 
     <tr><td>  97</td><td> 61</td><td>0110 0001</td><td>   a   </td><td>Kleinbuchstabe a                                                           </td></tr>
     <tr><td>  98</td><td> 62</td><td>0110 0010</td><td>   b   </td><td>Kleinbuchstabe b                                                           </td></tr>

     <tr><td> ...</td><td>...</td><td>      ...</td><td>   ... </td><td>...                                                                        </td></tr>
     </table>
           
<p>Eine Spezialität, die bis heute alle Umsteiger von Linux nach Windows nerft, ist die Tatsache, dass sich Kleinbuchstaben nur durch ein Bit (6.tes Bit) unterscheiden. Dadurch kann Windows einfach Groß- und Kleinschreibung ignorieren, während die Unixer sich gewohnt sind, Dateinamen teilweise lediglich durch Groß- und Kleinschreibung zu unterscheiden. Ein Chaos bei Verwendung von Nextcloud etc. ist vorprogrammiert; obschon es ursprünglich bei dieser Idee unter anderem darum ging, Printer etc. mit weniger Leitungen bauen zu können.</p>

	<h1>Trivia</h1>
       <p>Der ASCII ist nicht in der Lage Zahlen darzustellen, es handelt sich bei '0', '1', ... lediglich um Ziffern. Für Zahlen (wie z. b. 42) sind mehrere ASCII-Zeichen nötig.</p>


                                                                                                                                                                                 
       <p>Die Buchstaben in diesem Absatz sind mit UNICODE kodiert und wurden mit UTF-8 in der Datei abgelegt. Der UNICODE ist eine Erweiterung des ASCII und alle hier vorkommenden Zeichen sind an exakt derselben Stelle wie im ASCII kodiert. Das kommt daher, dass dieser Absatz keinen einzigen Umlaut (oder sonstiges Sonderzeichen) verwendet und daher nur die reinen ASCII-Zeichen benutzt. Jeder Kode dieser Buchstaben wird im UTF-8 mit 8-Bit abgespeichert und da in dem ganzen Absatz nur ASCII-Symbole verwendet werden, so bleibt das erste Bit immer Null; die restlichen sieben Bit entsprechen exakt dem ASCII. Somit entspricht der duale Code dieses Absatzes sogar der originalen Null/Eins Darstellung der Zeichen im ASCII.</p>


 <p><pre>
                           _           _     
                          | |         | |    
  ___ _ __ ___   ___   ___| |__    ___| |__  
 / __| '_ ` _ \ / _ \ / __| '_ \  / __| '_ \ 
 \__ \ | | | | | (_) | (__| | | || (__| | | |
 |___/_| |_| |_|\___/ \___|_| |_(_)___|_| |_|</pre></p>

	<h1>Quellenangaben</h1>
	<p>Wikipedia und <a href='https://www.ascii-code.com'>ascii-code.com</a></p>
</div>
