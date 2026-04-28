#!/bin/bash
# Script para ejecutar comandos de Liquibase desde el backend
# ========================================================

echo "Ejecutando Liquibase desde Backend..."
echo

# Verificar que Maven esté disponible
if ! command -v mvn &> /dev/null && [ ! -f "./mvnw" ]; then
    echo "ERROR: Maven no está instalado y no se encuentra mvnw"
    echo "Instala Maven o usa el wrapper incluido"
    exit 1
fi

# Usar mvnw si existe, sino mvn
if [ -f "./mvnw" ]; then
    MAVEN_CMD="./mvnw"
else
    MAVEN_CMD="mvn"
fi

# Ejecutar comando de Liquibase
echo "Ejecutando: $MAVEN_CMD liquibase:$@"
$MAVEN_CMD liquibase:"$@"

echo
echo "Comando completado."