
---

#network #language/c #socket_programming #linux

*htons는 [[호스트 바이트 순서 | host network byte order]] to [[네트워크 바이트 순서 | network byte order]] - short variable의 약자이다.*

---

[[sockaddr_in]]에 port 번호를 저장할 때에는 [[네트워크 바이트 순서]]로 저장해야 한다. htons는 port 번호의 **바이트 순서 변환(Endian Conversions)**을 지원한다.

```C

/* 기능 : port 번호의 바이트 순서 변환
*  매개인자 : port 번호
*  반환값 : 빅 엔디안으로 변환된 port 번호
*/
unsigned short htons(unsigned short);

```

htons의 형제격으로 아래의 함수들이 있다. 자주 쓰이지는 않지만 참고하자.

```C

// network byte order to host byte order - short variable
unsigned short ntohs(unsigned short);
// host byte order to network byte order - long variable
unsigned long  htonl(unsigned long);
// network byte order to host byte order - long variable
unsigned long  ntohl(unsigned long);

```

^84391e

---

참고자료

#참고도서/윤성우의_열혈_TCP_IP_소켓_프로그래밍

---
