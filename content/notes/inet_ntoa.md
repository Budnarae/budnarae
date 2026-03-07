---
title: '*inet_ntoa*'
tags:
  - 'network'
  - 'language/c'
  - 'socket_programming'
  - 'linux'
---

[[inet_addr]], [[inet_aton]]의 반대 기능을 하는 함수이다.
네트워크 바이트 순서로 정렬된 32비트 정수를 입력하면 문자열 형태로 표현된 ip 주소를 반환한다.

```C
#include <arpa/inet.h>

//성공 시 변환된 문자열의 주소 값, 실패 시 -1 반환
char *inet_ntoa(struct in_addr adr);
```

참고로 inet_ntoa가 반환하는 메모리 주소는 inet_ntoa에 내부적으로 할당된 메모리 공간이다. inet_ntoa가 재호출되면 이전에 할당한 메모리 주소를 지우고 새로운 메모리 주소를 할당하기 때문에, inet_ntoa가 반환한 문자열 정보를 다른 문자열 공간에 복사해 두는 것이 좋다.

---

참고자료

#참고도서/윤성우의_열혈_TCP_IP_소켓_프로그래밍

---

