#!/bin/bash
# Publica un archivo .json en un topico, usando como key el id de la entidad
# Uso: ./scripts/publicar-evento.sh solicitud-estado eventos/solicitud-estado.valido.json
TOPICO=$1
ARCHIVO=$2
KEY=$(grep -oE '"(solicitudId|prioridadId)":"[^"]+"' "$ARCHIVO" | head -1 | cut -d'"' -f4)
echo "topico=$TOPICO key=$KEY"
echo "$KEY|$(cat "$ARCHIVO")" | docker exec -i mesatech-kafka kafka-console-producer \
  --bootstrap-server kafka:29092 --topic "$TOPICO" \
  --property parse.key=true --property key.separator='|'
