---
title: 'explicit 키워드'
tags:
  - 'language/cpp'
---

C++ 언어에서는 대입 연산자를 사용하여 객체 간 복사를 할 수 있다. [^1]

`SoSimple sim2 = sim1;`

이러한 구문은 아래와 같이 묵시적 변환되어 처리된다.

`SoSimple sim2(sim1);`

이러한 묵시적 변환은 객체 간 복사에서만 일어나지 않는다. 단순히 객체를 초기화할 때도 대입 연산자를 사용할 수 있으며, 묵시적 변환이 일어난다.

`AAA obj = 3; // AAA obj(3); 으로 변환됨`

explicit 키워드는 이러한 묵시적 변환을 막기 위해 사용된다. 복사 생성자에 explicit 키워드가 붙어있는 객체는 묵시적 변환이 허용되지 않아 대입 연산자를 사용하여 객체 간 복사 및 초기화를 할 수 없다.

```cpp

explicit SoSimple(const SoSimple &copy) : num1(copy.num1), num2(copy.num2)
{
	//empty!!
}

```


---

참고자료

#참고도서/윤성우의_열혈_cpp_프로그래밍


[^1]: [[복사 생성자]] 참고

