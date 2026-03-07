---
title: 'friend 선언'
tags:
  - 'language/cpp'
---

friend 선언은 다음의 기능을 하는 키워드이다.

	A 클래스가 B 클래스를 대상으로 friend 선언을 하면, B 클래스는 A 클래스의 private 멤버에 직접 접근이 가능하다.

단, A 클래스도 B 클래스의 private 멤버에 직접 접근이 가능하려면 B 클래스가 A 클래스를 대상으로 friend 선언을 해줘야 한다.

friend 키워드는 다음과 같이 사용된다.

```cpp

class Boy
{
	private :
		int height;
		friend class Girl; //Girl 객체를 friend로 선언
	public :
		Boy(int len) : height(len) {}
		. . . . .
};

```

friend 키워드는 다음의 특징을 가진다.

1. friend 선언은 클래스 내 어디에든 위치할 수 있다.(private, public, protected 모두에 위치할 수 있다는 뜻.)
2. 다음의 구문은 아직 Girl 클래스가 선언되지 않은 상태에서도 정상적으로 컴파일 된다.

`friend class Girl;`

- 왜냐하면 이 구문은 다음 두 가지 의미를 동시에 내포하기 떄문이다.
	- Girl은 클래스의 이름이다.
	- 그리고 바로 그 Girl 클래스를 friend로 선언한다.

3. friend 선언은 다음과 같이 클래스의 특정 멤버 함수에 한하여 사용될 수 있다.

`friend Point PointOP::PointAdd(const Point&, const Point&);`

4. 또한 friend 선언은 다음과 같이 일반 함수에 대해서도 사용할 수 있다.

`friend void ShowPointPos(const Point&);`

+ 3번, 4번 케이스의 경우, friend 선언에 함수의 원형 선언이 포함되어 있으므로 friend 선언을 위해서 별도의 함수원형을 선언할 필요는 없다.

---

참고자료

#참고도서/윤성우의_열혈_cpp_프로그래밍

---
