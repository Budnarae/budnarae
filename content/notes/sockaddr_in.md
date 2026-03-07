---
title: 'sockaddr_in'
tags:
  - 'network'
  - 'language/c'
  - 'socket_programming'
  - 'linux'
---

sockaddr_in  구조체는 아래의 형태를 가지며, [[bind]]에 주소 정보를 전달하는 용도로 사용된다.

```C
struct sockaddr_in
{
	sa_family_t    sin_family;
	uint16_t       sin_port;
	struct in_addr sin_addr;
	char           sin_zero[8];
}
```

```C
struct in_addr
{
	in_addr_t      s_addr; //32비트 IPv4 인터넷 주소
}
```

|   member   |      type      | typedef |                                 의미                                 |    예시     |
|:----------:|:--------------:|:-------:|:--------------------------------------------------------------------:|:-----------:|
| sin_family |  sa_family_t   | uint8_t |                       주소체계(address Family)                       |   AF_INET   |
|  sin_port  |    uint16_t    |         |                       16비트 TCP/UDP PORT 번호                       | htons(port) |
|  sin_addr  | struct in_addr |         |                            32비트 IP 주소                            |    후술     |
|  sin_zero  |    char[8]     |         | 실질적인 의미가 없으며 구조체의 크기를 sockaddr과 통일하기 위해 사용 |             |

uint8_t와 같은 **POSIX(Portable Operating System Interpace)** 자료형을 사용하는 이유는 어떠한 경우에도 고정된 바이트 자료형임을 보장받기 위해서이다.

#### sin_family

**sin_family**에는 아래의 표를 참조하여 프로토콜이 사용하는 주소체계를 저장한다.

| 주소체계(Address Family) | 의미                                        |
| ------------------------ | ------------------------------------------- |
| AF_INET                  | IPv4 인터넷 프로토콜에 적용하는 주소체계    |
| AF_INET6                 | IPv6 인터넷 프로토콜에 적용하는 주소체계    |
| AF_LOCAL                 | 로컬 통신을 위한 유닉스 프로토콜의 주소체계 | 

#### sin_port

16비트 port 번호를 저장한다. 단, [[htons]]를 사용하여 ==[[네트워크 바이트 순서]]==로 저장해야 한다.

#### sin_addr

^d7a9de

32비트 IP주소 정보를 저장한다. 이 역시 [[inet_addr]] 또는 [[inet_aton]]을 사용하여 [[네트워크 바이트 순서]]로 저장해야 한다. 이 멤버를 정확히 파악하기 위해서는 구조체 in_addr도 함께 살펴봐야 한다. 그런데 구조체 in_addr의 유일한 멤버가 unit32_t로 선언되어 있으니, 간단히 32비트 정수자료형으로 인식해도 괜찮다.

#### sin_zero

아무런 의미를 가지지 않는다. 단순히 구조체 sockaddr_in의 크기를 구조체 sockaddr와 일치시키기 위해 삽입된 멤버이다. 그러나 반드시 0으로 채워야 한다. 만약에 0으로 채우지 않으면 원하는 결과를 얻지 못한다. sockaddr에 대해서는 후술한다.

#### sockaddr

^917553

sockaddr은 아래와 같은 형태의 구조체이다.

```C

struct sockaddr
{
	sa_family_t sin_family;  // 주소체계(Address Family)
	// 주소정보. IP 주소와 PORT 번호를 형식에 맞게 입력하고 남은 공간은 0으로 채워야한다.
	char        sa_data[14];
}

```

sockaddr_in은 [[bind]]에 전달하기 위한 구조체라고 설명하였지만, 본래 bind()에는 sockaddr 구조체를 전달하여야 한다. 그러나 sockaddr은 sa_data에 IP 주소와 port 번호를 bit 단위로 조작하여 넣어야 하기 때문에 매우 불편하다. 따라서 sockaddr_in에서 sa_data를 sin_port(포트), sin_addr(IP 주소), sin_zero(남은 공간을 0으로 채움)의 형태로 나누어 입력할 수 있도록 고친 후, 형변환을 사용하여 아래와 같이 sockaddr 구조체의 주소형으로 변환하여 넘긴다. sockaddr_in에 sin_zero가 들어가는 이유도 구조체의 크기가 동일해야 주소를 통해 접근했을 때 sockaddr과 동일한 효과를 얻을 수 있기 때문이다.

```C
if (bind(serv_scok, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) == -1)
	error_handling("bind() error");
```

---

참고자료

#참고도서/윤성우의_열혈_TCP_IP_소켓_프로그래밍

---
