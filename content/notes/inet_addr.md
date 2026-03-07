---
title: 'inet_addr'
tags:
  - 'network'
  - 'language/c'
  - 'socket_programming'
  - 'linux'
---

[[sockaddr_in#^d7a9de | sockaddr_in]]의 멤버 sin_addr에는 32비트 정수형으로 ip 주소를 저장해야 한다.  **inet_addr**은 **aaa.bbb.ccc.ddd** 꼴의 문자열로 표현된 ip 주소를  32비트 정수로 변환하는 번거로운 작업을 수행한다. 또한, 변환 과정에서 [[네트워크 바이트 순서]]로의 변환도 동시에 지원한다.

```C
#include <arpa/inet.h>

/* 입력값 : 문자열로 표현된 ip 주소
*  반환값 : 성공 시 빅엔디안으로 변환된 32비트 정수 값, 실해 시 INADDR_NONE 반환
*/
in_addr_t inet_addr(const char *string);
```

비슷한 기능을 수행하는 함수로 [[inet_aton]]이 있다.
만약 네트워크 바이트 순서로 정렬된 32비트 정수로부터 문자열 형태로 표현된 ip 주소를 얻고 싶다면 [[inet_ntoa]]를 사용하면 된다.

---

참고자료

#참고도서/윤성우의_열혈_TCP_IP_소켓_프로그래밍

---
