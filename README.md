## Reel

### Summary:

Ejercicio catálogo cine REST

### Architect:

Pattern MVVM

* Model
** Show *Entidad que representa una película

* View Model
** SummaryViewModel *Gestor contenidos para vistas

* View
** SummaryViewController *Vista películas
** ShowViewControlleer *Vista película

* Networking
** Request *Gestor servicios
** OnlineManager *Gestor conectividad

* Data
** DatamManager *Abstracción caché
** DiskManager *Implementación caché para pod Disk

* RxSwift
** RxManager *Gestor observadores
** Observer *Observador verificar conectividad
### Pod

* Alamofire
* YoutubePlayer-Swift
* Disk
* RxSwift
* RxCocoa

### Theory Test:

1. Principio de responsabilidad única: Toda abstracción debe hacerse cargo de una responsabilidad. De acuerdo a Single (S - SOLID)

2. Un buen código, o "limpio" es un código simple de forma que sea entendible en su lectura y mantenible por más escritores

### TODO:
 
* Issue YoutubePlayer-Swift at pod install and then Build 
Failed
* Offline-First for Explore
* Add Firebase
* Unit Tests