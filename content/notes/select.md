---
title: '*select*'
tags:
  - 'network'
  - 'language/c'
  - 'socket_programming'
  - 'linux/system_call'
---

select 함수를 이용하는 것이 멀티 플렉싱 서버의 구현에 있어서 가장 대표적인 방법이다. 그리고 윈도우에서도 이와 동일한 이름으로 동일한 기능을 제공하는 함수가 있기 때문에 이식성에 있어서도 좋은 점수를 줄 수 있다.

# select 함수의 기능

select 함수를 사용하면 하나의 구조체에 여러 개의 파일 디스크립터를 모아놓고 동시에 이들을 관찰할 수 있다. 이때 관찰할 수 있는 항목은 다음과 같다. ^9974c7

- 수신한 데이터를 가지고 있는 소켓이 존재하는가?
- 블로킹되지 않고 데이터의 전송이 가능한 소켓은 무엇인가?
- 예외상황이 발생한 소켓은 무엇인가?

> ## 관찰항목 각각을 가리켜 ==이벤트(event)==라고 한다.
> 관찰항목 각각을 가리켜 이벤트라 하고, 관찰 항목에 속하는 상황이 발생했을 때, '이벤트(event)가 발생했다'라고 표현한다. 이는 매우 일반적인 표현이기 때문에 여러분도 이 표현에 익숙해질 필요가 있다.

# select 함수의 호출 순서

select 함수의 호출 순서를 전체적으로 정리하면 아래와 같다.

1. 파일 디스크립터의 설정
2. 검사의 범위 설정
3. 타임아웃의 설정
4. select 함수의 호출
5. 호출 결과 확인

## 파일 디스크립터의 설정

select 함수를 사용하면 여러 개의 파일 디스크립터를 동시에 관찰할 수 있다.
파일 디스크립터의 관찰은 소켓의 관찰로 해석할 수 있다.

그렇다면 먼저 관찰하고자 하는 파일 디스크립터를 모아야 한다.
모을 때도, 관찰항목(수신, 전송, 예외)에 따라 모아야 한다.
즉, 바로 [[select#^9974c7 | 위]]에서 언급한 세가지 관찰 항목별로 구분해서 세 묶음으로 모아야 한다.

파일 디스크립터를 세 묶음으로 모을 때 사용되는 것이 fd_set형 변수이다. 즉, 다음 그림에서 보이듯이 0과 1로 표현되는, 비트 단위로 이뤄진 배열이라고 생각한다.

fd의 값에 대응되는 위치의 비트가 0으로 설정되어 있으면 해당 파일 디스크립터가 관찰 대상이 아님을 의미한다.
반대로, 비트가 1로 설정되어 있으면 해당 파일 디스크립터가 관찰 대상임을 의미한다.

fd_set형 변수의 조작은 비트 단위로 이뤄지기 때문에 직접 값을 등록하는 일은 매우 번거롭다. 따라서 일반적으로 아래의 매크로 함수를 통해서 조작한다.

```c

#include <sys/select.h>

// 주소형으로 전달된 fd_set형 변수의 모든 비트를 0으로 초기화한다.
FD_ZERO(fd_set *fdset)

// 매개변수 fdset으로 전달된 주소의 변수에
// 매개변수 fd로 전달된 파일 디스크립터 정보를 등록한다.
FD_SET(int fd, fd_set *fdset)

// 매개변수 fdset으로 전달된 주소의 변수에서 매개변수 fd로 전달된
// 파일 디스크립터 정보를 삭제한다.
FD_CLR(int fd, fd_set *fdset)

// 매개변수 fdset으로 전달된 주소의 변수에 매개변수 fd로 전달된
// 파일 디스크립터 정보가 있으면 양수를 반환한다.
FD_ISSET(int fd, fd_set *fdset)

```

## 검사(관찰)의 범위지정과 타임아웃의 설정

이 단락의 내용을 이해하려면 먼저 select 함수의 형태를 알아야 한다.

```c

#include <sys/select.h>
#include <sys/time.h>

int select(int maxfd, fd_set *readset, fd_set *writeset, \
	fd_set *exceptset, const struct timeval *timeout);

```

- maxfd : 검사 대상이 되는 파일 디스크립터의 수
- readset : fd_set형 변수에 '수신된 데이터의 존재 여부'에 관심 있는 파일 디스크립터 정보를 모두 등록해서 그 변수의 주소 값을 전달한다.
- writeset : fd_set형 변수에 '블로킹 없는 데이터 전송의 기능여부'에 관심 있는 파일 디스크립터 정보를 모두 등록해서 그 변수의 주소 값을 전달한다.
- exceptset : fd_set형 변수에 '예외 상황의 발생여부'에 관심이 있는 파일 디스크립터 정보를 모두 등록해서 그 변수의 주소 값을 전달한다.
- timeout : select 함수 호출 이후에 무한정 블로킹 상태에 빠지지 않도록 타임아웃(time-out)을 설정하기 위한 인자를 전달한다.
- 반환 값 : 오류 발생 시에는 -1이 반환되고, 타임 아웃에 의한 반환 시에는 0이 반환된다. 그리고 반환 대상으로 등록된 파일 디스크립터에 해당 관심에 관련된 변화가 발생하면 0보다 큰 값이 반환되는데, 이 값은 변화가 발생한 파일 디스크립터의 수를 의미한다.

위 내용에 좀 더 살을 덧붙여보자.

먼저, 검사 대상이 되는 파일 디스크립터의 수를 첫번째 인자로 넘겨야 한다. 결론부터 말하자면, **여태까지 생성된 서버 소켓, 클라이언트 소켓을 가리키는 fd 중 가장 큰 값 + 1**을 전달하면 된다. fd는 일반적으로 생성될 때마다 값이 1씩 늘어나기 때문에, 소켓을 하나 생성할 때마다 select에 전달할 값을 갱신하게 될 것이다.

select는 **0 ~ 첫번째 인자 - 1의 범위**에 존재하는 fd에 event가 발생했는지 감시한다. 만약 event가 발생한 fd가 2 ~ 4번째 인자로 받은 fd_set에 포함되어 있으면 해당하는 fd_set에 그 내용을 기록한다.

select가 호출되었을 때 아무런 이벤트가 발생하지 않았으면, 이벤트가 발생할 때까지 감시 대상을 지속적으로 감시하면서 block 상태에 머무른다.
만약 select가 무한정 대기 상태에 빠지는 것을 원치 않는다면, 5번째 인자로 전달되는 timeval 구조체 변수를 전달하여 얼마만큼의 시간이 지나면 block에서 빠져나오도록 설정할 수 있다. 이러한 시간 제한을 걸기를 원하지 않는다면 NULL을 전달하면 된다.

```c

struct timeval
{
	long tv_sec; // seconds
	long tv_usec; // microseconds
}

```

# select 함수호출 이후의 결과 확인

select 함수는 변화가 생긴 fd의 수를 반환하므로, 양수를 반환한다면 감시 대상에 변화가 생겼다고 해석할 수 있다. 그러면 불특정 다수의 감시 대상 중 정확히 어떤 fd에 변화가 생겼는지 확인할 수 있을까?

select 함수호출이 완료되고 나면, select 함수의 인자로 전달된 fd_set형 변수에는 변화가 생긴다. 모든 비트가 0으로 변경되지만, 변화가 발생한 파일 디스크립터에 해당하는 비트만 그대로 1로 남아있게 된다. 때문에 여전히 1로 남아있는 위치의 파일 디스크립터에서 변화가 발생했다고 판단할 수 있다.

#  예제

```c
// select.c

#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/select.h>

#define BUF_SIZE 30

int main(int argc, char *argv[])
{
	fd_set reads, temps;
	int result, str_len;
	char buf[BUF_SIZE];
	struct timeval timeout;

	FD_ZERO(&reads);
	// 0(표준 입력)을 감시 대상으로 삼는다.
	FD_SET(0, &reads); // 0 is standard input(console)

	// timeout은 이 위치가 아닌 아래의 while 문 안에서 실행해야 한다.
	// select 함수가 호출될 때마다 5번째 인자로 전달된 timeval 구조체의 멤버들이 0으로 초기화되어버리기 때문이다.
	/*
	timeout.tv_sec = 5;
	timeout.tv_usec = 5000;
	*/

	while (1)
	{
		// select에 temps를 전달하는 이유는 select가 전달받은 fd_set의 비트를 변경하기 때문이다.
		temps = reads;
		// select가 블록하는 시간 5초
		timeout.tv_sec = 5;
		timeout.tv_usec = 0;
		result = select(1, &temps, 0, 0, &timeout);
		if (result == -1)
		{
			puts("select() error!");
			break ;
		}
		else if (result == 0)
		{
			puts("Time-out!");
		}
		else
		{
			// 변화가 발생한 fd가 0인가?
			if (FD_ISSET(0, &temps))
			{
				// 표준 입력으로 입력받은 내용을 표준 출력으로 보낸다.
				str_len = read(0, buf, BUF_SIZE);
				buf[str_len] = 0;
				printf("message from console : %s", buf);
			}
		}
	}
	return (0);
}

```

``` c

// echo_selectserv.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/select.h>

#define BUF_SIZE 100

void error_handling(char *buf);

int main(int argc, char *argv[])
{
	// 필요한 변수 설정
	int serv_sock, clnt_sock;
	struct sockaddr_in serv_adr, clnt_adr;
	struct timeval timeout;
	fd_set reads, cpy_reads;

	socklen_t adr_sz;
	int fd_max, str_len, fd_num;
	char buf[BUF_SIZE];

	// 필요한 port 번호를 전달받지 못했다 -> error
	if (argc !=2)
	{
		printf("Usage : %s <port>\n", argv[0]);
		exit(1);
	}

	// 서버 소켓의 주소 정보 설정
	serv_sock = socket(PF_INET, SOCK_STREAM, 0);
	memset(&serv_adr, 0, sizeof(serv_adr));
	serv_adr.sin_family = AF_INET;
	serv_adr.sin_addr.s_addr(htonl(INADDR_ANY));
	serv_adr.sin_port = htons(atoi(argv[1]));

	if (bind(serv_sock, (struct sockaddr *)&serv_adr, sizeof(serv_adr)) == -1)
		error_handling("bind() error");
	if (listen(serv_sock, 5) == -1)
		error_handling("listen() error");

	// 서버 소켓을 fd_set에 저장
	FD_ZERO(&reads);
	FD_SET(serv_sock, &reads);
	fd_max = serv_sock;

	while (1)
	{
		// select의 블록 시간 == 5초
		cpy_reads = reads;
		timeout.tv_sec = 5;
		timeout.tv_usec = 5000;

		if ((fd_num = select(fd_max + 1, &cpy_reads, 0, 0, &timeout)) == -1)
			break ;
		if (fd_num == 0)
			continue ;

		for (int i = 0; i < fd_max + 1; i++)
		{
			// 이벤트가 발생한 fd인가?
			if (FD_ISSET(i, &cpy_reads))
			{
				// 이벤트가 발생한 소켓이 서버 소켓일 때
				// 서버 소켓에 전달되는 클라이언트의 연결 요청도 엄연한 입력이다.
				// 서버 소켓에 read 이벤트가 발생하면 클라이언트로부터 접속 요청을 받았다고 간주할 수 있다.
				// 그러므로 새로운 클라이언트와 연결하는 절차를 진행한다.
				if (i == serv_sock) // connection request!
				{
					adr_sz = sizeof(clnt_adr);
					clnt_sock = accept(serv_sock, (struct sockaddr *)&clnt_adr, &adr_sz);
					FD_SET(clnt_sock, &reads);
					if (fd_max < clnt_sock)
						fd_max = clnt_sock;
					printf("connected client: %d \n", clnt_sock);
				}
				else // read message!
				{
					str_len = read(i, buf, BUF_SIZE);
					// 소켓이 close될때 연결된 소켓이 있으면 해당 소켓에 eof를 전달한다.
					// eof를 받으면 read는 0을 반환한다.
					// 따라서 read가 0을 반환하면 접속이 끊겼다고 간주한다.
					if (str_len == 0) // close request!
					{
						FD_CLR(i, &reads);
						close(i);
						printf("closed client: %d \n", i);
					}
					// 메세지를 수신받은 경우 echo한다.
					else
					{
						write(i, buf, str_len); // echo!
					}
				}
			}
		}
	}
	close(serv_sock);
	return (0);
}

void error_handling(char *buf)
{
	fputs(buf, stderr);
	fputc('\n', stderr);
	exit(1);
}

```

---

참고자료

#참고도서/윤성우의_열혈_TCP_IP_소켓_프로그래밍 

---

