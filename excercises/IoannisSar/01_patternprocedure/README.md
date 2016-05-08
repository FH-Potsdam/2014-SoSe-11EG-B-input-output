#Musteranweisung Pt.1

Die Aufgabe bestand darin, sich eine Anweisung für eine Form oder ein Muster zu überlegen. Diese wurde dann in kurzen Schritten niedergeschrieben und dann von jedem im Raum einmal ausgeführt. Hierbei entstanden viele reizvolle Ergebnisse. Gerade dann, wenn sich Ausführungen mit derselben Anweisung komplett voneinander unterschieden.

</br>

###Analoge Musteranweisung:

1. Wie viel Uhr ist es gerade?
 
2. Bilder die Quersumme aus Stunde und Minute

3. Zeichne nun ein winkliges Objekt. Das Ergebnis der Quersumme gibt dir vor, aus wie vielen Seiten es bestehen soll

4. Zeichne dieses Objekt ein weiteres mal auf dein Blatt, die Positionierung und Größe spielt dabei keine Rolle, beide Objekte dürfen sich jedoch nicht 
Unterscheiden.

5. Verbinde alle entstandenen Eckpunkte beider Formen miteinander, hierbei dürfen sich die Linien mal überschneiden. Alle Eckpunkte müssen zum Schluss belegt sein.

6. Fülle nun zwei der neu entstandenen Flächen deiner Wahl aus.

7. Verbinde nun wieder die Eckpunkte der beiden Flächen die du ausgemalt hast und male die dabei neu entstandene Form komplett aus, sodass eine neue Fläche entsteht. 

</br>

###Enstandene Zeichnungen nach der Anweisung

![pp_sketch_01](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/01_patternprocedure/02_images/pp_sketch_01.jpg)

![pp_sketch_03](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/01_patternprocedure/02_images/pp_sketch_02.jpg)

![pp_sketch_03](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/01_patternprocedure/02_images/pp_sketch_03.jpg)

</br>

#Musteranweisung Pt.2
Im nächsten Schritt ging es dann darum, diesen analogen, von Menschenhand erzeugten Vorgang mit Hilfe von Processing ins Digitale zu übersetzen.

</br>

###Die Musteranweisung in Processing übersetzen


Hier tat ich mich schwer, da ich noch nie zuvor mit dem Programm in Berührung bekommen bin, doch dank Timo's Unterstützung bin ich dem Sketch zumindest etwas näher gekommen. Wir haben es schließlich soweit gebracht, dass sich 2 Flächen mit der gleichen Anzahl an Seiten willkürlich im Raum verteilen können und sich deren Eckpunkte dann durch Linien miteinander verbinden. Durch das Tippen auf die Leertaste generierten sich jedesmal neue Konstrukte mit unterschiedlich vielen Seiten: zwischen 3 & 1000. Diese Variable konnte man nach Wunsch verändern.

</br>

###Processing Code

```
/* 
 sketch_140423f_shape 
 */
import processing.pdf.*;

Shape MyForm;
Shape MyForm2;

void setup() {
  size (1300,  1300);
  beginRecord (PDF, "vectors.pdf");

  create();
}

void create() {

  int EdgeCount = int(random(3, 3)); 
  MyForm = new Shape(EdgeCount);
  MyForm2 = new Shape(EdgeCount);
} 


void draw() {

  background(255);
  strokeWeight(4);
  stroke(255,79,68);
  MyForm.display();
  MyForm2.display();
  for (int i = 0; i< MyForm.Edges.size(); i++) {
    PVector p= MyForm.Edges.get(i);
    PVector p2= MyForm2.Edges.get(i);
    line(p.x, p.y, p2.x, p2.y);
  }
}

void keyPressed() {
  create();
  if (key == 'q') {
    endRecord (); 
  }
}
```
</br>

###Screenshots

![pp_processing_01](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/01_patternprocedure/02_images/pp_processing_01.jpg)

![pp_processing_02](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/01_patternprocedure/02_images/pp_processing_02.jpg)

![pp_processing_03](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/01_patternprocedure/02_images/pp_processing_03.jpg)

</br>

#Musteranweisung Pt.3


Nachdem wir unseren Sketch digitalisiert hatten, folgte der finale Teil der Aufgabe. Der Gedanke hier hinter hat mich besonders beeindruckt, denn wir sollten die komputativ entstandenen Resultate des Sketches in die Realität legen und uns Gedanken um ein Anwendungsbeispiel machen. Nach einigen Clicks entstand dann ein Gebilde, woraus ich schließlich einen Lampenschirm aus Beton kreierte.

</br>

###Anwendung des Musters


![pp_inuse_01](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/01_patternprocedure/02_images/pp_inuse_01.jpg)
