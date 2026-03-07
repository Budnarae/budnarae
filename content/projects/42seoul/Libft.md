---
title: Libft
date: 2026-03-05
tags:
  - project
  - fundamentals
  - c
  - 42seoul
---

# Libft

_C 기초_

`strlcpy`, `strlcat` 같은 C 라이브러리 함수들을 직접 구현하는 과제이다. 여기서 만든 라이브러리는 이후 42 Seoul 과제들에서 공통으로 사용하는 기반 라이브러리가 된다.

- **과정**: 42 Seoul Inner Circle
- **언어**: C
- **GitHub**: https://github.com/Budnarae/42_innercircle_course/tree/main/Libft

---

## 개요

C 표준 라이브러리는 문자열 처리, 메모리 조작 등 수많은 유틸리티 함수를 제공하지만, 이 과제에서는 그것들을 직접 구현하며 각 함수의 내부 동작 원리를 이해한다. 완성된 함수들은 `Makefile`로 정적 라이브러리(`libft.a`)로 빌드되어 이후 과제에서 링크하여 재사용한다.

---

## 구현 내용

**문자 판별 및 변환 함수**
`isalpha`, `isdigit`, `isalnum`, `isascii`, `isprint`, `toupper`, `tolower` 등 문자 분류 및 변환 함수를 구현한다.

**문자열 처리 함수**
`strlen`, `strlcpy`, `strlcat`, `strncmp`, `strchr`, `strrchr`, `strnstr`, `strdup`, `substr`, `strjoin`, `strtrim`, `split` 등 문자열을 다루는 함수를 구현한다.

**메모리 조작 함수**
`memset`, `bzero`, `memcpy`, `memmove`, `memchr`, `memcmp`, `calloc` 등 메모리 블록을 직접 다루는 함수를 구현한다.

**변환 함수**
`atoi`, `itoa` 등 문자열과 정수 사이의 변환 함수를 구현한다.

**파일 출력 함수**
`putchar_fd`, `putstr_fd`, `putendl_fd`, `putnbr_fd` 등 특정 파일 디스크립터로 출력하는 함수를 구현한다.

**보너스: 단일 연결 리스트**
`t_list` 구조체를 기반으로 한 단일 연결 리스트 함수 세트를 구현한다. 노드 생성(`lstnew`), 추가(`lstadd_front`, `lstadd_back`), 순회(`lstiter`), 변환(`lstmap`), 해제(`lstclear`) 등을 포함한다.
