# Informe del laboratorio de Business Intelligence en Azure

## Introducción
En la actualidad, las herramientas de Business Intelligence permiten transformar grandes volúmenes de datos en información útil para la toma de decisiones. Sin embargo, no basta con comprender la teoría de métricas, KPIs y dashboards, sino que también es importante implementar una solución técnica real que integre infraestructura, almacenamiento y visualización de datos.

En este laboratorio se desarrolló un entorno funcional de Business Intelligence en la nube utilizando Microsoft Azure como plataforma de infraestructura, PostgreSQL como sistema gestor de base de datos y Metabase como herramienta de visualización. Para ello, se desplegó una máquina virtual Linux, se instalaron servicios mediante Docker, se cargó un dataset público y se construyó un dashboard analítico con varias visualizaciones.

## Objetivo general
Implementar un laboratorio funcional de Business Intelligence en la nube utilizando Azure, Docker, PostgreSQL y Metabase, con el propósito de cargar un dataset público y construir un dashboard interactivo con métricas y visualizaciones relevantes.

## Objetivos específicos
- Aprovisionar una máquina virtual Linux en Azure.
- Instalar Docker en la máquina virtual.
- Desplegar PostgreSQL y Metabase mediante contenedores.
- Cargar un dataset público en PostgreSQL.
- Conectar Metabase con PostgreSQL.
- Construir un dashboard con visualizaciones útiles para el análisis de datos.

## Herramientas utilizadas
- Microsoft Azure
- Ubuntu Server 24.04 LTS
- Docker
- Docker Compose
- PostgreSQL 16
- Metabase
- GitHub
- Visual Studio Code

## Desarrollo del laboratorio

### 1. Creación de la máquina virtual en Azure
Como primer paso, se creó una máquina virtual Linux en Microsoft Azure. Se seleccionó Ubuntu Server como sistema operativo y se configuró acceso remoto mediante SSH. También se configuró la red para permitir conectividad hacia la máquina virtual desde el exterior.

Posteriormente, se agregó una regla de entrada para habilitar el puerto 3000, necesario para el acceso web a Metabase.

### 2. Instalación de Docker
Una vez creada la máquina virtual, se realizó la conexión por SSH y se instaló Docker utilizando el repositorio oficial. Con esto fue posible desplegar servicios en contenedores y facilitar la administración del entorno.

La instalación fue validada mediante los comandos:

```bash
docker --version
docker compose version
```
## 3. Despliegue de PostgreSQL y Metabase

Con Docker ya instalado, se creó un archivo docker-compose.yml con dos servicios principales:

PostgreSQL para almacenamiento del dataset
Metabase para análisis y visualización

Después se levantaron ambos servicios con:
```text
sudo docker compose up -d
```

La ejecución fue validada con:
```text
sudo docker ps
```
lo cual confirmó que los contenedores postgres_bi y metabase_bi se encontraban en ejecución.

## 4. Configuración inicial de Metabase

Se accedió a Metabase desde el navegador usando la dirección IP pública de la máquina virtual seguida del puerto 3000. Luego se realizó la configuración inicial del usuario administrador y se conectó Metabase con la base de datos PostgreSQL creada en el contenedor.

Los datos de conexión utilizados fueron:
```text
Servidor: postgres
Puerto: 5432
Base de datos: retail_db
Usuario: retail_user
```
## 5. Carga del dataset en PostgreSQL

Se utilizó el dataset público Online Retail, el cual contiene información de ventas como factura, producto, descripción, cantidad, fecha, precio unitario, cliente y país.

Durante la carga del archivo se detectó que el separador correcto del CSV era ;, por lo que fue necesario importar primero los datos a una tabla temporal de tipo texto para luego convertir los tipos de datos a sus formatos correctos.

El proceso permitió cargar correctamente un total de:

541909 registros

Este valor fue validado mediante una consulta de conteo en PostgreSQL.

## 6. Consultas analíticas desarrolladas

Con los datos ya cargados, se elaboraron varias consultas SQL para construir las visualizaciones mínimas requeridas por la tarea.
```text
Ventas totales
SELECT SUM(quantity * unit_price) AS ventas_totales
FROM online_retail;
Ventas por mes
SELECT DATE_TRUNC('month', invoice_date) AS mes,
       SUM(quantity * unit_price) AS ventas
FROM online_retail
GROUP BY 1
ORDER BY 1;
Top 10 productos
SELECT description,
       SUM(quantity * unit_price) AS ventas
FROM online_retail
GROUP BY description
ORDER BY ventas DESC
LIMIT 10;
Top 10 países
SELECT country,
       SUM(quantity * unit_price) AS ventas
FROM online_retail
GROUP BY country
ORDER BY ventas DESC
LIMIT 10;
```
## Dashboard construido

El dashboard desarrollado en Metabase incluyó los siguientes elementos mínimos:

una métrica global de ventas totales
una gráfica temporal de ventas por mes
una gráfica por producto con los productos más vendidos
una tabla o ranking de países con mayores ventas
al menos un filtro de análisis

Estas visualizaciones permitieron responder preguntas básicas del dataset, como el comportamiento temporal de las ventas, los productos más relevantes y los países con mayor volumen de compra.

## Resultados obtenidos

El laboratorio fue implementado exitosamente. Se logró integrar la infraestructura en Azure, la base de datos PostgreSQL y la herramienta de visualización Metabase en una solución completamente funcional.

Además, se consiguió cargar y transformar el dataset, conectarlo a la plataforma BI y construir un dashboard con información útil y clara.

Dificultades encontradas

Durante el desarrollo se presentaron algunas dificultades técnicas, entre ellas:

configuración inicial de la máquina virtual en Azure
acceso por SSH
errores en la creación del archivo docker-compose.yml
carga del dataset debido al separador ;
actualización del esquema en Metabase

Estas dificultades fueron resueltas mediante ajustes en la configuración y validaciones paso a paso.

## Conclusiones

La práctica permitió desarrollar una experiencia completa en la implementación de un entorno de Business Intelligence en la nube. Se comprendió no solo la parte conceptual del análisis de datos, sino también la parte técnica relacionada con infraestructura, despliegue, almacenamiento y visualización.

El uso de Azure, Docker, PostgreSQL y Metabase demostró ser una combinación adecuada para construir soluciones analíticas funcionales. Además, trabajar con un dataset real permitió obtener resultados concretos y reforzar la importancia de los dashboards como apoyo para la toma de decisiones.

## Recomendaciones
Validar el formato de los archivos antes de cargarlos a la base de datos.
Usar nombres de archivos simples para evitar errores en rutas y comandos.
Documentar cada paso con capturas de pantalla para facilitar la evidencia de la práctica.
Detener la máquina virtual al finalizar para evitar costos innecesarios.
