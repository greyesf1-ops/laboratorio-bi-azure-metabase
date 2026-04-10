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
```

## Despliegue de servicios

Los servicios fueron desplegados con Docker Compose utilizando el siguiente archivo:
```text
services:
  postgres:
    image: postgres:16
    container_name: postgres_bi
    restart: unless-stopped
    environment:
      POSTGRES_DB: retail_db
      POSTGRES_USER: retail_user
      POSTGRES_PASSWORD: retail_pass_123
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  metabase:
    image: metabase/metabase:latest
    container_name: metabase_bi
    restart: unless-stopped
    ports:
      - "3000:3000"
    depends_on:
      - postgres

volumes:
  postgres_data:
```
## Configuración de la base de datos

La base de datos PostgreSQL fue creada dentro del contenedor con los siguientes parámetros:

Base de datos: retail_db
Usuario: retail_user
Contraseña: retail_pass_123

Se creó la tabla online_retail y se cargó el dataset desde un archivo CSV.

## Consideraciones sobre la carga del dataset

Durante la carga del archivo se identificó que:

el separador del archivo era ;
algunos campos necesitaban conversión de tipo
se utilizó una tabla temporal con campos de tipo texto para facilitar la importación
posteriormente se validó la carga correcta con un conteo total de registros

Cantidad total de registros cargados:
```text
SELECT COUNT(*) FROM online_retail;
```
## Resultado esperado:

541909

## Consultas utilizadas en el dashboard
## 1. Métrica global: ventas totales
```text
SELECT SUM(quantity * unit_price) AS ventas_totales
FROM online_retail;
```
## 2. Gráfica temporal: ventas por mes
```text
SELECT DATE_TRUNC('month', invoice_date) AS mes,
       SUM(quantity * unit_price) AS ventas
FROM online_retail
GROUP BY 1
ORDER BY 1;
```
## 3. Gráfica por producto: top 10 productos
```text
SELECT description,
       SUM(quantity * unit_price) AS ventas
FROM online_retail
GROUP BY description
ORDER BY ventas DESC
LIMIT 10;
```

## 4. Tabla o ranking: top 10 países
```text
SELECT country,
       SUM(quantity * unit_price) AS ventas
FROM online_retail
GROUP BY country
ORDER BY ventas DESC
LIMIT 10;
```

## Dashboard construido

El dashboard final incluye como mínimo:

una métrica global
una gráfica temporal
una gráfica por producto
una tabla o ranking
al menos un filtro

Estas visualizaciones permiten observar información útil sobre el comportamiento de ventas del dataset.

## Evidencias

Las capturas del proceso se encuentran en la carpeta:

docs/capturas/

## Resultados obtenidos

Se logró implementar correctamente un entorno funcional de Business Intelligence en la nube, conectando infraestructura, base de datos y visualización de datos. El laboratorio permitió construir indicadores y gráficos útiles a partir de un dataset real, cumpliendo con los requerimientos planteados.

## Conclusión

La práctica permitió comprender el proceso completo de implementación de una solución de Business Intelligence, desde la creación de infraestructura en la nube hasta la visualización de métricas en un dashboard interactivo. Además, se reforzó el uso de herramientas modernas como Azure, Docker, PostgreSQL y Metabase para el análisis de datos.
