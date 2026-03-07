
#42Seoul 

---

그동안 수행했던 개발자 교육과정 **42 서울**의 공통 과정 과제들을  정리한 저장소입니다.

---

# 들어가기에 앞서

1. 각 폴더마다 컴파일을 위한 Makefile이 존재하지만, 이미 make된 상태로 푸시하였으므로 별도로 Makefile을 실행시키지 않아도 됩니다.
2. NetPractice, Born2beroot는 42 서울의 인트라넷에서만 테스트 가능한 과제이므로 별도의 실행 가능한 파일을 올리지 않은 점 양해 바랍니다다.

# Libft

_C 기초_

strlcpy, strlcat 같은 c 라이브러리의 함수들을 직접 구현해보는 과제

# get_next_line

_파일 입출력, static 변수_

다음의 기능과 형식을 가진 `get_next_line`이라는 함수를 만드는 과제

```c

// 입력값 : 파일 디스크립터
// 반환값 : 파일로부터 문장 하나를 추출하여 반환.
// n번째로 get_next_line을 호출하면 파일의 n번째 문장을 반환한다.
char *get_next_line(int fd);

```

`/42_innercircle_course/get_next_line/` 경로의 `tester.c` 파일을 참조하여 tester 파일을 실행시키면 `get_next_line`의 동작을 확인할 수 있다.

# ft_printf

_가변 인자_

**VA_ARG**를 활용하여 c 라이브러리의 `printf`의 기능을 제한적으로(type, flag, precision의 가짓수가 제한되어 있음) 구현하는 과제

`/42_innercircle_course/ft_printf/` 경로의 `tester.c` 파일을 참조하여 tester 파일을 실행시키면 `ft_printf`의 동작을 확인할 수 있다.

# Born2beroot

_가상 머신, 리눅스 기초_

VirtualBox를 사용하여 linux 가상 환경을 띄운 후, 그 환경에서 여러 서비스들을 설정하는 과제

# pipex

_멀티 프로세싱, 프로세스 간 통신_

**fork, pipe 시스템 콜**을 활용하여 쉘의 **파이프** 기능을 구현해보는 과제

```shell

< infile ls -l | wc -l > outfile

```

위와 같은 쉘의 파이프 기능을 아래와 같은 형식으로 구현한다.

```shell

./pipex infile "ls -l" "wc -l" outfile

```

2개 이상의 명령어를 이을 수도 있다.

```shell

< infile cmd1 | cmd2 | cmd3 | ... | cmdn > outfile

```

```shell

./pipex infile cmd1 cmd2 cmd3 ... cmdn outfile

```

heredoc 기능을 사용할 수도 있다.

```shell

cmd << LIMITER | cmd1 >> file

```

```shell

./pipex here_doc LIMITER cmd cmd1 file

```

# push_swap

_자료구조, 알고리즘_

두 개의 스택을 사용하여 뒤섞인 숫자 배열을 정렬하는 과제

다음과 같은 조건 하에 문제를 해결해야 한다.

- 스택 a, 스택 b 총 두 개의 스택이 있다.
- 입력받은 뒤섞인 숫자 배열은 스택 a에 위치한다.
- 후술할 스택의 동작들을 활용하여 최종적으로 스택 a에 숫자들이 정렬되도록 한다.

이 과제에서 제시하는 스택은 일반적인 스택과 달리 다음의 추가적인 동작들을 적용할 수 있다(사실 말이 스택이지 별도의 자료구조라 보는 게 무방하다).

- **sa (swap a)**: 스택 a의 맨 위 두 개 요소를 바꾼다. 요소가 하나 이하일 때는 아무것도 하지 않는다.
- **sb (swap b)**: 스택 b의 맨 위 두 개 요소를 바꾼다. 요소가 하나 이하일 때는 아무것도 하지 않는다.
- **ss**: sa와 sb를 동시에 한다.
- **pa (push a)**: 스택 b의 맨 위 요소를 꺼내서 스택 a의 맨 위에 넣는다. 만약 스택 b가 비어 있으면 아무것도 하지 않는다.
- **pb (push b)**: 스택 a의 맨 위 요소를 꺼내서 스택 b의 맨 위에 넣는다. 만약 스택 a가 비어 있으면 아무것도 하지 않는다.
- **ra (rotate a)**: 스택 a의 모든 요소를 위로 1칸씩 이동시킨다. 첫 번째 요소가 마지막 요소가 된다.
- **rb (rotate b)**: 스택 b의 모든 요소를 위로 1칸씩 이동시킨다. 첫 번째 요소가 마지막 요소가 된다.
- **rr**: ra와 rb를 동시에 한다.
- **rra (reverse rotate a)**: 스택 a의 모든 요소를 아래로 1칸씩 이동시킨다. 마지막 요소가 첫 번째 요소가 된다.
- **rrb (reverse rotate b)**: 스택 b의 모든 요소를 아래로 1칸씩 이동시킨다. 마지막 요소가 첫 번째 요소가 된다.
- **rrr**: rra와 rrb를 동시에 한다.

`push_swap`에 뒤섞인 숫자 배열을 입력하면 숫자들을 정렬하기 위한 명령어의 나열을 출력한다.
참고로 입력하는 숫자 배열의 숫자들은 서로 중복되지 않아야 한다.

```shell

./push_swap 5 2 1 4 7 6 3

sa
pb
rra
pb
sa
pb
rb
sa
pb
pb
sa
pb
pb
pa
pa
pa
pa
pa
pa
pa

```

[push swap visualizer](https://windowdong11.github.io/push_swap_visualizer/)를 활용하면 push_swap의 동작을 시각적으로 확인할 수 있다. 단, 이 저장소를 사용하는 사람들은 WSL 환경에서 push_swap을 실행시킬 것이므로 `push_swap [뒤섞인 숫자 나열] | clip`, `push_swap [뒤섞인 숫자 나열] | pbcopy`가 아닌 `push_swap [뒤섞인 숫자 나열] | xclip -selection clipboard`를 사용해야 한다.

# FdF

_그래픽스 기초_

아래와 같은 형태의 map 파일을 사용하여

```shell

cat 42.fdf

0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 10 10 0 0 10 10 0 0 0 10 10 10 10 10 0 0 0
0 0 10 10 0 0 10 10 0 0 0 0 0 0 0 10 10 0 0
0 0 10 10 0 0 10 10 0 0 0 0 0 0 0 10 10 0 0
0 0 10 10 10 10 10 10 0 0 0 0 10 10 10 10 0 0 0
0 0 0 10 10 10 10 10 0 0 0 10 10 0 0 0 0 0 0
0 0 0 0 0 0 10 10 0 0 0 10 10 0 0 0 0 0 0
0 0 0 0 0 0 10 10 0 0 0 10 10 10 10 10 10 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

```

아래의 예시와 같이 3차원의 형상(wire frame이긴 하지만)으로 투사하는 과제이다.

![[FdF.png]]

map 파일의 숫자들은 다음과 같이 해석된다.

- 숫자의 열 위치 : x축 좌표값
- 숫자의 행 위치 : y축 좌표값
- 숫자의 값 : z축 좌표값

과제 수행을 위하여 행렬을 통한 공간 변환, 브레젠험 알고리즘 같은 지식을 배우게 된다.

`fdf`를 실행하기 전 의존성 문제를 해결하기 위해 다음의 명령어를 실행해야한다.

```shell

sudo apt-get update && sudo apt-get install xorg libxext-dev zlib1g-dev libbsd-dev

```

아래와 같은 명령어를 통해 테스트 해볼 수 있다. 예제 map 파일들은 `test_maps` 경로에 위치해 있다.

```shell

./fdf ./test_maps/42.fdf

```

창을 띄우는 데까지 성공했다면, 다음의 키들을 활용하여 추가 기능을 테스트할 수 있다.

==scale==
- 위 화살표 : 확대
- 아래 화살표 : 축소

==rotate==
- A, D : y 축 회전
- W, S : x 축 회전
- Q, E : z 축 회전

==translate==
- I, K : x 축 이동
- J, L :  y 축 이동
- U, E : z 축 이동

==기타==
- space : 투영법 변환(등각 투영 <-> 캐비넷 투영)
- esc : 나가기

# minishell

_파일 입출력, 멀티 프로세스, 시그널 심화_

제한된 기능의 **bash shell**을 구현하는 과제

minishell 실행 파일은 `readline` 라이브러리에 의존성을 가지므로 아래의 명령어를 실행시킨 후 실행시켜야 한다.

```shell

sudo apt-get install libreadline-dev

```

microshell은 아래와 같은 기능을 가지고 있다.

- 히스토리 : 위, 아래 화살표를 이용해 과거에 사용했던 명령어를 편리하게 조회, 재사용할 수 있다.
- 쌍따옴표, 따옴표 파싱
- 괄호 파싱
- `<, >, <<, >>, &&, ||` 연산자
- 파이프라인(`|`)
- 환경변수 관리
- `$?`를 통한 exit status 조회
- ctrl-C, ctrl-D, ctrl-\ 입력이 bash shell과 동일한 동작을 보장함
- 와일드 카드(\*)

# Philosophers

_멀티 스레드_

**pthread, mutex_lock** 등을 사용하여 **식사하는 철학자 문제(dining philosophers problem)**를 구현, **멀티 스레딩, 데이터 레이스(data race), 데드 락(dead lock)**을 공부하는 과제

각 철학자(스레드)는 제한된 숫자의 포크(공유 자원)을 사용하여 굶어죽지 않고 무사히 식사를 마칠 수 있어야 한다.

`philo` 실행 파일은 다음의 인자를 받아 실행된다.

- 철학자 인원
- 죽는 데 걸리는 시간
- 먹는 데 걸리는 시간
- 자는 데 걸리는 시간
- 각 철학자가 먹어야 하는 횟수(없어도 무방하며, 입력하지 않을 시 철학자들은 무한히 식사하게 된다)

즉, 아래와 같이 사용된다.

```shell

./philo 2 450 200 200 4

```

`philo_bonus` 실행 파일은 멀티 스레드 대신 **멀티 프로세스, 세마포어**를 사용하여 구현한 철학자 모델이다.

phlio 또는 philo_bonus 파일의 실행결과를 [philosopher visualizer](https://nafuka11.github.io/philosophers-visualizer/)에 붙여넣기 하면 보다 시각적으로 결과를 확인할 수 있다.

# mimiRT

_ray tracing_

**phong lighting model**을 구현하는 과제이다.

**miniRR** 실행 파일은 **환경광(ambient lighting), 카메라, 광원, 구체, 평면, 원기둥** 정보가 담겨 있는 .rt 파일을 파싱하여 3차원으로 렌더링할 수 있어야 한다. FdF의 wire frame 렌더링이 아닌, 보다 현실감 있는 3차원 렌더링으로 말이다.

아래와 같이 사용한다.

```shell

./miniRT rtFileName.rt

```

예제 rt 파일은 `maps` 경로에 위치한다.

# NetPractice

_네트워크 기초_

NetPractice는 가상의 네트워크 망이 서로 잘 통신할 수 있도록 빈 칸에 알맞은 ip 주소를 채워넣는 퍼즐 문제이다.

**공인 ip, 사설 ip, LAN, WAN, 서브넷 마스킹** 등을 공부하게 된다.

# CPP module

_C++ 기초_

**CPP Module**은 cpp 언어의 기초를 학습하기 위한 과제이다. 각 모듈은 다음의 주제를 다룬다.

- 모듈 0 : Namespaces, classes, member functions, stdio streams, initialization lists, static, const
- 모듈 1 : Memory allocation, pointers to members, references, switch statement
- 모듈 2 : Ad-hoc polymorphism, operator overloading and Orthodox Canonical class form
- 모듈 3 : Inheritance
- 모듈 4 : Subtype polymorphism, abstract classes, interfaces
- 모듈 5 : Repetition and Exceptions
- 모듈 6 : C++ casts
- 모듈 7 : C++ templates
- 모듈 8 : Templated containers, iterators, algorithms
- 모듈 9 : STL

# ft_irc

_socket programming_

C++ 언어를 사용하여 **irc 서버**를 만드는 과제이다.
irc란, **채팅 서버**를 만들기 위한 프로토콜이다. 물론 irc 서버를 온전히 구현하는 것은 너무 벅찬 일이므로, 일부 기능을 제외하고 구현하였다(ex. 서버 간 통신).

클라이언트와 통신하는 기능을 만들기 위해 **소켓 프로그래밍 socket programming**을, 정해진 프로토콜 대로 서버를 만들기 위해 **rfc 문서**를 보는 방법을 배우게 된다.

`nc(netcat)` 같은 간단한 클라이언트 프로그램으로도 서버를 테스트할 수 있지만, 사용자 친화적이지 못하므로 제대로 된 irc 클라이언트를 설치하여 테스트하는 것을 권장한다.

```shell

sudo apt install irssi

```

그리고 먼저 서버를 실행시킨다. 첫번째 인자는 서버가 통신에 사용할 포트 번호, 두번째 인자는 서버에 연결하는데 사용할 비밀번호이다.

```shell

./ircserv 4242 4242

```

그리고 irssi 클라이언트를 실행시킨다.

```shell

./irssi

```

화면에 irssi 윈도우가 띄워지면, 다음의 명령어를 사용하여 서버에 접속한다.

```

/connect -nocap localhost 4242 4242 nickname

```

연결에 성공하였다면 [rfc 2812](https://www.rfc-editor.org/rfc/rfc2812.html) 문서를 참고하여 irc 프로토콜의 다양한 명령어를 테스트하여보자.

# Inception

_Docker_

**도커**를 사용하여 wordpress 페이지를 서비스하기 위한 **MSA(micro service architecture)**를 띄우는 과제.

이 과제를 테스트하기 위해선 리눅스에 docker가 설치되어 있어야 한다.

```shell

sudo apt install docker

```

`sudo make build`로 MSA를 올릴 수 있고 호스트에서 `https://localhost`로 접속할 수 있다. `sudo make fclean`으로 MSA를 내릴 수 있다.

# ft_transcendence

_웹 프로그래밍 기초_

플레이어들이 서로 ping pong 게임을 즐길 수 있는 웹페이지를 만드는 과제
다음의 스택을 사용한다.

- 프론트엔드 : **pure vanila javascript**, html, css, bootstrap, socket.io, three.js
- 백엔드 : Django

과제를 테스트하기 위해서는 `backend` 경로로 이동하여 `sudo make`하고 호스트에서 chrome을 사용하여 `https://localhost`로 접속하면 된다.

`sudo make fclean`으로 MSA를 내릴 수 있다.



