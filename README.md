# Proyecto vacunatorio

Este proyecto ha sido creado para la cátedra de Ingeniería de Software de Ingeniería en Computación.

## Antes de empezar...

Este proyecto ha sido creado con las siguientes herramientas:
* Ruby - Versión 3.0.1p64
* Rails - Versión 6.1.4.1

## Configurando el repositorio

A continuación se detallan algunas de las cosas que tendrás que tener en cuenta para poder trabajar con este proyecto:

> Para el desarrollo de este proyecto haremos uso de Forking flow y Gitflow como flujos de trabajo, el primero, nos permitirá tener una copia de este repositorio en tu plataforma preferida (GitHub, BitBucket, etc.). Mientras que el segundo, nos permitirá seguir un flujo de trabajo más completo, con la finalidad de que podamos seguir una mejor organización de nuestro proyecto. Puedes encontrar más información sobre Forking flow [aquí](https://www.atlassian.com/es/git/tutorials/comparing-workflows/forking-workflow) y sobre Gitflow [aquí](https://www.atlassian.com/es/git/tutorials/comparing-workflows/gitflow-workflow).

1. Si estás usando GitHub, podrás hacer un fork de este repositorio en tu cuenta de GitHub. Mira como hacerlo [aquí](https://aprendegit.com/fork-de-repositorios-para-que-sirve/). Sino, si estás usando GitLab (u otro proveedor), primero deberás crear un **repositorio vacío** en tu propia cuenta.
2. Ahora, debes clonar este repositorio en tu ordenador:
    * Sí hiciste el fork en tu cuenta de GitHub, lo podrás hacer con el comando `git clone git@github.com:<username>/rails-vacunatorio.git`.
    * Sí en cambio, no estás usando GitHub, deberás clonar el repositorio vació que creaste, para ello, sigue las instrucciones de tu proveedor.
3. Ahora, ingresa al directorio raíz del proyecto.
4. Por default, en tu repositorio local `origin` apuntará a tu fork como repositorio remoto y tendrá como rama local `main`. Como trabajamos con Forking flow, deberás agregar un repositorio remoto secundario (`upstream`) al cual apuntará el repositorio local `origin`, para ello, usa el comando `git remote add upstream git@github.com:JandroMejia97/rails-vacunatorio.git`.
    > Si usas otro proveedor deberás bajarte lo que está en el repositorio remoto secundario (`upstream`), para ello, basta con ejecutar el comando `git pull upstream main` y luego subir todo al repositorio alojado en tu proveedor con el comando `git push origin main`.
5. Listo, ahora tienes tu repositorio en tu ordenador, que apunta a tu repositorio remoto (`origin`) y al repositorio remoto principal (`upstream`).
6. Ahora, debes crear una rama local (`develop`) en tu repositorio local `origin` para que puedas trabajar en ella. Para ello, ejecuta el comando `git checkout -b develop`.
7. Siguiendo Git flow, debes crear una rama local con el prefijo `feature/` más el nombre del feature que vas a trabajar en tu repositorio local `origin` para que puedas trabajar en ella. Para ello, ejecuta el comando `git checkout -b feature/<feature_name>`.
    > Por ejemplo, para el feature **inicio de sesión**, tu rama se llamaría `feature/inicio_de_sesion` y el comando a ejecutar sería `git checkout -b feature/inicio_de_sesion`.
8. Ahora solo faltaría instalar las dependencias del proyecto. Para ello, ejecuta el comando `bundle install` y `npm install`.
9. Para corroborar que todo funciona correctamente, ejecuta el comando `rails s`.

## README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
