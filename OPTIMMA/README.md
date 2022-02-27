# Program OPTIMMA
Użycie dowolnego modelu konstytutywnego w obliczeniach inżynierskich wymaga określenia odpowiednich parametrów materiałowych na podstawie danych eksperymentalnych. Może to być trudne, gdy liczba parametrów jest znaczna lub ich wartości nie wynikają w prosty sposób z badań laboratoryjnych. Program **OPTIMMA** pozwala użytkownikowi na analizowanie zbiorów danych eksperymentalnych oraz kalibrację (dobór parametrów) modelu konstytutywnego w części lepkosprężystej. Autorski program został opracowany w języku Python z wykorzystaniem bibliotek Numpy, Scipy oraz Matplotlib. Składa się z modułów, które są obiektową reprezentacją: danych eksperymentalnych, modelu konstytutywnego, krzywej wiodącej, funkcji przesunięcia, procedury optymalizacyjnej. Dzięki temu możliwe jest swobodne łączenie i wykorzystanie modułów w postaci skryptu języka Python. Podstawowy scenariusz użycia, tzn. dobór parametrów szeregu Prony'ego, składa się z następujących elementów:   
- Wczytanie danych eksperymentalnych z pliku XML.
- Dobranie parametrów krzywej wiodącej i funkcji przesunięcia.
- Kalibracja modelu w szerokim zakresie częstotliwości i temperatur, na podstawie danych i funkcji przesunięcia.
- Zapisanie wyniku optymalizacji oraz graficzna prezentacja wyników.   

Narzędzie stanowi implementację procedury zaproponowanej w rozdziale **4.5 Algorytm doboru parametrów**, dzięki której możliwe jest wykorzystanie wyników badań laboratoryjnych do wyznaczenia parametrów modelu reologicznego. Do przechowywania wyników badań laboratoryjnych zaproponowano język XML (eXtensible Markup Language), przeznaczony do reprezentowania danych w strukturalizowany, jednolity sposób. Warunkiem jest dostępność wyników testów cyklicznych (DMA) w różnych temperaturach. Wyniki mają postać składowych modułu zespolonego (moduł zachowawczy i stratności) lub wartości modułu dynamicznego oraz kąta przesunięcia fazowego. Narzędzie umożliwia graficzną reprezentację wyników (pakiet matplotlib) na każdym etapie obliczeń. Duża część rysunków zamieszczonych w pracy została wykonana przy pomocy OPTIMMA.

<p align="center">
  <img src="https://github.com/RafalMichalczyk/PavementDesign/blob/main/imgs/OPTIMMA_flow.png?raw=false" alt="Struktura programu w przypadku doboru parametrów szeregu Prony’ego"/>
</p> 

*Fig. Struktura programu w przypadku doboru parametrów szeregu Prony’ego.*

# Everything is moving to the cloud ...

Trwają prace nad uruchomieniem programu w serwisie AWS. Pozwoli to każdemu użytkownikowi na prowadzenie obliczeń bez konieczności instalowania jakiegokolwiek oprogramowania. Jednocześnie wymaga to od autorów dostosowania kodu programu do nowych wymagań. Jeśli z jakiegoś powodu jesteś zainteresowany poprzednią, statyczną wersją aplikacji - prosimy o kontakt.  
<p align="center">
  <img src="https://github.com/RafalMichalczyk/PavementDesign/blob/main/imgs/aws_migration.jpg?raw=false" alt="Everything moving to the cloud"/>
</p>
