# Primzahlen Sieb


## Aufgaben Analyse
Das Primzahlen-Sieb ist ein Erathosthenesescher Algorithmus.
Als Ausgangslage wird eine Auflistung aller Zahlen (in unseren Fall 1-1000) benötigt. 
Ziel ist es dabei bei der ersten Primzahl(2) zu starten und anschließend alle vielfachen (4,6,8,10...) zu berechnen und diese aus der Lister zu streichen. Nun wird das Nächste Feld/Zahl genommen, die noch nicht herrausgestrichen wurde. Das ist eine neue Primzahl. Auch für diese berechnen wir die Vielfachen (nächste Zahl wäre 3. Die Vielfachen sind 6,9,12...). Nun wiederholt sich der Vorgang. Zu Schluss stehen nur noch die Primzahlen und alle anderen wurden herrausgestrichen bzw. als ungültig markiert.


## Programm in Java
```java

boolea[] primzahlenTafel = new boolean[1001]; // Erstellen der Zahlen-Liste (alle Elemente sind False) False Bedeutet ist eine Primzahl.

public boolean[] primzahlenSieb(boolean[1001] arry){
    for(int i=2; i<=1000; i++)  //(index entspricht zugleich unserere Zahl in der Liste)
    {
        if(arry[i] == False){   // Wenn Primzahl
            int noPrimzahl = 0; 
            for(int j=i; noPrimzahl<=1000; j++)  // Markiere die Vielfachen von der Primzahl
            {
                noPrimzahl = i*j;
                arry[noPrimzahl] = True;  // Alles was True ist ist keine Primzahl!
            }
        }
    }
    return arry;
}
```

## ASM Datentypen

- **primzahlenTafel**: Für die Lister würde ich 16 Wörter verwenden und mittels einen Offset durch die einzelnen Bits iterrieren.       (64-Bit*16=1024-Bits; Das sind minimal zuviele, dafür erhoffe ich mir aber eine einfache Umsetzung).

- **i,j**: Für beides reicht ein Halbwort

- **noPrimzahl**: Max Zahl die diese Var erreichen darf ist 1000. Ein Halbword recht aus.
