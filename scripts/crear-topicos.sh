#!/bin/bash
# Crea los topicos de MesaTech con 3 particiones (si ya existen, no hace nada)
SERVIDOR=kafka:29092

for topico in solicitud-creada solicitud-estado prioridad-cambiada eventos-rechazados; do
  kafka-topics --bootstrap-server $SERVIDOR --create --if-not-exists \
    --topic $topico --partitions 3 --replication-factor 1
done

kafka-topics --bootstrap-server $SERVIDOR --list
