## Reel

### DISCLAIMER:

Siguiendo los lineamientos propuestos para la prueba y ante los inconvenientes al usar recursos de Parse Server y Sharepoint se realizó mismo ejercicio con API The Movie Database

### Summary:

Ejercicio producto iOS para VALID

Catálogo cine REST

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
### More

* ATCWalkthroung

### TODO:
 
* Resolve import Parse Server and Sharepoint
* Issue YoutubePlayer-Swift at pod install and then Build 
Failed
* Offline-First for Explore
