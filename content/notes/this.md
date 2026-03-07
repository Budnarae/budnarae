
---

#language/cpp

---

멤버함수 내에서는 this라는 이름의 포인터를 사용할 수 있는데, 이는 객체 자신을 가리키는 용도로 사용되는 포인터이다. this 포인터는 그 주소 값과 자료형이 정해져 있지 않으며 객체 스스로가 저장되어 있는 주소를 가리킨다.

this 포인터는 주로 멤버 변수의 이름과 멤버 함수의 지역 변수의 이름이 같을 때, 이 둘을 구별하기 위해 사용된다. 아래의 예제를 참고하자.

```cpp

class ThisClass
{
	private : 
		int num; //멤버 변수와
	public : 
		void ThisFunc(int num) //멤버 함수의 매개변수의 이름이 같다.
		{
			this->num = 207; //this 포인터는 함수의 매개변수를 가리키지 않으므로 이를 이용하여 구별이 가능하다.
			num = 105;
		}
	. . . .
};

```

이러한 this 포인터의 특징을 사용하면 멤버 변수와 멤버 함수(주로 getter 또는 setter)의 매개변수, 지역변수의 이름을 다르게 지을 필요가 없다.

```cpp

#include <iostream>

using namespace std;

class TwoNumber
{
	private :
		int num1;
		int num2;
	public :
		TwoNumber(int num1, int num2)
		{
			this->num1 = num1;
			this->num2 = num2;
		}
		//TwoNumber(int num1, int num2) : num1(num1), num2(num2) {}
		void ShowTwoNumber()
		{
			cout<<this->num1<<endl;
			cout<<this->num2<<endl;
		}
};

int main(void)
{
	TwoNumber two(2, 4);
	two.ShowTwoNumber();

	return (0);
}

```

또한, this 포인터를 사용하여 객체 자신을 참조자를 반환하는 구분을 작성할 수 있다. 이러한 참조자를 **Self-Reference**라 한다.

```cpp

#include <iostream>

using namespace std;

class SelfRef
{
	private :
		int num;
	public :
		SelfRef(int n) : num(n)
		{
			cout<<"객체생성"<<endl;
		}
		SelfRef &Adder(int n)
		{
			num += n;
			return *this;
		}
		SelfRef &ShowTwoNumber()
		{
			cout<<num<<endl;
			return *this;
		}
};

int main(void)
{
	SelfRef obj(3);
	SelfRef &ref = obj.Adder(2);
	
	obj.ShowTwoNumber();
	ref.ShowTwoNumber();
	ref.Adder(1).ShowTwoNumber().Adder(2).ShowTwoNumber();

	return (0);
}

```

---

참고자료

#참고도서/윤성우의_열혈_cpp_프로그래밍

---
