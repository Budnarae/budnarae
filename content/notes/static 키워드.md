---
title: 'static 키워드'
tags:
  - 'language/cpp'
---

기존의 C 언어에서 static 키워드는 다음의 의미를 가진다.

- 전역 변수에 선언된 static의 의미 -> 선언된 파일 내에서만 참조를 허용하겠다는 의미
- 함수 내에 선언된 static의 의미 -> 한번만 초기화되고, 지역변수와 달리 함수를 빠져나가도 소멸되지 않는다.

C++에서 static 키워드는 추가적으로 다음의 의미를 가진다.

1. static 키워드가 멤버 변수에 붙은 경우
	- static 멤버변수는 **클래스 매개변수**라고도 한다. 일반적인 멤버변수와 달리 클래스당 하나씩만 생성되기 때문이다.
	- static 변수는 클래스의 객체가 생성되지 않아도 전역 변수와 같이 메모리 공간에 할당된다.
	- 만일 객체가 여러 개 생성된다면 여러 개의 객체가 하나의 static 변수를 공유한다.
	- static 함수의 소멸 시점은 전역 변수와 동일하다.
	- static 멤버변수는 적어도 한번은 초기화되어야 하며, 초기화는 생성자 내부가 아닌 곳에서 별도로 이루어져야 한다.
	- static 멤버변수가 public으로 선언된 경우, 객체를 통하지 않아도 다음과 같이 접근이 가능하다.
		- `cout<<SoSimple::simObjcnt;`

*static 멤버변수를 선언하는 예제코드*

```cpp

class SoSimple
{
	private :
		static int simObjCnt; //static 멤버변수, 클래스 변수
	public :
		SoSimple()
		{
			simObjCnt++;
			cout<<simObjCnt<<"번째 SoSimple 객체"<<endl;
		}
};
int SoSimple::simObjCnt = 0; //static 멤버 변수의 초기화. static 멤버 변수는 반드시 단 한번은 초기화가 이루어져야 한다.

```

![[static 멤버변수.png]]

2. static 키워드가 멤버 함수에 붙은 경우
	- 선언된 클래스의 모든 객체가 공유한다.
	- public으로 선언이 되면, 클래스의 이름을 이용해서 호출이 가능하다.
	- 객체의 멤버로 존재하는 것이 아니다.
		- 따라서 객체의 멤버변수에 접근할 수 없다.
		- 객체의 생성 이전에도 호출할 수 있다.
		- -> static 멤버함수 내에서는 static 멤버변수와 static 멤버함수만 호출이 가능하다.

3. const static 멤버의 경우
	- 클래스 내에 선언된 [[const]] 멤버변수의 경우, [[멤버 이니셜라이저]]의 도움을 받아 초기화해야 한다. 그러나 const static 멤버변수의 경우 다음과 같이 선언과 동시에 초기화할 수 있다.

```cpp

#include <iostream>
using namespace std;

class countryArea
{
	public :
		const static int RUSSIA = 1707540;
		const static int CANADA = 998467;
		const static int CHINA  = 957290;
		const static int SOUTH_KOREA = 9922;
};

int main(void)
{
	cout<<"러시아 면적: "<<CountryArea::RUSSIA<<"km"<<endl;
	cout<<"캐나다 면적: "<<CountryArea::CANADA<<"km"<<endl;
	cout<<"중국 면적: "<<CountryArea::CHINA<<"km"<<endl;
	cout<<"한국 면적: "<<CountryArea::SOUTH_KOREA<<"km"<<endl;
}

```

---

참고자료

#참고도서/윤성우의_열혈_cpp_프로그래밍

---
