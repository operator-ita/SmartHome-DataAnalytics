
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
    <a href="https://www.youtube.com/watch?v=7yh9i0PAjck&ab_channel=cosmicrat">Ver dashboard</a>
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
        <li><a href="#Contruido-con-r">Construido con r</a></li>
      </ul>
    </li>
    <li>
      <a href="#Configuraciones iniciales">Getting Started</a>
      <ul>
        <li><a href="#Prerequisitos">Prerequisites</a></li>
        <li><a href="#Instalación">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
    <li><a href="#resources">Resources</a></li>
  </ol>
</details>






<!-- ABOUT THE PROJECT -->
## Acerca-del-proyecto

[![Product Name Screen Shot][product-screenshot]](https://bedu.com)



Imagina que cada segundo se registraran tus movimientos y actividades que realizas en tu casa durante un mes. ¿Sería posible predicir cuánto tiempo vas a dedicar a una actividad? ¿Determinar la dinámica entre las personas en la casa? ¿Saber quién realiza más que haceres?

En éste repo nos hemos propuesto exactamente éso, para lo cual analizamos la base de datos __ARAS__  con un enfoque diferente al problema de múltiples residentes tratandolo como series de tiempo.


### Justificación 
* El internet de las cosas es un campo que va en aumento, cada día nuevos dispositivos son agregados a la red de internet. Masivas cantidades de datos sin procesar son generados por sensores y actuadores cada segundo, a la espera de analistas de datos.
* En las casas multiresidenciales cada persona es una variable, lo que hace el problema de la predicción y el análisis un problema multidimencional, razón por la que éste tipo de problemas suele ser abordado por RRN u otro tipo de redes neuronales. En éste proyecto abordamos el tema con series de tiempo tanto para la predicción como para busqueda de patrones de compartamiento. 



### Contruido-con-r

El código aquí incluido está realizado en su mayoría en R.  
* [R](https://rstudio.com/)




<!-- GETTING STARTED -->
## Getting Started
Try the same procedure to your our data. Here is how: 

### Prerequisites
- Anaconda
- Rstudio

1. Create a environment 
  ```sh
  conda create --prefix=/home/david/github/data-science/bedu/Programacion-con-R-Santander/r-environment r-essentials r-base
  ```

### Installation

 
1. Clone the repo
   ```sh
   git clone https://github.com/operator-ita/SmartHome-DataAnalytics
   ```
2. Load our R environment
   ```sh
   conda activate renv
   ```
3. Deactivate
  ```sh
  conda dactivate
  ```



<!-- USAGE EXAMPLES -->
## Datasets

### Aras Database

_For more info, refer to [Aras Documentation](https://www.researchgate.net/publication/261054388_ARAS_Human_Activity_Datasets_in_Multiple_Homes_with_Multiple_Residentsm)_



<!-- CONTRIBUTING -->
## To do

- [ ] Activity prediction on ARAS dataset
- [ ] Security improvements
- [ ] Improvements in energy saving
- [ ] Health alert for bad habits
- [ ] Comfort
- [ ] More

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.


<!-- CONTACT -->
## Contact

Lara Guzmán Elías David - [@Linkedin](https://www.linkedin.com/in/fi-eguzman/) 

Project Link: [@Github Repo](https://github.com/your_username/repo_name)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [ARAS Dataset](http://aras.cmpe.boun.edu.tr/download.php)
* [BEDU](https://bedu.org/)

<!-- Resources -->
## Resources
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
