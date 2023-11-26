#!/bin/bash

# Variables
CLUSTER_NAME="pin-final-cluster"
AWS_REGION="us-east-2"
SSH_KEY="pin-final" ## Poner las sshkey que tenes

# Verificación de credenciales de AWS
if aws sts get-caller-identity &> /dev/null; then
  echo "Credenciales verificadas. Procediendo con la creación del clúster."

  # Creación del clúster con eksctl
  eksctl create cluster \
    --name "$CLUSTER_NAME" \
    --region "$AWS_REGION" \
    --nodes 3 \
    --node-type "t2.small" \
    --with-oidc \
    --ssh-access \
    --ssh-public-key "$SSH_KEY" \
    --managed \
    --full-ecr-access \
    --zones "us-east-2a,us-east-2b,us-east-2c"

  if [ $? -eq 0 ]; then
    echo "Configuración del clúster completada con éxito mediante eksctl."
  else
    echo "La configuración del clúster falló durante la ejecución de eksctl."
  fi
else
  echo "Por favor, ejecuta aws configure y establece las credenciales correctas."
  echo "La configuración del clúster ha fallado."
fi