# Program BURMISTER
Program **BURMISTER** zosta� stworzony w celu obliczania przemieszcze�, napr�e� i odkszta�ce� w dowolnym punkcie nawierzchni drogowej. Autorski program wykorzystuje model wielowarstwowej p�przestrzeni spr�ystej. �cis�e rozwi�zanie tego zadania we wsp�rz�dnych walcowych, przy wykorzystaniu symetrii obci��enia wzgl�dem osi pionowej, zosta�o po raz pierwszy podane w roku 1943 przez **Donalda Burmistera** dla przypadku dw�ch warstw, a nast�pnie rozszerzone w roku 1945 na przypadek trzech warstw. Program jest implementacj� rozwi�zania og�lnego (dowolna liczba warstw) z zastosowaniem biharmonicznej funkcji napr�e�, kt�re przedstawiono w pracy **"Mechanika nawierzchni drogowej"** (Stefan Firlej, Lublin 2007, ISBN 978-83-918460-8-7). W rozwi�zaniu analitycznym takiego modelu nawierzchni drogowej wyst�puj� funkcje podca�kowe, kt�re nie pozwalaj� na otrzymanie funkcji pierwotnej i wymagaj� zastosowania metod ca�kowania numerycznego.
Program sk�ada si� z dw�ch g��wnych cz�ci: modu�u obliczeniowego oraz graficznego interfejsu u�ytkownika (GUI). Do oblicze� matematycznych, zw�aszcza ca�kowania numerycznego, wykorzystano bibliotek� Python Numpy. GUI opracowano przy u�yciu biblioteki klas wxWidgets. Podstawowe funkcjonalno�ci oferowane przez program to:

- Wprowadzania danych (liczba i uk�ad warstw, materia�y, obci��enia).
- Zapisywanie parametr�w zadania w postaci pliku tekstowego.
- Import parametr�w zadania z pliku tekstowego.
- Przeprowadzenie badania i oceny zbie�no�ci rozwi�zania (zale�ne od liczby iteracji w ca�kowaniu numerycznym).
- Zmiana ustawie� podstawowych (np. liczba iteracji) 
- Rozwi�zanie zadania - wyznaczenie przemieszcze�, odkszta�ce� i napr�e� w danym punkcie p�przestrzeni.

Du�� zalet� podsiadania takiego programu jest mo�liwo�� �atwej analizy wp�ywu danego parametru na rozwi�zanie. W pracy program wykorzystano np. do doboru g�sto�ci podzia�u w~zadaniach MES, poprzez por�wnania zgodno�ci wynik�w MES z rozwi�zaniem analitycznym. Wyniki pos�u�y�y tak�e jako wzorzec do por�wnania z bardziej zaawansowanymi rozwi�zaniami niespr�ystymi. G��wnym ograniczeniem opracowanego programu jest wyliczania rozwi�zania tylko w punkcie. Brak mo�liwo�ci automatycznego tworzenia wykres�w zmian danej wielko�ci np. po g��boko�ci czy rozk�ad�w w postaci map warstwicowych. Du�� zalet� programu jest budowa modu�owa, kt�ra umo�liwia dodanie kolejnych element�w dla wzbogacenia aplikacji (np. modu� obliczaj�cy trwa�o�� uk�adu warstw nawierzchni na podstawie wyliczonych stan�w odkszta�ce� oraz zadanych parametr�w materia�owych i wytrzyma�o�ciowych).

