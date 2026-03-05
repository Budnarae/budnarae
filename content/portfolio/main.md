---
title: 홍신화 포트폴리오
date: 2026-02-12
tags:
  - portfolio
---

# 자기소개

안녕하세요, 게임 클라이언트/엔진 프로그래머를 꿈꾸는 홍신화입니다. 현재 관련 분야에서 새로운 기회를 찾고 있습니다.

커리어 목표에 필요한 역량을 쌓기 위해 ==크래프톤 게임테크랩==과 ==42 Seoul== 두 프로그램을 모두 이수했습니다.

==게임테크랩==에서는 게임 엔진 아키텍처와 렌더링 시스템에 집중했습니다.

과정 전반기에는 Unreal Engine의 클래스 계층 (UObject, AActor, UPrimitiveComponent, FName, etc) 과 Naming Convention, Coding Convention) 등을 학습하였고, 이에 기반하여 DirectX 11 기반 자체 게임 엔진을 구현했습니다.

후반기에는 ==Perforce==를 사용해 팀원들과 협업하여 레벨에 오로라 현상을 손쉽게 구현할 수 있는 Unreal Engine 5용 플러그인을 개발해 FAB 마켓플레이스에 성공적으로 출시했습니다.

==42 Seoul==에서는 POSIX API를 활용한 시스템 프로그래밍 프로젝트를 수행했습니다. C/C++로 Ray Tracer, Unix Shell, IRC Server 등을 구현하며 로우레벨 프로그래밍 기초를 강화했습니다.

두 프로그램 모두 전통적인 강의자가 없는 환경에서 자기주도 학습, 동료 코드 리뷰, 멘토링 중심으로 운영됩니다. 이러한 환경을 통해 ==문제를 스스로 정의하고 해결하는 방법을 익혔고, 새로운 기술과 환경에도 빠르게 적응할 수 있게 되었습니다.==

저에 대해 더 알고 싶으시다면 언제든 편하게 연락 주세요!

_연락처_  
Email: budnarae1001@gmail.com  
GitHub: https://github.com/budnarae  

# 기술

- **C / C++**
- **DirectX 11**
- **Unreal Engine 5 (기초)**
- **POSIX 기반 동시성 프로그래밍**
- **Perforce, Git, RenderDoc (기초), Docker**

# 프로젝트

## 그래픽스 & 엔진

- **[[Volumetric Aurora]] | 09-2025 ~ 02-2026**  
  Unreal Engine 5 기반의 실시간 오로라 렌더링 플러그인을 개발하고 [Fab](https://www.fab.com/listings/57cba704-cfa8-4014-b6c2-b582822ce3fc)에 출시했습니다.  
  Ray Marching 기반 볼륨 렌더링 기법으로 구현했습니다.

- **[[개요| Custom Game Engine (C++)]] | 09-2025 ~ 12-2025**  
  DirectX 11 기반 커스텀 게임 엔진을 구현했습니다.  
  Forward/Deferred 렌더링 파이프라인과 후처리 시스템을 개발했습니다.

- **miniRT | 06-2024 ~ 07-2024**  
  Phong 셰이딩 기반 레이 트레이서입니다.  
  광선-기하 프리미티브 교차 판정과 하드 섀도우를 구현했습니다.

- **FDF | 12-2023 ~ 01-2024**  
  높이 맵 기반 3D 와이어프레임 렌더러입니다.  
  Bresenham 알고리즘, 행렬 기반 TRS 변환, 투영 모드 전환(Isometric/Cabinet)을 구현했습니다.

## 시스템 프로그래밍

- **IRC Server | 11-2024 ~ 12-2024**  
  RFC 1459 기반 멀티클라이언트 IRC 서버를 구현했습니다.  
  `select()`를 사용한 논블로킹 I/O를 설계하고, 명령 처리 및 채널/유저 관리를 구현했습니다.

- **Philosophers | 02-2024 ~ 03-2024**  
  멀티스레딩/프로세스 동시성 제어로 Dining Philosophers 문제를 구현했습니다.  
  pthreads/mutexes와 세마포어를 활용해 데드락 회피와 데이터 레이스 처리를 관리했습니다.

- **minishell | 01-2024 ~ 03-2024**  
  파이프라인과 리다이렉션을 지원하는 Unix 셸을 구현했습니다.  
  `fork`, `pipe`, `dup2`를 이용해 프로세스 제어와 IPC를 설계했습니다.
