---
title: 'inet_aton'
tags:
  - 'network'
  - 'language/c'
  - 'socket_programming'
  - 'linux'
---

inet_aton은 [[inet_addr]]과 동일한 기능을 수행한다. 차이점은 변환된 ip 주소를 반환하지 않고 두 번째 인자로 전달받은 in_addr 구조체에 저장한다는 점이다.

```C
#include <arpa/inet.h>

// 성공 시 1(true) 실패 시 0(false) 반환
int inet_aton(const char *string, struct in_addr *addr);
```

---

참고자료

#참고도서/윤성우의_열혈_TCP_IP_소켓_프로그래밍

---
