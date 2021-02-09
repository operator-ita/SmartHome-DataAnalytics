
<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/operator-ita/SmartHome-DataAnalytics">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">SmartHome-DataAnalytics</h3>

  <p align="center">
    Análisis estadístico de dos casas inteligentes multiresidenciales para prober de percepción a los datos y brindar toma de desiciones en los rubros de seguridad, salud, dinámica de los habitantes y más.  
    <br />
    <a href="https://github.com/operator-ita/SmartHome-DataAnalytics"><strong>Ver documentación »</strong></a>
    <br />
    <br />
    <a href="https://github.com/operator-ita/SmartHome-DataAnalytics">Ver dashboard</a>
    ·
    <a href="https://github.com/operator-ita/SmartHome-DataAnalytics/issues">Reportar un error</a>
    ·
    <a href="https://github.com/operator-ita/SmartHome-DataAnalytics/issues">Solicitar un cambio</a>
  </p>
</p>


<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Tabla de contenido</summary>
  <ol>
    <li>
      <a href="#Acerca-del-proyecto">Acerca del proyecto</a>
      <ul>
        <li><a href="#SmartHome-DataAnalytics">SmartHome</a></li>
        <li><a href="#Justificación">Justificación</a></li>
      </ul>
    </li>
    <li>
      <a href="#Dashboard">Dashboard en Shiny</a>
      <ul>
        <li><a href="#Especificaciones">Especificaciones</a></li>
      </ul>
    </li>
    <li><a href="#Datasets">Bases de datos</a></li>
    <li><a href="#Contacto">Contacto</a></li>
    <li><a href="#Referencias">Referencias</a></li>
    <li><a href="#Recursos">Recursos</a></li>
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## Acerca-del-proyecto

[![Product Name Screen Shot][product-screenshot]](https://github.com/operator-ita/SmartHome-DataAnalytics)


### SmartHome-DataAnalytics
Imagina que cada segundo se registraran tus movimientos y actividades que realizas en tu casa durante un mes ¿Sería posible predicir cuánto tiempo vas a dedicar a una actividad? ¿Determinar la dinámica entre las personas en la casa? ¿Saber quién realiza más que haceres?

En éste repo nos hemos propuesto exactamente éso, para lo cual analizamos la base de datos __ARAS__  con un enfoque diferente al problema de múltiples residentes tratandolo como series de tiempo.

Éste proyecto fué entragado como evaluación para el bootcamp de Data analyst de __BEDU__.  

### Justificación 
* El internet de las cosas es un campo que va en aumento, cada día nuevos dispositivos son agregados a la red de internet. Masivas cantidades de datos sin procesar son generados por sensores y actuadores cada segundo, a la espera de analistas de datos.
* En las casas multiresidenciales cada persona es una variable, lo que hace el problema de la predicción y el análisis un problema multidimencional, razón por la que éste tipo de problemas suele ser abordado por RRN u otro tipo de redes neuronales. En éste proyecto abordamos el tema con series de tiempo tanto para la predicción como para busqueda de patrones de compartamiento. 



<!-- GETTING STARTED -->
## Dashboard
Porques sabesmos que una imagen dice más de mil palabras, incluimos un dashboard dinámico con la libraría de `shiny`. Da click a la liga para explorar el compartamiento de las personas en cada casa. El contenido está dividido en: 
- Pestaña general: Un gráfica de barra dinámica de como emplea el tiempo cada uno de los sujetos de estudio en su casa. 
- Series de tiempo: 
  1. Series de tiempo por día del tiempo empleado en cada actividad por persona y su descomposición adivitiva para observar si existe alguna rutina.    
  2. Buscador de variables dependientes graficando dos series de tiempo multivariables. 
- Tipo de actividad: La dinámica de interacción entre los recidentes se explora con el tiempo que pasan realizando actividades colaborativas y la repartición del trabajo.  
  1. Las actividades colaborativas se determinan apartir del tiempo en que ambos realizan la misma actividad. 
  2. Mediante un cociente de tiempo empleado en recreación contra el tiempo empleado para que haceres en casa se determina el tipo de repatación de trabajo doméstico.
![](images/shiny.png)


## Especificaciones
### Contruido-con-r

El código aquí incluido está realizado en su totalidad en R.  
* [R](https://rstudio.com/)

### Prerequisitos 
- Rstudio instalados

<!-- USAGE EXAMPLES -->
## Datasets

### Aras Database

_Para más información de la base de datos, refierase a [Aras Documentation](https://www.researchgate.net/publication/261054388_ARAS_Human_Activity_Datasets_in_Multiple_Homes_with_Multiple_Residentsm)_



<!-- CONTRIBUTING -->
## Por hacer

- [ ] Comparar el análisis realizado con series de tiempo contra el obtenido con RNN

<!-- LICENSE -->
## Licencia
Distributed under the MIT License. See `LICENSE` for more information.


<!-- CONTACT -->
## Contacto
Equipo 14: 
- Lara Guzmán Elías David
- Luis Fernando Jiménez Hernández
- Mario Alan Cantú Cantero

<!-- ACKNOWLEDGEMENTS -->
## Referencias
* [ARAS Dataset](http://aras.cmpe.boun.edu.tr/download.php)
* [BEDU](https://bedu.org/)

<!-- Resources -->
## Recursos 
* [CONDA](https://docs.anaconda.com/anaconda/user-guide/tasks/using-r-language/)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: images/demo.gif
