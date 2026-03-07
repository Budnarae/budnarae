---
title: ft_irc
date: 2026-03-05
tags:
  - project
  - systems
  - network
  - 42seoul
---

# ft_irc

![[ft_irc 시연 영상.mp4]]

_socket programming_

C++ 언어를 사용하여 **IRC(Internet Relay Chat) 서버**를 구현하는 과제이다. IRC는 1988년에 정의된 채팅 프로토콜로, 클라이언트-서버 구조로 동작하며 채널 기반의 그룹 채팅과 1:1 메시지를 지원한다. 서버 간 연결(server-to-server) 같은 일부 기능은 제외하고 구현하였다.

- **개발 기간**: 2024.11 ~ 2024.12
- **과정**: 42 Seoul Inner Circle
- **언어**: C++
- **GitHub**: https://github.com/Budnarae/42_innercircle_course/tree/main/ft_irc
- **팀 멤버**:
	- [하대진](https://github.com/haddol7)
	- [석주호](https://github.com/Jokuhus)
	- [홍신화](https://github.com/budnarae)
- **담당 역할**: JOIN, INVITE 명령어 구현, Chatting Channel 구현, 서버 루프 로직 구현

---

## 개요

소켓 프로그래밍으로 TCP 연결을 직접 다루고, `epoll()`를 사용한 논블로킹 이벤트 루프로 여러 클라이언트를 동시에 처리하는 서버를 구현한다. 서버의 동작 규칙은 [RFC 2812](https://www.rfc-editor.org/rfc/rfc2812.html) 문서를 기준으로 삼았다.

---

## 구현 내용

**TCP 소켓 기반 연결 관리**
서버 소켓을 열고 클라이언트의 접속 요청을 수락하여 각 클라이언트와 1:1 TCP 연결을 유지한다. 연결이 끊겼을 때의 정리 처리도 포함한다.

**`epoll` 기반 논블로킹 이벤트 루프**
스레드를 사용하지 않고 단일 스레드에서 여러 클라이언트를 처리하기 위해 Linux POSIX API인 `epoll`로 이벤트 루프를 구현했다. `epoll`은 여러 파일 디스크립터를 감시하다가 읽기/쓰기가 가능한 상태가 된 것만 처리하는 방식으로, 블로킹 없이 다수의 연결을 동시에 다룰 수 있다.

**IRC 명령어 파싱 및 처리**
클라이언트가 보내는 메시지를 IRC 프로토콜 형식에 맞게 파싱하고, 아래 핵심 명령어들을 처리한다.

| 명령어 | 기능 |
|--------|------|
| `NICK` | 닉네임 설정 |
| `USER` | 사용자 등록 |
| `JOIN` | 채널 입장 (없으면 생성) |
| `PART` | 채널 퇴장 |
| `PRIVMSG` | 채널 또는 특정 유저에게 메시지 전송 |

**채널 및 유저 상태 관리**
어떤 유저가 어떤 채널에 있는지, 채널 오퍼레이터(op) 권한은 누가 갖고 있는지 등의 상태를 서버 측에서 관리한다.

**프로토콜 오류 응답 처리**
잘못된 명령어, 권한 없는 요청 등 예외 상황에 대해 RFC에서 정의한 번호 코드(numeric reply)로 응답을 반환한다.

---

## 실행 방법

먼저 IRC 클라이언트 `irssi`를 설치한다. `nc(netcat)` 같은 간단한 프로그램으로도 테스트할 수 있지만, 사용자 친화적이지 않으므로 제대로 된 클라이언트 사용을 권장한다.

```shell
sudo apt install irssi
```

서버를 실행한다. 첫 번째 인자는 포트 번호, 두 번째 인자는 접속 비밀번호이다.

```shell
./ircserv 4242 4242
```

`irssi`를 실행한 뒤 아래 명령어로 서버에 접속한다.

```
/connect -nocap localhost 4242 4242 nickname
```

접속에 성공하면 [RFC 2812](https://www.rfc-editor.org/rfc/rfc2812.html) 문서를 참고하여 채널 생성, 입장, 메시지 전송 등 다양한 명령어를 테스트해볼 수 있다.
