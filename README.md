#  Dokumentacja

## 1. Środowisko

Aplikacja została napisana w Xcode 10.2 (10E125) przy użyciu Swifta 5.
Zewnętrze biblioteki są zarządzane przez CocoaPods w wersji 1.6.1

Wszystkie zewnętrzne biblioteki zostały dodane do repoztorium git.
Projekt powinien uruchamiać się bez wstępnej konfiguracji. 

Istotny jest fakt że aplikacja była pisana z myślą o iPhone X. Inne modele nie zostały przetesowane, aplikacja powinna na nich działać ale elementy mogą nie być poprawnie rozmieszczone na ekranie.


## 2. Struktura projektu

Projekt wykorzystuje storyboardy do opisu przejść między ekranami (ViewControllerami).
Początkowy storyboard jest ustawiany w ustawieniach projektu (Gus2 -> General -> sekcja Deployment Info -> pole Main Interface)

Kontrolery są dodatkowo inicjalizowane w funkcji 
func prepare(for segue: UIStoryboardSegue, sender: Any?)

Używane są również unwindSegue tj funkcje postaci
```@IBAction func *******(with: UIStoryboardSegue)```
które umożliwiają powrot do definiującego je kontrolera.

Poszczególne kontrollery:

```NameMeViewController``` - obsługuje proces nazywania i rozmowy planety
```MainViewController``` - główny ekran gry z skaczącą planetą
```FlatQuestionViewController``` - ekran pytania
```CoreMLViewController``` - ekran rozpoznawania obrazu
```ShopViewController``` - ekran sklepu


## 3. Logika

Logika gry jest definiowana przez singleton  MainModel. Zarządza on:
1. Imieniem planety ```var name: String```
2. Stanem planety ```var happinesStream: Observable<Earth>```
3. Ilością posiadanych punktów ```var allCoinsStream: Observable<Int>```
4. przydzielaniem punktów zapoprawną odpowiedź ```func correctAnswer()```
5. zabieraniem punktów za błędną odpowiedź  ```func wrongAnswer()```
6. zakupionymi przedmiotami ```var ownShopCategories: Variable<Set<ShopCategory>>```
7. zmniejszaniem zadowolenia wraz z upływem czasu ```func timerTick()```
8. kolejnymi zadaniami które ma dla nas planeta ```let taskStream: Observable<Task>```


## 4. Definiowanie zadań

Lista dostępnych zadań definiowana jest w pliku Task.swift 
Istnieją 3 typy zadań:

```Question``` - definiuje standardowe pytanie
```ClassificationTask``` - definiuje zadanie na rozpoznawanie obrazu
```.waiting``` - definuje okres oczekiwania na kolejne zadania


# Documentation


## 1. Environment 

Application was written in Xcode 10.2 (10E125) with Swifta 5.
External liblaries are handled by CocoaPods 1.6.1

Every library is included inside git repository so it should compile without any extra steps.

Important thing is that durring development process we were targeting iPhone X only. It
should work on different phones but layout of elements may be invalid.


## 2. Structure of the project

Project is using storyboard for transitions between views (ViewControllers)
Initial storyboard is set in project settings (Gus2 -> General -> section Deployment Info -> field Main Interface)

Controllers are initialized before transiton in function 
func prepare(for segue: UIStoryboardSegue, sender: Any?)

Additionaly we are using unwindSegue i.e.
```@IBAction func *******(with: UIStoryboardSegue)``` 
that allows going back to controller that implements them.

List of controllers:
```NameMeViewController``` - Handles process of giving name to our planet and small talk with it 
```MainViewController``` - Main view with jumping planet
```FlatQuestionViewController``` - View with question
```CoreMLViewController``` - view with image recognition
```ShopViewController``` - shop view


## 3. Logic


Game logic is defined by MainModel singleton. It handles:
1. Name of the planet  ```var name: String```
2. State of the planet  ```var happinesStream: Observable<Earth>```
3. Count of the points  ```var allCoinsStream: Observable<Int>```
4. reward for correct answer ```func correctAnswer()```
5. penalty for wrong answer ```func wrongAnswer()```
6. bought items ```var ownShopCategories: Variable<Set<ShopCategory>>```
7. updating plante state over time ```func timerTick()```
8. schedulnig next tasks ```let taskStream: Observable<Task>```


## 4. Tasks

List of possible tasks is definied inside Task.swift file
there are 3 types of tasks:


```Question``` - describes question
```ClassificationTask``` - describes image recognition task
```.waiting``` - defines period without any task
