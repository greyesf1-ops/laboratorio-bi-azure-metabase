# Laboratorio de Business Intelligence en Azure con PostgreSQL y Metabase

## Descripción
Este proyecto consiste en la implementación de un laboratorio funcional de Business Intelligence en la nube utilizando Microsoft Azure, Docker, PostgreSQL y Metabase. El objetivo fue desplegar una máquina virtual Linux, instalar servicios mediante contenedores, cargar un dataset público y construir un dashboard funcional con métricas y visualizaciones.

## Objetivo
Implementar una solución técnica real de Business Intelligence que permita:

- aprovisionar infraestructura básica en Azure
- desplegar servicios utilizando contenedores
- cargar datos en PostgreSQL
- conectar Metabase a PostgreSQL
- construir visualizaciones útiles a partir de datos reales

## Tecnologías utilizadas
- Microsoft Azure
- Ubuntu Server 24.04 LTS
- Docker
- Docker Compose
- PostgreSQL 16
- Metabase
- Git y GitHub

## Arquitectura de la solución
La solución fue implementada de la siguiente manera:

- una máquina virtual Linux en Azure
- un contenedor PostgreSQL para almacenamiento de datos
- un contenedor Metabase para visualización y análisis
- conexión entre Metabase y PostgreSQL dentro de la misma VM
- dashboard analítico construido a partir del dataset cargado

## Dataset utilizado
Se utilizó el dataset **Online Retail**, el cual contiene información de transacciones comerciales como número de factura, producto, descripción, cantidad, fecha, precio unitario, cliente y país.

El archivo original fue trabajado en formato CSV y cargado en PostgreSQL para su análisis posterior en Metabase.

## Estructura del proyecto
```text
laboratorio-bi-azure-metabase/
│
├── README.md
├── docker-compose.yml
├── .gitignore
│
├── sql/
│   ├── 01_create_table.sql
│   ├── 02_load_notes.sql
│   └── 03_views_queries.sql
│
└── docs/
    ├── informe.md
    └── capturas/
