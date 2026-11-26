# MesaTech Cloud: Kafka

Broker Kafka de un solo nodo con Zookeeper y Kafka UI, para el seguimiento operativo de la EP3.
Lo usan `ms-solicitudes` y `ms-catalogo` (repo `mesatech-backend-ep3`).

## Versiones

| Componente | Imagen |
|---|---|
| Kafka | `confluentinc/cp-kafka:7.9.0` |
| Zookeeper | `confluentinc/cp-zookeeper:7.9.0` |
| Kafka UI | `provectuslabs/kafka-ui:v0.7.2` |

Requisitos: Docker Engine y el plugin Docker Compose.

## Arranque

```bash
cp .env.example .env
docker compose config --quiet
docker compose up -d
docker compose ps
```

`KAFKA_EXTERNAL_HOST` es el nombre o la IP que Kafka anuncia a las aplicaciones.
En el PC se deja `host.docker.internal`. En AWS va la IP privada de la EC2 de Kafka.

## Topicos

Se crean solos con el servicio `kafka-topicos` (ver `scripts/crear-topicos.sh`), todos con 3 particiones:

| Topico | Uso |
|---|---|
| `solicitud-creada` | Se crea una solicitud |
| `solicitud-estado` | Cambia el estado de una solicitud |
| `prioridad-cambiada` | Cambia el nombre de una prioridad |
| `eventos-rechazados` | Eventos invalidos que el listener rechaza |

Para verlos:

```bash
docker exec mesatech-kafka kafka-topics --bootstrap-server localhost:29092 --describe
```

## Puertos

| Puerto | Uso | Quien debe llegar |
|---|---|---|
| 9092 | Kafka para las aplicaciones | Solo las EC2 de los microservicios |
| 8085 | Kafka UI (sin usuario ni clave) | Solo la IP administrativa, o cerrado |
| 2181 | Zookeeper | Solo dentro de Docker |

## Detencion

```bash
docker compose stop
```

No usar `docker compose down -v`: borra el volumen con los mensajes y los offsets.
