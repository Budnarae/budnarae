---
title: 42_transcendence
date: 2026-03-05
tags:
  - project
  - web
  - fullstack
  - 42seoul
---

# 42_transcendence

_웹 프로그래밍 기초_

플레이어들이 서로 **Pong 게임**을 즐길 수 있는 웹 서비스를 팀 단위로 개발하는 42 Seoul의 마지막 공통 과제이다. 프론트엔드, 백엔드, 실시간 통신을 하나의 서비스로 통합하며 풀스택 웹 개발 전반을 실습한다.

- **과정**: 42 Seoul Inner Circle

---

## 기술 스택

| 영역 | 사용 기술 |
|------|-----------|
| 프론트엔드 | Pure Vanilla JavaScript, HTML, CSS, Bootstrap, Socket.io, Three.js |
| 백엔드 | Django |
| 인프라 | Docker |

프론트엔드는 별도의 프레임워크 없이 **순수 Vanilla JavaScript**만으로 구현한다는 제약이 있다.

---

## 구현 내용

**사용자 인증 및 계정 기능**
회원가입, 로그인, 프로필 관리 등 계정 관련 기능을 구현한다.

**실시간 Pong 게임 및 매치 흐름**
Socket.io를 사용하여 실시간 양방향 통신을 구현하고, 플레이어 간의 매칭과 게임 진행을 처리한다. 게임 렌더링에는 Three.js를 활용한다.

**프론트엔드/백엔드 API 연동**
Django REST API와 프론트엔드 간의 데이터 송수신 및 상태 관리를 구현한다.

---

## 실행 방법

`backend` 경로로 이동하여 빌드한다.

```shell
cd backend
sudo make
```

빌드 후 브라우저(Chrome)에서 아래 주소로 접속한다.

```
https://localhost
```

서비스를 종료하고 정리하려면 아래 명령어를 실행한다.

```shell
sudo make fclean
```