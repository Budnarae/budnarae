---
title: Inception
date: 2026-03-05
tags:
  - project
  - devops
  - docker
  - 42seoul
---

# Inception

![[Inception 시연 영상.mp4]]

_Docker_

**Docker**를 사용하여 WordPress 페이지를 서비스하기 위한 **MSA(Micro Service Architecture)**를 구성하는 과제이다. 단일 컨테이너가 아닌 역할별로 분리된 여러 컨테이너를 연결하고, 네트워크·볼륨·환경 변수를 직접 설계하며 컨테이너 기반 인프라의 기본 구조를 실습한다.

- **과정**: 42 Seoul Inner Circle
- **언어**: Docker / Shell
- **GitHub**: https://github.com/Budnarae/42_innercircle_course/tree/main/Inception

---

## 개요

서비스는 아래 세 컨테이너로 구성되며, Docker Compose로 한 번에 빌드하고 기동한다.

| 컨테이너 | 역할 |
|----------|------|
| NGINX | 리버스 프록시. 외부 요청을 받아 WordPress 컨테이너로 전달한다 |
| WordPress | 실제 웹 애플리케이션. PHP-FPM으로 동작한다 |
| MariaDB | WordPress의 데이터베이스 |

외부에서 직접 WordPress나 MariaDB에 접근하는 것이 아니라, 반드시 NGINX를 통해서만 접근하도록 네트워크를 구성한다. 데이터는 볼륨으로 호스트에 영속적으로 저장된다.

---

## 구현 내용

**서비스 컨테이너 구성**
각 서비스를 별도의 컨테이너로 분리하고, 공식 베이스 이미지를 직접 Dockerfile로 빌드하여 사용한다.

**Docker Compose 네트워크/볼륨/환경 변수 설계**
컨테이너 간 통신을 위한 내부 네트워크, 데이터 영속성을 위한 볼륨, 비밀번호 등 민감한 값을 위한 환경 변수를 `docker-compose.yml`에서 관리한다.

**Makefile 자동화**
서비스 빌드, 기동, 정리를 Makefile로 자동화한다.

---

## 실행 방법

먼저 Docker가 설치되어 있어야 한다.

```shell
sudo apt install docker
```

아래 명령어로 MSA를 빌드하고 기동한다.

```shell
sudo make build
```

기동 후 브라우저에서 아래 주소로 접속한다.

```
https://localhost
```

서비스를 종료하고 컨테이너 및 볼륨을 정리하려면 아래 명령어를 실행한다.

```shell
sudo make fclean
```
