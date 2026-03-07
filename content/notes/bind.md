---
title: '*소켓에 인터넷 주소를 할당*'
tags:
  - 'network'
  - 'language/c'
  - 'socket_programming'
  - 'linux/system_call'
---

```c
#include <sys/socket.h>

int bind(int sockfd, struct sockaddr *myaddr, socklen_t addrlen);
```

- sockfd : 주소 정보를(IP와 PORT를) 할당할 소켓의 파일 디스크립터
- myaddr : 할당하고자 하는 주소 정보를 지니는 구조체 변수의 주소 값.
- addrlen : 두 번째 인자로 전달된 구조체 변수의 길이 정보.
+ 반환값 : 성공 시 0, 실패 시 -1 반환

bind()를 통해 IP 주소와 PORT 번호를 얻은 소켓은 해당 포트로 전송되는 모든 데이터를 수신하게 된다.

특이 사항으로 [[sockaddr_in#^917553 | sockaddr]] 구조체는 매우 사용하기 불편하므로 보통 [[sockaddr_in]] 타입 변수의 주소를 형변환으로 변환시켜 사용한다.

---

참고자료

#참고도서/윤성우의_열혈_TCP_IP_소켓_프로그래밍

---

