---
title: 'C++ 언어의 bool 자료형'
tags:
  - 'language/cpp'
---

#### true와 false 키워드

C 언어와 C++ 언어 모두 정수 '0'을 거짓을 의미하는 숫자로, '0'을 제외한 모든 숫자를 참으로 규정한다. C 언어에서는 참과 거짓의 표현을 위해서 다음과 같이 상수를 정의하는 것이 보통이다.

```cpp

#define TRUE 1
#define FALSE 0

```

그러나 C++ 언어에서는 true와 false 키워드를 지원하므로 참과 거짓을 좀 더 직관적으로 표현할 수 있다.

true와 false 키워드는 정수형으로 변환하여 출력하면 각각 1과 0을 출력한다.

```cpp

std::cout<<"true: "<<true<<endl; //1 출력
std::cout<<"false: "<<false<<endl; //0 출력

```

그러나 true와 false는 1과 0이 아니며, '참'과 '거짓'을 표현하기 위한 1바이트 크기의 데이터일 뿐이다. 따라서 이 둘을 출력하거나 정수의 형태로 형 변환하는 경우에 각각 1과 0으로 변환하도록 정의되어 있을 뿐이다.

따라서 true와 false는 그 자체를 '참'과 '거짓'을 나타내는 목적으로 인식하는 것이 바람직하다.

#### bool 자료형

**bool**은 true와 false 데이터를 저장하기 위해 정의되어 있는 자료형이다.
아래와 같이 사용될 수 있다.

```cpp

bool IsPositive(int num)
{
	if (num <= 0)
		return false;
	else
		return true;
}

```

---

참고자료

#참고도서/윤성우의_열혈_cpp_프로그래밍

---

