---
title: pipex
date: 2026-03-05
tags:
  - project
  - systems
  - unix
  - 42seoul
---

# pipex

_멀티 프로세싱, 프로세스 간 통신_

`fork`, `pipe` 시스템 콜을 활용하여 셸의 **파이프(`|`)** 기능을 구현하는 과제이다.

- **과정**: 42 Seoul Inner Circle
- **언어**: C
- **GitHub**: https://github.com/Budnarae/42_innercircle_course/tree/main/pipex

---

## 개요

셸에서 아래와 같이 파이프를 사용하면 앞 명령어의 출력이 뒤 명령어의 입력으로 연결된다.

```shell
< infile ls -l | wc -l > outfile
```

pipex는 이와 동일한 동작을 아래 형식의 실행 파일로 구현한다.

```shell
./pipex infile "ls -l" "wc -l" outfile
```

---

## 구현 내용

**파이프라인 실행 모델**
`pipe`로 프로세스 간 통신 채널을 만들고, `fork`로 자식 프로세스를 생성한다. `dup2`로 자식 프로세스의 표준 입출력을 파이프 또는 파일로 교체한 뒤, `execve`로 실제 명령어를 실행한다. 앞 명령어의 표준 출력이 파이프를 통해 뒤 명령어의 표준 입력으로 흘러가는 구조다.

**PATH 기반 실행 파일 탐색**
명령어 이름만 주어졌을 때 환경 변수 `PATH`에 등록된 경로들을 순서대로 탐색하여 실행 파일의 절대 경로를 찾는다.

**보너스: 다중 파이프라인**
2개 이상의 명령어를 이어 실행할 수 있다.

```shell
< infile cmd1 | cmd2 | cmd3 | ... | cmdn > outfile
```

```shell
./pipex infile cmd1 cmd2 cmd3 ... cmdn outfile
```

**보너스: heredoc**
셸의 `<<` 연산자와 동일하게, 지정한 구분자(LIMITER)가 입력될 때까지 표준 입력을 읽어 첫 번째 명령어의 입력으로 전달한다. 출력은 outfile에 이어쓰기(`>>`)한다.

```shell
cmd << LIMITER | cmd1 >> file
```

```shell
./pipex here_doc LIMITER cmd cmd1 file
```
