# Program BURMISTER
Program **BURMISTER** został stworzony w celu obliczania przemieszczeń, naprężeń i odkształceń w dowolnym punkcie nawierzchni drogowej. Autorski program wykorzystuje model wielowarstwowej półprzestrzeni sprężystej. Ścisłe rozwiązanie tego zadania we współrzędnych walcowych, przy wykorzystaniu symetrii obciążenia względem osi pionowej, zostało po raz pierwszy podane w roku 1943 przez **Donalda Burmistera** dla przypadku dwóch warstw, a następnie rozszerzone w roku 1945 na przypadek trzech warstw. Program jest implementacją rozwiązania ogólnego (dowolna liczba warstw) z zastosowaniem biharmonicznej funkcji naprężeń, które przedstawiono w pracy **"Mechanika nawierzchni drogowej"** (Stefan Firlej, Lublin 2007, ISBN 978-83-918460-8-7). W rozwiązaniu analitycznym takiego modelu nawierzchni drogowej występują funkcje podcałkowe, które nie pozwalają na otrzymanie funkcji pierwotnej i wymagają zastosowania metod całkowania numerycznego.
Program składa się z dwóch głównych części: modułu obliczeniowego oraz graficznego interfejsu użytkownika (GUI). Do obliczeń matematycznych, zwłaszcza całkowania numerycznego, wykorzystano bibliotekę Python Numpy. GUI opracowano przy użyciu biblioteki klas wxWidgets. Podstawowe funkcjonalności oferowane przez program to:

- Wprowadzania danych (liczba i układ warstw, materiały, obciążenia).
- Zapisywanie parametrów zadania w postaci pliku tekstowego.
- Import parametrów zadania z pliku tekstowego.
- Przeprowadzenie badania i oceny zbieżności rozwiązania (zależne od liczby iteracji w całkowaniu numerycznym).
- Zmiana ustawień podstawowych (np. liczba iteracji) 
- Rozwiązanie zadania - wyznaczenie przemieszczeń, odkształceń i naprężeń w danym punkcie półprzestrzeni.

Dużą zaletą podsiadania takiego programu jest możliwość łatwej analizy wpływu danego parametru na rozwiązanie. W pracy program wykorzystano np. do doboru gęstości podziału w~zadaniach MES, poprzez porównania zgodności wyników MES z rozwiązaniem analitycznym. Wyniki posłużyły także jako wzorzec do porównania z bardziej zaawansowanymi rozwiązaniami niesprężystymi. Głównym ograniczeniem opracowanego programu jest wyliczania rozwiązania tylko w punkcie. Brak możliwości automatycznego tworzenia wykresów zmian danej wielkości np. po głębokości czy rozkładów w postaci map warstwicowych. Dużą zaletą programu jest budowa modułowa, która umożliwia dodanie kolejnych elementów dla wzbogacenia aplikacji (np. moduł obliczający trwałość układu warstw nawierzchni na podstawie wyliczonych stanów odkształceń oraz zadanych parametrów materiałowych i wytrzymałościowych).

<p align="center">
  <img src="https://github.com/RafalMichalczyk/PavementDesign/blob/main/imgs/brmstr_win1.png?raw=false" alt="Główne okno programu z pokazanymi opcjami menu"/>
</p> 

*Fig. Główne okno programu z pokazanymi opcjami menu.*

<p align="center">
  <img src="https://github.com/RafalMichalczyk/PavementDesign/blob/main/imgs/brmstr_win2.png?raw=false" alt="Okno wyswietlaj˛ace informacje o wersji programu"/>
</p> 

*Fig. Okno wyswietlające informacje o wersji programu.*

# Everything is moving to the cloud ...

Trwają prace nad uruchomieniem programu w serwisie AWS. Pozwoli to każdemu użytkownikowi na prowadzenie obliczeń bez konieczności instalowania jakiegokolwiek oprogramowania. Jednocześnie wymaga to od autorów dostosowania kodu programu do nowych wymagań. Jeśli z jakiegoś powodu jesteś zainteresowany poprzednią, statyczną wersją aplikacji - prosimy o kontakt.  

<p align="center">
  <img src="https://github.com/RafalMichalczyk/PavementDesign/blob/main/imgs/aws_migration.jpg?raw=false" alt="Everything moving to the cloud"/>
</p> 
