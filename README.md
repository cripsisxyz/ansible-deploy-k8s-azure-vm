# Instalacion Kubernetes cluster en Azure VM
## Descripción
Procedimiento a seguir para desplegar un entorno distribuido en cloud para un cluster de Kubernetes. Este estará compuesto por un nodo master y X workers. Además contará con servicio de NFS para montar los volúmenes necesarios de un pod. La instalación se realizará sobre Azure VM como IaaS y no sobre AKS.
## Componentes
### Master
- Docker
- NFS Server
- kubeadm
- kubelet
- kubectl
### Workers (2)
- Docker
- kubeadm
- kubelet
### SDN
- calico
### Ingress controller
- HAProxy
## Árbol
```
├── 01-nfs.yml # Instala NFS Server y cliente en workers
├── 02-k8s.yml # Aprovisiona el cluster K8S
├── 03-deploy-app.yml # Crea un export en NFS y levanta un pod de ejemplo
├── ansible.cfg # Configuraciones de entorno ansible
├── group_vars 
│   └── all.yml # Variables comunes
├── hosts # Inventario entorno local
├── hosts_azure # Inventario hosts Azure
├── README.md
├── roles
│   ├── cni # Role que instala el SDN (calico)
│   │   ├── defaults
│   │   │   └── main.yml # Fichero de variables por defecto
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   │       └──calico.yml.j2 # Plantilla de configuración
│   ├── commons # Role de tareas comunes entre todos los nodos
│   │   └── pre-install 
│   │       ├── meta
│   │       │   └── main.yml
│   │       ├── tasks
│   │       │   ├── main.yml
│   │       │   └── pkg.yml
│   │       └── templates
│   │           └── 20-extra-args.conf.j2
│   ├── docker # Instala y configura el daemon de docker
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   ├── main.yml
│   │   │   └── pkg.yml
│   │   └── templates
│   │       ├── daemon.json.j2
│   │       ├── docker.j2
│   │       └── docker.service.j2
│   ├── haproxy # Instala ingress controller HAProxy
│   │   ├── tasks
│   │   │   └── main.yaml
│   │   └── templates
│   │       └── haproxyConfig.j2
│   └── kubernetes # Instala los componentes de Kubernetes y crea el cluster
│       ├── master # Pasos para master
│       │   ├── handlers
│       │   │   └── main.yml
│       │   ├── meta
│       │   │   └── main.yml
│       │   └── tasks
│       │       ├── init.yml
│       │       └── main.yml
│       └── node # Pasos de los worker
│           ├── files
│           │   └── kubelet.service
│           ├── handlers
│           │   └── main.yml
│           ├── meta
│           │   └── main.yml
│           └── tasks
│               ├── join.yml
│               └── main.yml
└── terraform #Activos terraform infra
    ├── main.tf
    ├── network.tf
    ├── security.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    ├── vars.tf
    └── vm.tf
```
## Uso
- `az login`
- `terraform plan`
- `terraform apply`
- Setear la IP pública asignada en `group_vars/all` (se puede consultar con`az network public-ip show --resource-group iva-unir-k8s-resources --name vmip1 |grep ipAddress`)
- Ejecutar en orden los playbooks de Ansible:
- `ansible-playbook 01-nfs.yml -i hosts_azure` -> Instala el servidor NFS
- `ansible-playbook 02-k8s.yml -i hosts_azure` -> Instala todo lo necesario para el cluster de k8s. Require de los roles en el directorio `roles`
- `ansible-playbook 03-deploy-app.yml -i hosts_azure` -> Despliega una APP de ejemplo