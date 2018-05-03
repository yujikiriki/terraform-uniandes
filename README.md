## S4N - 2018
### Preparado para ISIS Uniandes
### Autores: David Montaño, Natalia Parrado, Jean Zucchet, Yuji Kiriki

Recursos que describen el aprovisionamiento automatico sobre una cuenta AWS de los siguientes servicios:
  
 - Políticas de ejecución para funcionales lambda sobre recursos DynamoDB 
 - Recursos DynamoDB sobre dos regiones

## Pasos del taller

### 0. Crear una carpeta con nombre taller.

```
$> mkdir taller
```

### 1. Instalar `terraform`.

### 2. Instalar `aws cli`.

### 3. Instalar `mvn`. 

- Bajar el binario de [acá](http://apache.uniminuto.edu/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz)
- Descomprimirlo en la dentro de la carpeta `taller`.

### 4. Empaquetar la función Lambda

Clonar el repositorio:

Dentro de la carpeta del código clonado, empaquetar con `mvn`.

```
$> mvn clean verify
``` 

### Terraform tasks

Ejecute el proyecto Terraform luego de establecer credenciales de accesso válidas para una cuenta AWS. Las credenciales se establecen vía alguno de los siguiente mecanismos:

#### Credenciales para terraform

- Vía la consola de comandos ejecutando:
  - `export AWS_ACCESS_KEY_ID="[YOUR AWS ACCESS KEY]"`
  - `export AWS_SECRET_ACCESS_KEY="[YOUR AWS SECRET KEY]"`
  - `export AWS_DEFAULT_REGION="us-east-1"`
- Estableciendo los valores de AWS_ACCESS_KEY_ID y AWS_SECRET_ACCESS_KEY en el archivo main.tf del proyecto principal.

#### Ejecutar el aprovisionamiento

```
$> terraform init
$> terraform plan
$> terraform apply
```

