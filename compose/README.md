<p align="center">
<img src="./docs/app_doc/_media/tup.png" max-width="400" height="200">
</p>

# TPI Laboratorio Castillo Chidak 2025

> Este proyecto es parte del Trabajo Práctico Integrador (TPI) realizado
> durante el año 2025, de las asignaturas Programación IV y 
> Metodología de Sistemas II de la carrera "Tecnicatura Universitaria
> en Programación" de la "Universidad Tecnológica Nacional -
> Facultad Regional Córdoba".

## Prerequisites

* Install [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) to clone the repository,
* Install [Docker Engine](https://docs.docker.com/get-docker/) and
  [Docker Compose](https://docs.docker.com/compose/install/) as standalone binaries or
  install [Docker Desktop](https://docs.docker.com/desktop/) which includes both Docker Engine and Docker Compose.

## Execution

1. Clone the repository

```bash
git clone https://github.com/2025-P4-BE/tpi-compose.git
```

2. Open git bash in the project root folder
3. Build and run your app with Compose

```bash
docker compose up
```

4. Alternative: you can also start the application by running the `startApplication.sh` script


5. Enter http://localhost:8080 in a browser to see the application running.

## Usage

1. Login with the following credentials:

```
email: superadmin@example.com
password: Superadmin
```
> If you want to use another role, you can use the following credentials:

| Role                 | Email                 | Password  |
|----------------------|-----------------------|-----------|
| Superadmin           | example@example.com   | Example   |

> [!WARNING]
> This credential are only for testing purposes. In a real application, the credentials would be provided by the administrator.

2. Port convention

| Microservice       | Backend Port | Database Port |
|--------------------|--------------|---------------|
| Nbu                | 8001         | 3301          |
| Users              | 8002         | 3302          |
| Pacients           | 8003         | 3303          |
| Coverages          | 8004         | 3304          |
| Appointments       | 8005         | 3305          |
| Billing Collection | 8006         | 3306          |
| Analytical Mng     | 8007         | 3307          |
| Pre Analytical     | 8008         | 3308          |
| Analytical         | 8009         | 3309          |
| Post Analytical    | 8010         | 3310          |
| Stock Mng          | 8011         | 3311          |
| Configuration Mng  | 8012         | 3312          |
| Analytical Machine | 8013         | 3313          |
| Attention          | 8014         | 3314          |
