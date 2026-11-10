# DevOps Release Engine — Final Project

## Description

Projet final de ma formation DevOps de 30 jours.

Ce projet met en place une chaîne CI/CD automatisée permettant de tester une application Python, de construire une image Docker, de vérifier son fonctionnement et de la publier sur Docker Hub avec Jenkins.

**Technologies utilisées :** Linux Ubuntu, Git, GitHub, Python 3, Docker, Jenkins et Docker Hub.

## 1. Application Python

L'application `app.py` utilise deux variables d'environnement :

| Variable | Description | Valeur par défaut |
|---|---|---|
| `APP_VERSION` | Version de l'application | `dev` |
| `APP_ENV` | Environnement d'exécution | `development` |

Exécution sans configuration :

```bash
python3 app.py
```

Résultat :

```text
DEVOPS FINAL | VERSION=dev | ENV=development
```

Exécution avec une configuration personnalisée :

```bash
APP_VERSION=j30-final-v1 APP_ENV=staging python3 app.py
```

## 2. Docker

Le Dockerfile utilise `python:3.13-slim` et exécute `app.py`.

Construire l'image depuis la racine du repository :

```bash
docker build -t jenkins-docker-app:j30-final-v1 .
```

Lancer un container avec les valeurs par défaut :

```bash
docker run --rm jenkins-docker-app:j30-final-v1
```

Lancer le container en environnement staging :

```bash
docker run --rm \
  -e APP_VERSION=j30-final-v1 \
  -e APP_ENV=staging \
  jenkins-docker-app:j30-final-v1
```

Résultat attendu :

```text
DEVOPS FINAL | VERSION=j30-final-v1 | ENV=staging
```

Les variables sont transmises au démarrage du container. Il n'est pas nécessaire de reconstruire l'image pour changer la configuration.

## 3. Jenkins CI/CD Pipeline

Le Jenkinsfile automatise les opérations suivantes :

1. Récupération du code source depuis GitHub.
2. Exécution des tests Python.
3. Vérification des Credentials Jenkins.
4. Construction de l'image Docker.
5. Exécution et vérification du container.
6. Authentification auprès de Docker Hub.
7. Publication de l'image si les étapes précédentes réussissent.

### Paramètres Jenkins

Le Pipeline utilise **Build with Parameters** :

| Parameter | Type | Default |
|---|---|---|
| `IMAGE_TAG` | String | `j30-final-v1` |
| `APP_VERSION` | String | `j30-final-v1` |
| `APP_ENV` | Choice | `staging` / `production` |

`IMAGE_TAG` identifie l'image Docker.

`APP_VERSION` et `APP_ENV` configurent l'application lors de son exécution.

Les tests vérifient que l'application affiche les valeurs sélectionnées.

## 4. Credentials et sécurité

Les identifiants Docker Hub sont stockés dans Jenkins Credentials sous l'identifiant `dockerhub-jenkins`.

Le Pipeline utilise `withCredentials` pour récupérer temporairement le nom d'utilisateur et le Personal Access Token (PAT).

Le PAT n'est pas enregistré dans le code source.

L'authentification Docker utilise `--password-stdin`, et les fichiers d'authentification temporaires sont supprimés après utilisation.

## 5. Docker Hub

**Repository :**

https://hub.docker.com/r/devilfury/jenkins-docker-app

**Image publiée :**

`devilfury/jenkins-docker-app:j30-final-v1`

Le repository étant privé, un accès Docker Hub autorisé est nécessaire pour récupérer l'image.

Authentification :

```bash
docker login
```

Téléchargement :

```bash
docker pull devilfury/jenkins-docker-app:j30-final-v1
```

Exécution :

```bash
docker run --rm \
  -e APP_VERSION=j30-final-v1 \
  -e APP_ENV=staging \
  devilfury/jenkins-docker-app:j30-final-v1
```

## 6. Organisation du repository

- `app.py` : application Python configurable.
- `Dockerfile` : définition de l'image Docker.
- `Jenkinsfile` : automatisation CI/CD.
- `hello.py` : application historique des premiers exercices.
- `build-info.py` : script utilisé par les exercices Jenkins.
- `README.md` : documentation du projet.

**Branche du projet final :** `projet-final-jour30`

## 7. Résultat

Le build Jenkins `Projet-Final-Jour30 #2` s'est terminé avec le statut **SUCCESS**.

L'image `j30-final-v1` a été publiée avec succès sur Docker Hub.

Ce projet démontre la mise en place d'une chaîne de livraison automatisée, de GitHub jusqu'à un Docker Registry privé.

---

**Projet réalisé dans le cadre de ma formation DevOps de 30 jours.**
