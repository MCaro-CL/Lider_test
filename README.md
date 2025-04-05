Funcionalidad de la aplicación: Lider_test es una aplicación iOS en Swift que muestra un catálogo de productos, los filtra por categorías y permite agregarlos al carrito.
Arquitectura: Utiliza una arquitectura modular basada en Clean Architecture, adaptada a iOS con MVVM y un patrón de navegación Coordinator.
Capas de la arquitectura: La capa de Presentación, construida con UIKit, maneja la interfaz de usuario; la capa de Dominio contiene la lógica de negocio; y la capa de Datos interactúa con el servicio externo.
Capa de datos: Obtiene y almacena datos, incluyendo repositorios, fuentes externas y mapeadores para transformar datos.
Coordinador: Maneja la navegación entre pantallas de forma desacoplada, creando y presentando ViewControllers.
Estructura del código: Módulos organizados por funcionalidades principales (Home, ShoppingCart, Core) con la estructura interna de Clean Architecture.
Inyección de dependencias: El proyecto utiliza Swinject para la inyección de dependencias.
Reactividad de la vista: El proyecto utiliza RXSwift para implementar la reactividad entre ViewControllers y ViewModels.

Instrucciones de Ejecución:

1. Clona el proyecto Lider_test en tu máquina Mac. Si tienes un archivo .zip, extráigalo.
2. Abre el archivo Lider_test.xcodeproj en Xcode 13 o superior (Swift 5 y compatibilidad con iOS reciente).
3. Xcode debería descargar y resolver automáticamente las dependencias (Swinject, RxSwift). Si no, ve a File > Packages > Resolve Package Dependencies.
4. Selecciona un simulador de iPhone o un dispositivo físico conectado en Xcode.
Compile y ejecute: Pulse Run (▶️) en Xcode o use ⌘R para compilar y lanzar la aplicación.
