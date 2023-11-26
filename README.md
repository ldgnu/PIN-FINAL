# Proyecto Integrador Final – Javier Solis - MundoSE
Índice:

Configuración del Bastion Host en AWS
1.1. Crear una instancia de EC2 para el Bastion Host
1.3. Ejecutar script de instalación (aws-cli, kubectl, helm, terraform)
1.2. Conectar al Bastion Host

Configuración del Cluster en Amazon EKS
2.1. Crear un rol de IAM para el EKS
2.2. Crear un clúster de EKS
2.3. Configurar kubectl para el nuevo clúster
2.4. Desplegar Nginx en el clúster
2.5. Desplegar Prometheus en el clúster
2.6. Desplegar Grafana en el clúster
2.7. Configurar las reglas de seguridad del clúster

1. Configuración del Bastion Host en AWS:
1.1. Crear una instancia de EC2 para el Bastion Host:

Levantamos una instancia EC2 para utilizar de Bastion.
Caracteristicas Region: us-east-2 
Sistema Operativo : Ubuntu Server 20.04 
Family (Tipo): t2.micro

